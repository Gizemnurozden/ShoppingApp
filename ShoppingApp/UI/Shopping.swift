//
//  Shopping.swift
//  ShoppingApp
//
//  Created by Gizemnur Özden on 13.06.2024.
import UIKit
import FirebaseFirestore

class Shopping: UIViewController {

    @IBOutlet weak var urunlerCollectionView: UICollectionView!

    var urunlerListesi = [Urunler]()
    var selectedCategory: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        urunlerCollectionView.delegate = self
        urunlerCollectionView.dataSource = self

        let tasarim = UICollectionViewFlowLayout()
        tasarim.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        tasarim.minimumInteritemSpacing = 10
        tasarim.minimumLineSpacing = 10

        let ekranGenislik = UIScreen.main.bounds.width
        let itemGenislik = (ekranGenislik - 30) / 2

        tasarim.itemSize = CGSize(width: itemGenislik, height: itemGenislik * 1.6)
        urunlerCollectionView.collectionViewLayout = tasarim

        fetchProducts()
    }

    func fetchProducts() {
        guard let category = selectedCategory else { return }

        let db = Firestore.firestore()
        db.collection(category).getDocuments { (snapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                guard let documents = snapshot?.documents else {
                    print("No documents found for category: \(category)")
                    return
                }
                self.urunlerListesi = documents.compactMap { document in
                    let data = document.data()
                    let id = document.documentID
                    let ad = data["ad"] as? String ?? ""
                    let resim = data["resim"] as? String ?? ""
                    let fiyat = data["fiyat"] as? Double ?? 0.0
                    let detay = data["detay"] as? String ?? "" // Firestore'dan detay bilgisini al
                    let bedenler = data["bedenler"] as? [String] ?? [] // Firestore'dan bedenler bilgisini al
                    let adet = data["adet"] as? Int ?? 1
                    return Urunler(id: id, ad: ad, resim: resim, fiyat: fiyat, detay: detay, bedenler: bedenler,adet: adet)
                }
                self.urunlerCollectionView.reloadData()
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetay" {
            if let urun = sender as? Urunler {
                let gidilecekVC = segue.destination as! DetaySayfasi
                gidilecekVC.urun = urun
            }
        } else if segue.identifier == "toSepetim" {
            if let sepetimVC = segue.destination as? Sepetim {
                // UrunlerHucre'da viewController'ı set ediyoruz
                if let indexPath = urunlerCollectionView.indexPathsForSelectedItems?.first,
                   let selectedCell = urunlerCollectionView.cellForItem(at: indexPath) as? UrunlerHucre {
                    selectedCell.viewController = sepetimVC
                }
            }
        }
    }
}

extension Shopping: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return urunlerListesi.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let urun = urunlerListesi[indexPath.row]

        let hucre = collectionView.dequeueReusableCell(withReuseIdentifier: "urunlerHucre", for: indexPath) as! UrunlerHucre

        if let resimUrl = urun.resim, let url = URL(string: resimUrl) {
            hucre.imageUrun.kf.setImage(with: url)
        }

        hucre.urunAd.text = urun.ad
        hucre.urunFiyat.text = "\(urun.fiyat ?? 0.0) $"

        hucre.layer.borderColor = UIColor.lightGray.cgColor
        hucre.layer.borderWidth = 0.3
        hucre.layer.cornerRadius = 10.0
        hucre.viewController = self // viewController'ı hücreye set edin
        hucre.urun = urun // Ürün bilgilerini hücreye set edin
        
        return hucre
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let urun = urunlerListesi[indexPath.row]
        performSegue(withIdentifier: "toDetay", sender: urun)
    }
}
