//
//  bilgileriGuncelle.swift
//  ShoppingApp
//
//  Created by Ogün Minkara on 30.06.2024.
//

import UIKit
import Firebase

class bilgileriGuncelle: UIViewController {
    
    @IBOutlet weak var eMailText: UITextField!
    
    @IBOutlet weak var telefonNoText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
  

       
    }
    
    @IBAction func bilgilerimiGuncelleButon(_ sender: Any) {
       
    }
    
    @IBAction func hesabımıSilButon(_ sender: Any) {
        
        let alert = UIAlertController(title: "Hesabı Sil", message: "Hesabınızı kalıcı olarak silmek istediğinize emin misiniz?", preferredStyle: .alert)
        
              let onay = UIAlertAction(title: "Evet", style: .destructive) { _ in
                  self.kullaniciSil()
              }
        
              let iptal = UIAlertAction(title: "Hayır", style: .cancel, handler: nil)
              alert.addAction(onay)
              alert.addAction(iptal)
        
              self.present(alert, animated: true, completion: nil)
          }
   
          func kullaniciSil() {
              guard let user = Auth.auth().currentUser else {
                  self.uyariMesaj(titleInput: "Hata", messageInput: "Kullanıcı oturumu bulunamadı.")
                  return
              }
              
              let userID = user.uid
              let db = Firestore.firestore()
              
              // Kullanıcının veritabanı verilerini sildirir.
              db.collection("users").document(userID).delete { error in
                  if let error = error {
                      self.uyariMesaj(titleInput: "Hata", messageInput: error.localizedDescription)
                  } else {
                      // auth verilerini siler
                      user.delete { error in
                          if let error = error {
                              self.uyariMesaj(titleInput: "Hata", messageInput: error.localizedDescription)
                          } else {
                              self.uyariMesaj(titleInput: "Başarılı", messageInput: "Hesabınız başarıyla silindi.")
                            self.navigateToLogin()
                          }
                      }
                  }
              }
          }
          
    func uyariMesaj(titleInput: String, messageInput: String) {
            let uyariMesaji = UIAlertController(title: titleInput, message: messageInput, preferredStyle: .alert)
            let tamamButon = UIAlertAction(title: "Tamam", style: .default, handler: nil)
              uyariMesaji.addAction(tamamButon)
              self.present(uyariMesaji, animated: true, completion: nil)
          }
    
    // bu func chatgptden alındı
    func navigateToLogin() {
           DispatchQueue.main.async {
               let storyboard = UIStoryboard(name: "Main", bundle: nil)
               let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
               if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let sceneDelegate = windowScene.delegate as? SceneDelegate,
                  let window = sceneDelegate.window {
                   window.rootViewController = loginViewController
                   window.makeKeyAndVisible()
               }
           }
       }
      }
