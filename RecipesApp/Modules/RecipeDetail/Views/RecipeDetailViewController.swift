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
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var procedureLabel: UILabel!
    @IBOutlet weak var diffficultyLabel: UILabel!
    @IBOutlet weak var locationButton: UIButton!
    
    var viewModel:RecipeDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        viewModel.delegate = self
        viewModel.getDetail()
        view.addSpinner()
    }

    func setupViews() {
        self.title = viewModel.title
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        let url = URL(string:viewModel.urlImage)
        recipeImage.kf.setImage(with: url,placeholder: UIImage(named: "imagePlaceholder"))
        ingredientsLabel.text = viewModel.ingredients
        procedureLabel.text = viewModel.procedure
        diffficultyLabel.text = viewModel.difficulty
        let attributeString = NSMutableAttributedString(
              string: "  Location: "+viewModel.location,
              attributes: [.underlineStyle:NSUnderlineStyle.single.rawValue]
           )
        locationButton.setAttributedTitle(attributeString, for: .normal)

    }
    @IBAction func locationButtonTapped( _ sender :UIButton) {
        let vc = LocationViewController(nibName: "LocationViewController", bundle: nil)
        vc.viewModel = LocationViewModel(location: viewModel.location)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension RecipeDetailViewController: RecipeDetailViewModelDelegate {
    func success(_ viewModel: RecipeDetailViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.view.removeSpinner()
            self?.setupViews()
        }
    }
    
    func error(_ viewModel: RecipeDetailViewModel) {
        
        DispatchQueue.main.async { [weak self] in
            self?.view.removeSpinner()
            self?.showErrorAlert(error: "No se pudo cargar la receta")
        }
        
    }
    
    
}
