//
//  HesapSayfası.swift
//  ShoppingApp
//
//  Created by Gizemnur Özden on 11.05.2024.
//

import UIKit
import Firebase
import FirebaseAuth
import Foundation

protocol HesapSayfasiDelegate: AnyObject {
    func navigateToLogin()
}

class HesapSayfasi: UIViewController {
    
    
    @IBOutlet weak var emailText: UILabel!
   
    @IBOutlet weak var telefonNoText: UILabel!
    
    weak var delegate: HesapSayfasiDelegate?

       override func viewDidLoad() {
           super.viewDidLoad()
           checkUserAuthentication()
       }

       override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           checkUserAuthentication()
       }

       func checkUserAuthentication() {
           if let user = Auth.auth().currentUser {
               if let email = user.email {
                   emailText.text = email
               } else {
                   emailText.text = "Email bulunamadı"
               }

               let db = Firestore.firestore()
               db.collection("users").document(user.uid).getDocument { document, error in
                   if let error = error {
                       print("Error getting user data: \(error.localizedDescription)")
                   } else if let document = document, document.exists {
                       let data = document.data()
                       let phoneNumber = data?["phone"] as? String ?? "Telefon numarası bulunamadı"
                       self.telefonNoText.text = phoneNumber
                   }
               }
           } else {
               // Kullanıcı oturum açmamışsa, giriş sayfasına yönlendir
               delegate?.navigateToLogin()
           }
       }
     
    
    @IBAction func cikisButonu(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "hesabimToGiris", sender: nil)
        } catch {
            print("error")
        }
    }
    
        // Şifremi unuttuma tıklayınca şifre güncelleme sayfasına yönlendiriyor.
        @IBAction func sifremiUnuttumTiklandi(_ sender: Any) {
            performSegue(withIdentifier: "hesapToSifremiUnuttum", sender: nil)
        }
    }
