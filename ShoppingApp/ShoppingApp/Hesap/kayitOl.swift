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
                if error != nil
                { self.uyariMesaj(titleInput: "Hata", messageInput: error?.localizedDescription ?? "Hata")
                    
                } 
                else
                {//şuan için yazmadım yazıcam
                    // performSegue(withIdentifier: "kayitOlToHesapSayfasi" , sender: nil)
                }
                
            }
        }
        else {
            let uyari = UIAlertController(title: "Bilgileri Tamamlayınız", message: "Eksik bilgiler mevcut.", preferredStyle: UIAlertController.Style.alert)
            let okButon = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil)
        }
    }
    
    
    
    // Hata mesajı için klasik bir uyarı mesajı fonksiyonu yazdık.
    func uyariMesaj(titleInput:String , messageInput:String) {
        let uyariMesaji = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let tamamButon = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil)
        uyariMesaji.addAction(tamamButon)
        self.present(uyariMesaji , animated:true , completion: nil)
    }
    
    
    
}
