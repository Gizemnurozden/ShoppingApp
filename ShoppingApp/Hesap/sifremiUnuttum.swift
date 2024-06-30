//
//  sifremiUnuttum.swift
//  ShoppingApp
//
//  Created by Ogün Minkara on 30.06.2024.
//

import UIKit
import Firebase

class sifremiUnuttum: UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    @IBAction func sifirlamaButon(_ sender: Any) {
        guard let email = emailText.text, !email.isEmpty else {
                   uyariMesaj(titleInput: "Hata", messageInput: "Lütfen e-posta adresinizi girin.")
                   return
               }
               
               // Firebase şifre sıfırlama fonksiyonunu çağırıyoruz
               Auth.auth().sendPasswordReset(withEmail: email) { error in
                   if let error = error {
                       self.uyariMesaj(titleInput: "Hata", messageInput: error.localizedDescription)
                   } else {
                       self.uyariMesaj(titleInput: "Başarılı", messageInput: "Şifre sıfırlama bağlantısı e-posta adresinize gönderildi.")
                       self.performSegue(withIdentifier: "sifremiUnuttumToGiris", sender: nil)
                   }
               }
           }
           
           func uyariMesaj(titleInput: String, messageInput: String) {
               let uyariMesaji = UIAlertController(title: titleInput, message: messageInput, preferredStyle: .alert)
               let tamamButon = UIAlertAction(title: "Tamam", style: .default, handler: nil)
               uyariMesaji.addAction(tamamButon)
               self.present(uyariMesaji, animated: true, completion: nil)
           }
       }
