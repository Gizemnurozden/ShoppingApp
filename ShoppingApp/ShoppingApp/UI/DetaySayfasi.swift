//
//  DetaySayfasi.swift
//  ShoppingApp
//
//  Created by Gizemnur Özden on 11.05.2024.
//

import UIKit
import Kingfisher
import FirebaseFirestore

class DetaySayfasi: UIViewController {

    @IBOutlet weak var urunAd: UILabel!
    @IBOutlet weak var urunResim: UIImageView!
    @IBOutlet weak var urunHakkinda: UILabel!
    @IBOutlet weak var urunFiyat: UILabel!
    @IBOutlet weak var bedenLabel: UILabel!
    @IBOutlet weak var sizeSecim: UISegmentedControl!

    var urun: Urunler?
    var firestore: Firestore!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let urun = urun {
            urunAd.text = urun.ad
            urunFiyat.text = "\(urun.fiyat ?? 0.0) $"
            urunHakkinda.text = urun.detay

            if let resimUrl = urun.resim, let url = URL(string: resimUrl) {
                urunResim.kf.setImage(with: url)
            } else {
                urunResim.image = UIImage(named: "placeholder")
            }

            if let bedenler = urun.bedenler {
                for beden in bedenler {
                    sizeSecim.insertSegment(withTitle: beden, at: sizeSecim.numberOfSegments, animated: false)
                }
            }
        }

        firestore = Firestore.firestore()
    }

    @IBAction func buttonSepeteEkle(_ sender: Any) {
        if let urun = urun {
            let secilenBeden = sizeSecim.titleForSegment(at: sizeSecim.selectedSegmentIndex) ?? ""
            let sepetUrunu: [String: Any] = [
                "urunId": urun.id ?? "",
                "ad": urun.ad ?? "",
                "resim": urun.resim ?? "",
                "fiyat": urun.fiyat ?? 0.0,
                "secilenBeden": secilenBeden
            ]

            firestore.collection("Sepet").addDocument(data: sepetUrunu) { error in
                if let error = error {
                    print("Ürün sepete eklenirken hata oluştu: \(error.localizedDescription)")
                } else {
                    print("Ürün sepete eklendi.")
                    
                   self.performSegue(withIdentifier: "detayToSepetim", sender: nil)
                }
            }
        }
    }
}
