//
//  sepetimHucre.swift
//  ShoppingApp
//
//  Created by Ogün Minkara on 24.06.2024.
//
import UIKit
import FirebaseFirestore

class SepetimHucre: UITableViewCell {
    
    @IBOutlet weak var hucreArkaPlan: UIView!
    @IBOutlet weak var imageViewSepetim: UIImageView!
    @IBOutlet weak var urunFiyat: UILabel!
    @IBOutlet weak var urunAd: UILabel!
    @IBOutlet weak var bedenSecim: UILabel!
    @IBOutlet weak var urunAdedi: UILabel!
    
    var firestore: Firestore!
    var documentId: String? // Ürünün Firestore'daki belge ID'sini tutacak değişken
    var parentViewController: Sepetim? // Parent view controller'ı referans olarak tutun
    
    var urunAdedim: Int = 1 {
        didSet {
            urunAdedi.text = "\(urunAdedim)"
            updateProductQuantityInFirestore()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        firestore = Firestore.firestore()
    }
    
    @IBAction func artiTiklandi(_ sender: Any) {
        urunAdedim += 1
        parentViewController?.updateTotalPrice() // Toplam fiyatı hemen güncelle
    }
    
    @IBAction func eksiTiklandi(_ sender: Any) {
        if urunAdedim > 1 {
            urunAdedim -= 1
            parentViewController?.updateTotalPrice() // Toplam fiyatı hemen güncelle
        }
    }
    
    private func updateProductQuantityInFirestore() {
        guard let documentId = documentId else { return }
        firestore.collection("Sepet").document(documentId).updateData(["adet": urunAdedim]) { error in
            if let error = error {
                print("Error updating document: \(error)")
            } else {
                print("Document successfully updated")
            }
        }
    }
}
