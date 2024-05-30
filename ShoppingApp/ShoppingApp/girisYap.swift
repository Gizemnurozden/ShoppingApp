//
//  girisYap.swift
//  ShoppingApp
//
//  Created by Ogün Minkara on 22.05.2024.
//

import UIKit

class girisYap: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    

    @IBAction func girisYapButon(_ sender: Any) {
        // burada girilen bilgiler doğru ise hesabım sayfasına geçiş yazılıcak.
        
    }
    
    
    @IBAction func kayitOlButon(_ sender: Any) {
        //giriş yap ekranında kayıt olma butonunun işlevi
        performSegue(withIdentifier: "girisToKayit", sender: nil)
    }
    
}
