//
//  Sepetim.swift
//  ShoppingApp
//
//  Created by Gizemnur Özden on 11.05.2024.
//

import UIKit

class Sepetim: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            tableView.separatorColor = UIColor(white: 0.95, alpha: 1)
        }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let silAction = UIContextualAction(style: .destructive, title: "Sil"){
            contextualAction,view,bool in print("Silindi")
        }
        return UISwipeActionsConfiguration(actions: [silAction])
    }
        
     
}

