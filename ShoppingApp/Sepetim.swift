//
//  Sepetim.swift
//  ShoppingApp
//
//  Created by Gizemnur Özden on 11.05.2024.
//
import UIKit
import FirebaseFirestore
import FirebaseAuth

class Sepetim: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalFiyat: UILabel!
    
    var sepetUrunleri = [Sepet]() // Sepet ürünlerini tutacak dizi
    var firestore: Firestore!
    var totalPrice: Double = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.separatorColor = UIColor(white: 0.95, alpha: 1)
        
        firestore = Firestore.firestore()
        
        fetchSepetUrunleri()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchSepetUrunleri()
    }
    
    func fetchSepetUrunleri() {
        firestore.collection("Sepet").getDocuments { (snapshot, error) in
            if let error = error {
                print("Hata: Sepet verileri alınırken \(error.localizedDescription)")
            } else {
                guard let documents = snapshot?.documents else {
                    print("Hata: Sepet verileri bulunamadı.")
                    return
                }

                self.sepetUrunleri = documents.compactMap { document in
                    let data = document.data()
                    let documentId = document.documentID
                    let urunId = data["urunId"] as? String ?? ""
                    let ad = data["ad"] as? String ?? ""
                    let resim = data["resim"] as? String ?? ""
                    let fiyat = data["fiyat"] as? Double ?? 0.0
                    let secilenBeden = data["secilenBeden"] as? String ?? ""
                    let adet = data["adet"] as? Int ?? 1

                    return Sepet(documentId: documentId, urunId: urunId, ad: ad, resim: resim, fiyat: fiyat, secilenBeden: secilenBeden, adet: adet)
                }
                
                self.updateTotalPrice()
                self.tableView.reloadData()
            }
        }
    }

    func updateTotalPrice() {
        totalPrice = sepetUrunleri.reduce(0.0) { $0 + ($1.fiyat * Double($1.adet)) }
        totalFiyat.text = "Toplam: \(totalPrice) $" // UI elementini güncelle
    }
    
    @IBAction func alisverisiTamamla(_ sender: Any) {
        // Kullanıcının giriş yapıp yapmadığını kontrol edin
        if let currentUser = Auth.auth().currentUser {
            kaydetSepetVeTamamlaSiparis(kullanici: currentUser)
        } else {
            let alert = UIAlertController(title: "Giriş Yapın", message: "Ödeme işlemini gerçekleştirmek için lütfen giriş yapın.", preferredStyle: .alert)
            let loginAction = UIAlertAction(title: "Giriş Yap", style: .default) { _ in
                self.performSegue(withIdentifier: "goToGirisSayfasi", sender: nil)
            }
            let cancelAction = UIAlertAction(title: "İptal", style: .cancel, handler: nil)
            
            alert.addAction(loginAction)
            alert.addAction(cancelAction)
            
            present(alert, animated: true, completion: nil)
        }
    }
    func kaydetSepetVeTamamlaSiparis(kullanici: User) {
        let cartItems = sepetUrunleri.map { sepetUrun in
            return [
                "urunId": sepetUrun.urunId,
                "ad": sepetUrun.ad,
                "resim": sepetUrun.resim,
                "fiyat": sepetUrun.fiyat,
                "secilenBeden": sepetUrun.secilenBeden,
                "adet": sepetUrun.adet
            ]
        }
        
        let orderData: [String: Any] = [
            "kullaniciAdi": kullanici.displayName ?? "",
            "kullaniciMaili": kullanici.email ?? "",
            "adres": "", // Bu kısmı boş bırakıyoruz, çünkü adres burada girilmeyecek
            "urunler": cartItems,
            "siparisTarihi": Timestamp(date: Date()),
        ]
        
        firestore.collection("GelenSiparisler").addDocument(data: orderData) { error in
            if let error = error {
                print("Sipariş kaydedilirken hata oluştu: \(error.localizedDescription)")
            } else {
                print("Sipariş başarıyla kaydedildi.")
                self.sepetiTemizleVeYonlendirOdemeSayfasina(adres: "", kullanici: kullanici)
            }
        }
    }

    func sepetiTemizleVeYonlendirOdemeSayfasina(adres: String, kullanici: User) {
        firestore.collection("Sepet").getDocuments { (snapshot, error) in
            if let error = error {
                print("Hata: Sepet verileri silinirken \(error.localizedDescription)")
            } else {
                guard let documents = snapshot?.documents else {
                    print("Hata: Sepet verileri bulunamadı.")
                    return
                }
                
                for document in documents {
                    document.reference.delete()
                }
                
                self.sepetUrunleri.removeAll()
                self.updateTotalPrice()
                self.tableView.reloadData()
                
                // Ödeme sayfasına gitmek için geçiş yap
                self.performSegue(withIdentifier: "goToOdemeSayfasi", sender: nil)
            }
        }

    }
    
    @IBAction func sepetiTemizle(_ sender: Any?) {
        let alert = UIAlertController(title: "Sepeti Temizle", message: "Sepeti temizlemek istediğinize emin misiniz?", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Evet", style: .destructive) { _ in
            self.firestore.collection("Sepet").getDocuments { (snapshot, error) in
                if let error = error {
                    print("Hata: Sepet verileri silinirken \(error.localizedDescription)")
                } else {
                    guard let documents = snapshot?.documents else {
                        print("Hata: Sepet verileri bulunamadı.")
                        return
                    }
                    
                    for document in documents {
                        document.reference.delete()
                    }
                    
                    self.sepetUrunleri.removeAll()
                    self.updateTotalPrice()
                    self.tableView.reloadData()
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Hayır", style: .cancel, handler: nil)
        
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
}

extension Sepetim: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sepetUrunleri.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sepetHucre", for: indexPath) as! SepetimHucre
        
        let sepetUrun = sepetUrunleri[indexPath.row]
        cell.urunAd.text = sepetUrun.ad
        cell.urunFiyat.text = "\(sepetUrun.fiyat) $"
        cell.bedenSecim.text = sepetUrun.secilenBeden
        cell.urunAdedi.text = "\(sepetUrun.adet)"
        
        if let url = URL(string: sepetUrun.resim) {
            cell.imageViewSepetim.kf.setImage(with: url)
        } else {
            cell.imageViewSepetim.image = UIImage(named: "placeholder")
        }
        
        cell.urunAdedim = sepetUrun.adet
        cell.documentId = sepetUrun.documentId
        cell.parentViewController = self
        
        return cell
    }
    
    // Sepet Hücre Silme İşlevi
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let urun = sepetUrunleri[indexPath.row]
            
            // Kullanıcıdan onay almak için uyarı mesajı
            let alert = UIAlertController(title: "Ürünü Sil", message: "Bu ürünü sepetinizden silmek istediğinize emin misiniz?", preferredStyle: .alert)
            
            // Onayla butonu
            let confirmAction = UIAlertAction(title: "Evet", style: .destructive) { _ in
                // Firestore'dan öğeyi silme
                self.firestore.collection("Sepet").document(urun.documentId).delete { error in
                    if let error = error {
                        print("Error removing document: \(error)")
                    } else {
                        print("Document successfully removed!")
                        
                        // Modeli güncelle
                        self.sepetUrunleri.remove(at: indexPath.row)
                        
                        // Toplam fiyatı güncelle
                        self.updateTotalPrice()
                        
                        // TableView'u güncelle
                        tableView.deleteRows(at: [indexPath], with: .automatic)
                    }
                }
            }
            
            // İptal butonu
            let cancelAction = UIAlertAction(title: "Hayır", style: .cancel, handler: nil)
            
            alert.addAction(confirmAction)
            alert.addAction(cancelAction)
            
            present(alert, animated: true, completion: nil)
        }
    }
}
