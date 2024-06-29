//
//  Sepet.swift
//  ShoppingApp
//
//  Created by Gizemnur Özden on 26.06.2024.
//

import Foundation

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
    
    // Firestore'a kaydetmek için uygun formata dönüştürme fonksiyonu
    func toAnyObject() -> Any {
        return [
            "documentId": documentId,
            "urunId": urunId,
            "ad": ad,
            "resim": resim,
            "fiyat": fiyat,
            "secilenBeden": secilenBeden,
            "adet": adet
        ]
    }
}
