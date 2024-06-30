//
//  kayitOl.swift
//  ShoppingApp
//
//  Created by Ogün Minkara on 22.05.2024.
//
//kayıt için  Firebase auth işlemlerinin tümü burada yapılacak.
import UIKit
 
import Firebase

 

class kayitOl: UIViewController {

    @IBOutlet weak var adinizText: UITextField!
    
    @IBOutlet weak var soyadinizText: UITextField!
      
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var telefonText: UITextField!
    
    @IBOutlet weak var sifreText: UITextField!
    
    
    override func viewDidLoad() {
            super.viewDidLoad()
        }

        // kaydol butonunun işlevleri
        @IBAction func kaydolButonu(_ sender: Any) {
            if emailText.text != "" && sifreText.text != "" {
                   Auth.auth().createUser(withEmail: emailText.text!, password: sifreText.text!) { (authata , error) in
                       if error != nil {
                           self.uyariMesaj(titleInput: "Hata", messageInput: error?.localizedDescription ?? "Hata")
                       } else {
                           guard let user = authata?.user else { return }
                           self.telefonNoKaydet(userID: user.uid, phoneNumber: self.telefonText.text!)
                 // email doğrulama kodları
                           user.sendEmailVerification(completion: { (error) in
                               if let error = error {
                                   print("Doğrulama maili gönderilemedi \(error.localizedDescription)")
                               } else {
                                   print("Doğrulama maili başarıyla gönderildi")
                               }
                           })
                           self.performSegue(withIdentifier: "kayitOlToTabBar", sender: nil)
                       }
                   }
               } 
            else {
                   let uyari = UIAlertController(title: "Bilgileri Tamamlayınız", message: "Eksik bilgiler mevcut.", preferredStyle: UIAlertController.Style.alert)
                   let tamamButon = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil)
                   uyari.addAction(tamamButon)
                   self.present(uyari, animated: true, completion: nil)
               }
           }

                  // Telefon numarasını veritabanında saklayan fonksiyon
                  func telefonNoKaydet(userID: String, phoneNumber: String) {
                      let db = Firestore.firestore()
                // Veritabanında kullanıcıya telefon no kaydetme
                      db.collection("users").document(userID).setData(["phone": phoneNumber]) { error in
                          if let error = error {
               // hata alırsak localizedDescription ile veritabanının verdiği hata yazıcak
                              print("Telefon numarası kaydedilemedi \(error.localizedDescription)")
                          } else {
                              print("Telefon numarası başarıyla kaydedildi")
                          }
                      }
                  }

                  // Hata mesajı için klasik bir uyarı mesajı fonksiyonu yazdık.
                  func uyariMesaj(titleInput: String, messageInput: String) {
                      let uyariMesaji = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
                      let tamamButon = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil)
                      uyariMesaji.addAction(tamamButon)
                      self.present(uyariMesaji, animated: true, completion: nil)
                  }
              }
