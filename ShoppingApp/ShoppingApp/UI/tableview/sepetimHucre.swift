//
//  sepetimHucre.swift
//  ShoppingApp
//
//  Created by Ogün Minkara on 24.06.2024.
//

import UIKit
import Firebase
class SepetimHucre: UITableViewCell {

  
    @IBOutlet weak var hucreArkaPlan: UIView!
    @IBOutlet weak var imageViewSepetim: UIImageView!
    @IBOutlet weak var urunFiyat: UILabel!
    @IBOutlet weak var urunAd: UILabel!
    @IBOutlet weak var bedenSecim: UILabel!
    @IBOutlet weak var urunAdedi: UILabel!
   

    
  
    var urunAdedim: Int = 1 {
           didSet {
               urunAdedi.text = "\(urunAdedim)"
           }
       }
    override func awakeFromNib() {
           super.awakeFromNib()
           
       }
    
   
    
    @IBAction func artiTiklandi(_ sender: Any) {
        urunAdedim += 1
    }
    
    @IBAction func eksiTiklandi(_ sender: Any) {
        if urunAdedim > 1 {
                    urunAdedim -= 1
                    // Burada sepete eklenen ürün adedini azaltabilirsiniz
                }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
