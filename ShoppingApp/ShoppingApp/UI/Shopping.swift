//
//  Shopping.swift
//  ShoppingApp
//
//  Created by Gizemnur Özden on 13.06.2024.
//

import UIKit

class Shopping: UIViewController {

    @IBOutlet weak var urunlerCollectionView: UICollectionView!
    
    var urunlerListesi = [Urunler]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        urunlerCollectionView.delegate = self
        urunlerCollectionView.dataSource = self
        
        let u1 = Urunler(id:1, ad:"Mavi mont",resim: "mont", fiyat: 140)
        let u2 = Urunler(id:2, ad:"Siyah mont",resim: "siyahmont", fiyat: 180)
        let u3 = Urunler(id:3, ad:"Turuncu Mont",resim: "turuncumont", fiyat: 119)
        let u4 = Urunler(id:4, ad:"Uzun siyah mont",resim: "uzunsiyah", fiyat: 149)
        let u5 = Urunler(id:5, ad:"Gri Mont",resim: "grimont", fiyat: 109)
        
        urunlerListesi.append(u1)
        urunlerListesi.append(u2)
        urunlerListesi.append(u3)
        urunlerListesi.append(u4)
        urunlerListesi.append(u5)
        
        let tasarim = UICollectionViewFlowLayout()
        tasarim.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        tasarim.minimumInteritemSpacing = 10
        tasarim.minimumLineSpacing = 10
        
        let ekranGenislik = UIScreen.main.bounds.width
        let itemGenislik = (ekranGenislik - 30) / 2
        
        tasarim.itemSize = CGSize(width: itemGenislik, height: itemGenislik*1.6)
        
        urunlerCollectionView.collectionViewLayout = tasarim
    }
}

extension Shopping : UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return urunlerListesi.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let urun = urunlerListesi[indexPath.row]
        
        let hucre = collectionView.dequeueReusableCell(withReuseIdentifier: "urunlerHucre", for: indexPath) as! UrunlerHucre
        
        hucre.imageUrun.image = UIImage(named: urun.resim!)
        hucre.urunAd.text = "\(urun.ad!)"
        hucre.urunFiyat.text = "\(urun.fiyat!) $"
        
        hucre.layer.borderColor = UIColor.lightGray.cgColor
        hucre.layer.borderWidth = 0.3
        hucre.layer.cornerRadius = 10.0
        return hucre
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let urun = urunlerListesi[indexPath.row]
        performSegue(withIdentifier: "toDetay", sender: urun)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetay" {
            if let urun = sender as? Urunler {
                let gidilecekVC = segue.destination as! DetaySayfasi
                gidilecekVC.urun = urun
               
            }
        }
    }
}
