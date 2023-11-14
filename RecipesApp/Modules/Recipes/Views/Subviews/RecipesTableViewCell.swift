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
    @IBOutlet weak var titleLabel: UILabel!{
        didSet{
            titleLabel.text =  ""
            titleLabel.textColor = UIColor(named: "colorLetras")
            titleLabel.font =  UIFont(name: "HelveticaNeue-Bold", size: 14.0) 
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(title: String, url:String){
        titleLabel.text = title
        let url = URL(string: url)
        foodUIImage.kf.setImage(with: url,placeholder: UIImage(named: "imagePlaceholder"))
    }
}
