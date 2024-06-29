//
//  UrunlerHucre.swift
//  ShoppingApp
//
//  Created by Gizemnur Özden on 12.06.2024.
//

import UIKit

class UrunlerHucre: UICollectionViewCell {
    
    @IBOutlet weak var imageUrun: UIImageView!
    @IBOutlet weak var urunAd: UILabel!
    @IBOutlet weak var urunFiyat: UILabel!
    
    var viewController: UIViewController?
    var urun: Urunler? // Ürün bilgilerini tutacak değişken

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func buttonSepeteEkle(_ sender: Any) {
        guard let viewController = self.viewController,
              let urun = self.urun else {
            return
        }
        // Detay sayfasına yönlendirme
        if let shoppingVC = viewController as? Shopping {
            shoppingVC.performSegue(withIdentifier: "toDetay", sender: urun)
        }
    }
}

