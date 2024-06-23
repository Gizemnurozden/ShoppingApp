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
    @IBOutlet weak var sizeSecim: UISegmentedControl! // UISegmentedControl kullanarak beden seçimini sağlıyoruz

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

            // Beden seçeneklerini göstermek için
            if let bedenler = urun.bedenler {
                for beden in bedenler {
                    sizeSecim.insertSegment(withTitle: beden, at: sizeSecim.numberOfSegments, animated: false)
                }
            }
        }
    }

    @IBAction func buttonSepeteEkle(_ sender: Any) {
        // Sepete ekleme işlemi burada yapılabilir
        guard let urun = urun else { return }
        let secilenBeden = sizeSecim.titleForSegment(at: sizeSecim.selectedSegmentIndex) ?? "Beden seçilmedi"

        // Örneğin, Firestore'a sepete eklenecek ürün ve beden bilgilerini kaydetmek için
        let sepetUrun = [
            "urunAd": urun.ad ?? "",
            "urunFiyat": urun.fiyat ?? 0.0,
            "secilenBeden": secilenBeden
        ] as [String : Any]

        // Firestore koleksiyonuna ekleme örneği (örnek isim)
        firestore.collection("sepet").addDocument(data: sepetUrun) { (error) in
            if let error = error {
                print("Hata oluştu: \(error.localizedDescription)")
            } else {
                print("Ürün başarıyla sepete eklendi.")
            }
        }
    }
}
