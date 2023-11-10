//
//  RecipesTableViewCell.swift
//  RecipesApp
//
//  Created by Jhonatan chavez chavez on 10/11/23.
//

import UIKit
import Kingfisher

class RecipesTableViewCell: UITableViewCell {

    @IBOutlet weak var foodUIImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let url = URL(string: "https://images.immediate.co.uk/production/volatile/sites/30/2020/08/salade-nicoise-565173e.jpg")
        foodUIImage.kf.setImage(with: url,placeholder: UIImage(named: "imagePlaceholder"))
        
    }
}
