//
//  File.swift
//  ShoppingApp
//
//  Created by Gizemnur Özden on 26.06.2024.
//

import Foundation

class Sepet {
    var urun: Urunler
    var secilenBeden: String
    
    init(urun: Urunler, secilenBeden: String) {
        self.urun = urun
        self.secilenBeden = secilenBeden
    }
}
