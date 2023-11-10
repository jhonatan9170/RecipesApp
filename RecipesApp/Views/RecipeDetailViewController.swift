//
//  RecipeDetailViewController.swift
//  RecipesApp
//
//  Created by Jhonatan chavez chavez on 10/11/23.
//

import UIKit


class RecipeDetailViewController: UIViewController {
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var procedureLabel: UILabel!
    @IBOutlet weak var diffficultyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Causa Rellena"
        let url = URL(string: "https://images.immediate.co.uk/production/volatile/sites/30/2020/08/salade-nicoise-565173e.jpg")
        recipeImage.kf.setImage(with: url,placeholder: UIImage(named: "imagePlaceholder"))
    }
}
