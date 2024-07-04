//
//  OdemeSayfasi.swift
//  ShoppingApp
//
//  Created by Gizemnur Özden on 29.06.2024.
//
import UIKit
import Firebase

class OdemeSayfasi: UIViewController {
    
    @IBOutlet weak var kullaniciAdiLabel: UILabel!
    @IBOutlet weak var odemeYontemiLabel: UILabel!
    @IBOutlet weak var adresText: UITextField!
    @IBOutlet weak var odemeYontemiUI: UISegmentedControl!
    @IBOutlet weak var kartİsim: UITextField!
    @IBOutlet weak var kartNumara: UITextField!
    @IBOutlet weak var kartAy: UITextField!
    @IBOutlet weak var kartYil: UITextField!
    @IBOutlet weak var kartCvv: UITextField!
    
    let db = Firestore.firestore()
    var toplamFiyat: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let currentUser = Auth.auth().currentUser {
            kullaniciAdiLabel.text = currentUser.displayName ?? "Kullanıcı Adı Yok"
        }

        odemeYontemiUI.selectedSegmentIndex = 1
        kartFieldsEnabled(false)

        odemeYontemiUI.addTarget(self, action: #selector(odemeYontemiDegisti(_:)), for: .valueChanged)
    }

    @objc func odemeYontemiDegisti(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            kartFieldsEnabled(true)
        } else {
            kartFieldsEnabled(false)
        }
    }

    func kartFieldsEnabled(_ isEnabled: Bool) {
        kartİsim.isEnabled = isEnabled
        kartNumara.isEnabled = isEnabled
        kartAy.isEnabled = isEnabled
        kartYil.isEnabled = isEnabled
        kartCvv.isEnabled = isEnabled
    }

    @IBAction func siparisimiTamamlaTiklandi(_ sender: Any) {
        guard let kullaniciAdi = kullaniciAdiLabel.text,
              let adres = adresText.text, !adres.isEmpty else {
            let alert = UIAlertController(title: "Eksik Bilgi", message: "Lütfen adres bilgilerini doldurun.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
            return
        }
        
        if let currentUser = Auth.auth().currentUser {
            kaydetSiparisVeTemizleSepet(kullanici: currentUser, kullaniciAdi: kullaniciAdi, adres: adres)
        }
    }

    func kaydetSiparisVeTemizleSepet(kullanici: User, kullaniciAdi: String, adres: String) {
        let firestore = Firestore.firestore()
        firestore.collection("Sepet").getDocuments { (snapshot, error) in
            if let error = error {
                print("Hata: Sepet verileri alınırken \(error.localizedDescription)")
            } else {
                guard let documents = snapshot?.documents else {
                    print("Hata: Sepet verileri bulunamadı.")
                    return
                }
                
                let cartItems = documents.map { document in
                    let data = document.data()
                    return [
                        "urunId": data["urunId"] as? String ?? "",
                        "ad": data["ad"] as? String ?? "",
                        "resim": data["resim"] as? String ?? "",
                        "fiyat": data["fiyat"] as? Double ?? 0.0,
                        "secilenBeden": data["secilenBeden"] as? String ?? "",
                        "adet": data["adet"] as? Int ?? 1
                    ]
                }
                
                let orderData: [String: Any] = [
                    "kullaniciAdi": kullaniciAdi,
                    "adres": adres,
                    "urunler": cartItems,
                    "siparisTarihi": Timestamp(date: Date()),
                    "kullaniciMaili": kullanici.email ?? ""
                ]
                
                firestore.collection("GelenSiparisler").addDocument(data: orderData) { error in
                    if let error = error {
                        print("Sipariş kaydedilirken hata oluştu: \(error.localizedDescription)")
                    } else {
                        print("Sipariş başarıyla kaydedildi.")
                        self.sepetiTemizle()
                    }
                }
            }
        }
    }

    func sepetiTemizle() {
        let firestore = Firestore.firestore()
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
                
                // Sepet temizlendikten sonra ana sayfaya yönlendir
                self.performSegue(withIdentifier: "goToAnasayfa", sender: nil)
            }
        }
    }
}
