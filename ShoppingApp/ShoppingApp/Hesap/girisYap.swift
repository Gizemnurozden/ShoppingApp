//
//  girisYap.swift
//  ShoppingApp
//
//  Created by Ogün Minkara on 22.05.2024.
//

import UIKit
import Firebase

class girisYap: UIViewController {

    @IBOutlet weak var eMailText: UITextField!
    
    @IBOutlet weak var sifreText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    

    @IBAction func girisYapButon(_ sender: Any) {
        if eMailText.text != "" && sifreText.text != "" {
            Auth.auth().signIn(withEmail: eMailText.text!, password: sifreText.text!) { authdata, error in
                if error != nil{
                    self.uyariMesaj(titleInput: "Hata", messageInput: error?.localizedDescription ?? "Hata")
                } else{
                    self.performSegue(withIdentifier: "girisToTabBar" , sender: nil)
                }
            }
            
        }
        
    }
    
    
    @IBAction func kayitOlButon(_ sender: Any) {
        //giriş yap ekranında kayıt olma butonunun işlevi
        performSegue(withIdentifier: "girisToKayit", sender: nil)
    }
    
    func uyariMesaj(titleInput:String , messageInput:String) {
        let uyariMesaji = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let tamamButon = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil)
        uyariMesaji.addAction(tamamButon)
        self.present(uyariMesaji , animated:true , completion: nil)
    }
}
