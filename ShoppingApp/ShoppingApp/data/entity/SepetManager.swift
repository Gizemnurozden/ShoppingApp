//
//  SepetManager.swift
//  ShoppingApp
//
//  Created by Gizemnur Özden on 26.06.2024.
//

import Foundation
import Firebase
import FirebaseFirestore

class SepetManager {
    static let shared = SepetManager()
    var sepetListesi: [Sepet] = []

    private init() {}

    func sepeteEkle(urun: Urunler, secilenBeden: String) {
        let sepetUrun = Sepet(urun: urun, secilenBeden: secilenBeden)
        sepetListesi.append(sepetUrun)
    }

    func sepetiBosalt() {
        sepetListesi.removeAll()
    }

    func sepetUrunleri() -> [Sepet] {
        return sepetListesi
    }
}
