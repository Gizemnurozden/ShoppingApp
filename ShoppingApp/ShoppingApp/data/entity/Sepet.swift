//
//  Sepet.swift
//  ShoppingApp
//
//  Created by Gizemnur Özden on 26.06.2024.
//

import Foundation

class Sepet {
    
       var urunId: String
       var ad: String
       var resim: String
       var fiyat: Double
       var secilenBeden: String

       init(urunId: String, ad: String, resim: String, fiyat: Double, secilenBeden: String) {
        
           self.urunId = urunId
           self.ad = ad
           self.resim = resim
           self.fiyat = fiyat
           self.secilenBeden = secilenBeden
       }
}
