//
//  ViewController.swift
//  ShoppingApp
//
//  Created by Gizemnur Özden on 11.05.2024.
//

import UIKit

class Anasayfa: UIViewController {
    
    @IBOutlet weak var urunTableView: UITableView!
    
    var kategorilerListesi = [Kategoriler]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        urunTableView.delegate = self
        urunTableView.dataSource = self
        
        let k1 = Kategoriler(id:1, ad:"KABAN",  resim :"kaban",kesfet:"Ürünlerimizi keşfetmek için tıklayın!")
        let k2 = Kategoriler(id:2, ad:"GÖMLEK",  resim :"gomlek",kesfet:"Ürünlerimizi keşfetmek için tıklayın!")
        
        let k3 = Kategoriler(id:3, ad:"YAĞMURLUK",  resim :"yagmurluk",kesfet:"Ürünlerimizi keşfetmek için tıklayın!")
        let k4 = Kategoriler(id:4, ad:"MONT",  resim :"mont",kesfet:"Ürünlerimizi keşfetmek için tıklayın!")
        
        kategorilerListesi.append(k1)
        kategorilerListesi.append(k2)
        kategorilerListesi.append(k3)
        kategorilerListesi.append(k4)
        
        urunTableView.separatorColor = UIColor(white: 0.95, alpha: 1)
    }
    
}
extension Anasayfa : UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kategorilerListesi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let kategori = kategorilerListesi[indexPath.row]
        
        let hucre = tableView.dequeueReusableCell(withIdentifier: "kategorilerHucre") as! KategorilerHucre
    
        hucre.imageViewUrun.image = UIImage(named: kategori.resim!)
        hucre.labelUrunAd.text = kategori.ad
        hucre.labelUrunTikla.text = kategori.kesfet
        
        
        hucre.backgroundColor = UIColor(white: 0.95, alpha: 1)
        hucre.hucreArkaPlan.layer.cornerRadius = 10.0
        
        hucre.selectionStyle = .none
        return hucre
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let kategori = kategorilerListesi[indexPath.row]
        
        print("\(kategori.ad!) seçildi")
    }
   
    
}



