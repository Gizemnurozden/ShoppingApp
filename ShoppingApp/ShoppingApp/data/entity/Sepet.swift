//
//  Sepet.swift
//  ShoppingApp
//
//  Created by Gizemnur Özden on 26.06.2024.
//

import UIKit

class Sepet {
    var documentId: String
    var urunId: String
    var ad: String
    var resim: String
    var fiyat: Double
    var secilenBeden: String
    var adet: Int

    init(documentId: String, urunId: String, ad: String, resim: String, fiyat: Double, secilenBeden: String, adet: Int) {
        self.documentId = documentId
        self.urunId = urunId
        self.ad = ad
        self.resim = resim
        self.fiyat = fiyat
        self.secilenBeden = secilenBeden
        self.adet = adet
    }
}

