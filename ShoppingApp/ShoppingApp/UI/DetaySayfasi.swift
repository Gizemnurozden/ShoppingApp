//
//  DetaySayfasi.swift
//  ShoppingApp
//
//  Created by Gizemnur Özden on 11.05.2024.
//

import UIKit

class DetaySayfasi: UIViewController {

    @IBOutlet weak var urunAd: UILabel!
    
    @IBOutlet weak var urunResim: UIImageView!
    
    @IBOutlet weak var urunHakkinda: UILabel!
    
    @IBOutlet weak var bedenLabel: UILabel!
    
    @IBOutlet weak var sizeSecim: UIButton!
    
    @IBOutlet weak var urunFiyat: UILabel!
    var urun:Urunler?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let u = urun {
            urunAd.text = u.ad
            urunResim.image = UIImage(named: u.resim!)
            urunFiyat.text = "\(u.fiyat) $"
        }
    }
    
    @IBAction func buttonSepeteEkle(_ sender: Any) {
    }
    
   

}
