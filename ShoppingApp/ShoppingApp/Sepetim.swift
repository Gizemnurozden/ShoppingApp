//
//  Sepetim.swift
//  ShoppingApp
//
//  Created by Gizemnur Özden on 11.05.2024.
//

import UIKit

class Sepetim: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            tableView.delegate = self
            tableView.dataSource = self
            //Hücreleri kaydetme
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            // satır yüksekliğini ayarlama kısmı
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 240
        }
        
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 10 // Örnek veri sayısı
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            // Önce mevcut tüm alt görünümleri kaldır
            cell.contentView.subviews.forEach { $0.removeFromSuperview() }
            
            // Görsel Ekleme
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.image = UIImage(systemName: "photo") // Resim eklenen yer
            imageView.translatesAutoresizingMaskIntoConstraints = false
            cell.contentView.addSubview(imageView)
            
            // Başlık ekleme kısmı
            let titleLabel = UILabel()
            titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            titleLabel.text = "Başlık \(indexPath.row + 1)" // Örnek başlık
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            cell.contentView.addSubview(titleLabel)
            
            // Açıklama ekleme kısmı
            let descriptionLabel = UILabel()
            descriptionLabel.font = UIFont.systemFont(ofSize: 16)
            descriptionLabel.textColor = .gray
            descriptionLabel.text = "Açıklama kısmı \(indexPath.row + 1)" // Örnek metin
            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            cell.contentView.addSubview(descriptionLabel)
            
            // Görsel , başlık ve açıklama için yaptığımız constraint kısıtlamaları.
            NSLayoutConstraint.activate([
            // Görsel ayarları
                imageView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 15),
                imageView.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 10),
                imageView.widthAnchor.constraint(equalToConstant: 120),
                imageView.heightAnchor.constraint(equalToConstant: 120),
                
            //Başlık ayarları
                titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
                titleLabel.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -15),
                titleLabel.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 20),
                
            // açıklama ayarları
                descriptionLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
                descriptionLabel.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -15),
                descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
                descriptionLabel.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -20)
            ])
            
            return cell
        }
        // Satır seçildiğinde çağrılan func
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    @IBAction func sepetiTemizle(_ sender: Any) {
        
    }
    
    @IBAction func alisverisiTamamla(_ sender: Any) {
        
    }
}

