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
        
        // Firestore referansı oluştur
        firestore = Firestore.firestore()
        
        // Firestore'dan sepet verilerini getir
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
                
                // Firestore'dan gelen belgeleri SepetUrun nesnelerine dönüştür
                self.sepetUrunleri = documents.compactMap { document in
                    let data = document.data()
                    let urunId = data["urunId"] as? String ?? ""
                    let ad = data["ad"] as? String ?? ""
                    let resim = data["resim"] as? String ?? ""
                    let fiyat = data["fiyat"] as? Double ?? 0.0
                    let secilenBeden = data["secilenBeden"] as? String ?? ""
                    
                    return Sepet( urunId: urunId, ad: ad, resim: resim, fiyat: fiyat, secilenBeden: secilenBeden)
                }
                
                // Toplam fiyatı güncelle
                self.updateTotalPrice()
                
                // TableView'ı güncelle
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func alisverisiTamamla(_ sender: Any) {
        // Kullanıcının giriş yapıp yapmadığını kontrol edin
               if Auth.auth().currentUser != nil {
                   // Kullanıcı giriş yapmışsa ödeme sayfasına yönlendir
                   performSegue(withIdentifier: "goToOdemeSayfasi", sender: nil)
               } else {
                   // Kullanıcı giriş yapmamışsa uyarı göster
                   let alert = UIAlertController(title: "Giriş Yapın", message: "Ödeme işlemini gerçekleştirmek için lütfen giriş yapın.", preferredStyle: .alert)
                   let loginAction = UIAlertAction(title: "Giriş Yap", style: .default) { _ in
                       self.performSegue(withIdentifier: "goToGirisSayfasi", sender: nil)
                       // Giriş sayfasına yönlendirme işlemini burada gerçekleştirin
                   }
                   let cancelAction = UIAlertAction(title: "İptal", style: .cancel, handler: nil)
                   
                   alert.addAction(loginAction)
                   alert.addAction(cancelAction)
                   
                   present(alert, animated: true, completion: nil)
               }
        // Segue hazırlığı
        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
               if segue.identifier == "goToOdemeSayfasi" {
                   // Ödeme sayfasına geçiş yapılırken gerekli verileri burada aktarabilirsiniz
               }
           }
    }
    
    func updateTotalPrice() {
        
           totalPrice = sepetUrunleri.reduce(0.0) { $0 + $1.fiyat }
           totalFiyat.text = "Toplam: \(totalPrice) $" // UI elementini güncelle
       }
    
    @IBAction func sepetiTemizle(_ sender: Any) {
        
        // Kullanıcıdan onay almak için uyarı mesajı
              let alert = UIAlertController(title: "Sepeti Temizle", message: "Sepeti temizlemek istediğinize emin misiniz?", preferredStyle: .alert)
              
              // Onayla butonu
              let confirmAction = UIAlertAction(title: "Evet", style: .destructive) { _ in
                  // Sepeti temizleme işlemi
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
                          
                          // Lokal diziyi temizle
                          self.sepetUrunleri.removeAll()
                          
                          // Toplam fiyatı sıfırla
                          self.totalPrice = 0.0
                          self.totalFiyat.text = "Toplam: \(self.totalPrice) $"
                          
                          // TableView'ı güncelle
                          self.tableView.reloadData()
                      }
                  }
              }
              
              // İptal butonu
              let cancelAction = UIAlertAction(title: "Hayır", style: .cancel, handler: nil)
              
              // Uyarı mesajına butonları ekle
              alert.addAction(confirmAction)
              alert.addAction(cancelAction)
              
              // Uyarı mesajını göster
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
        cell.bedenSecim.text = "\(sepetUrun.secilenBeden) bedeni seçtiniz"
        
        // Resimleri yüklemek için Kingfisher kütüphanesi kullanımı
        if let resimUrl = URL(string: sepetUrun.resim) {
            cell.imageViewSepetim.kf.setImage(with: resimUrl)
        }
        
        return cell
    }
}
