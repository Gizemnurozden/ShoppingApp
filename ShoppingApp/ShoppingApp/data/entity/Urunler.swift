//
//  Urunler.swift
//  ShoppingApp
//
//  Created by Gizemnur Özden on 12.06.2024.
//

import Foundation

class Urunler {
    var id: String?
    var ad: String?
    var resim: String?
    var fiyat: Double?
    var detay: String?
    var bedenler: [String]? // Beden seçenekleri
    var adet: Int?
    

    init() {}

    init(id: String?, ad: String?, resim: String?, fiyat: Double?, detay: String?, bedenler: [String]?,adet:Int?) {
        self.id = id
        self.ad = ad
        self.resim = resim
        self.fiyat = fiyat
        self.detay = detay
        self.bedenler = bedenler
        self.adet = adet
    }
}
