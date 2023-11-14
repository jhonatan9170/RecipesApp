//
//  RecipeDetailViewController.swift
//  RecipesApp
//
//  Created by Jhonatan chavez chavez on 10/11/23.
//

import UIKit

protocol RecipeDetailViewControllerProtocol: AnyObject {
    func updateDetail()
}

class RecipeDetailViewController: UIViewController {
    
    @IBOutlet weak private var recipeImage: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!{
        didSet{
            setLabel(label: titleLabel)
        }
    }
    @IBOutlet weak private var descriptionLabel: UILabel!{
        didSet{
            setLabel(label: descriptionLabel)
        }
    }
    @IBOutlet weak private var ingredientsLabel: UILabel!{
        didSet{
            setLabel(label: ingredientsLabel)
        }
    }
    @IBOutlet weak private var procedureLabel: UILabel!{
        didSet{
            setLabel(label: procedureLabel)
        }
    }
    @IBOutlet weak private var diffficultyLabel: UILabel!{
        didSet{
            setLabel(label: diffficultyLabel)
        }
    }
    @IBOutlet weak private var locationButton: UIButton!{
        didSet {
            let attributeString = NSMutableAttributedString(
                string: "  Location: "+viewModel.location,
                attributes: [.underlineStyle:NSUnderlineStyle.single.rawValue]
            )
            locationButton.setAttributedTitle(attributeString, for: .normal)
        }
    }
    
    var viewModel:RecipeDetailViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getDetail()
        view.addSpinner()
    }
    
    private func setLabel(label: UILabel?){
        label?.text =  ""
    }
    
    private func setupView(with recipe: Recipe) {
        self.title = recipe.name
        titleLabel.text = recipe.name
        descriptionLabel.text = recipe.description
        recipeImage.kf.setImage(with: URL(string: recipe.urlImg),placeholder: UIImage(named: "imagePlaceholder"))
        ingredientsLabel.text = recipe.ingredients
        procedureLabel.text = recipe.procedure
        diffficultyLabel.text = recipe.dificulty
        
    }
    
    private func showError() {
        showErrorAlert(error: "No se pudo cargar la receta")
    }
    
    @IBAction private func locationButtonTapped( _ sender :UIButton) {
        let vc = LocationViewController(nibName: "LocationViewController", bundle: nil)
        vc.viewModel = LocationViewModel(view: vc, location: viewModel.location)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension RecipeDetailViewController: RecipeDetailViewControllerProtocol {
    func updateDetail() {
        view.removeSpinner()
        if let recipe = viewModel.recipe {
            setupView(with: recipe)
        } else {
            showError()
        }
    }
}
