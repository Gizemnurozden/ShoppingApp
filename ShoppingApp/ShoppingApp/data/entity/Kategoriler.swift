//
//  Kategoriler.swift
//  ShoppingApp
//
//  Created by Gizemnur Özden on 12.06.2024.
//

import Foundation


class Kategoriler {
    
    var id:String?
    var ad:String?
    var resim:String?
    var kesfet:String?
    
    init() {
        
        
    }
    
    init(id: String?, ad: String? , resim: String? , kesfet: String?) {
        self.id = id
        self.ad = ad
        self.resim = resim
        self.kesfet = kesfet
    }
}
