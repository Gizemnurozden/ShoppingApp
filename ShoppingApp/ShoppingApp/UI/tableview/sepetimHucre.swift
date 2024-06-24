//
//  sepetimHucre.swift
//  ShoppingApp
//
//  Created by Ogün Minkara on 24.06.2024.
//

import UIKit

class sepetimHucre: UITableViewCell {

    @IBOutlet weak var imageViewSepet: UIImageView!
    @IBOutlet weak var hucreArkaplan: UIView!
    @IBOutlet weak var urunBaslik: UILabel!
    @IBOutlet weak var urunFiyat: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
