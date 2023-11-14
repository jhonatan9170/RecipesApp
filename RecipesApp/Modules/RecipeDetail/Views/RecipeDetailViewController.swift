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
            titleLabel.text =  ""
            titleLabel.textColor = UIColor(named: "colorLetras")
            titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 16.0)
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
            let locationName = viewModel?.location ?? ""
            let attributeString = NSMutableAttributedString(
                string: " Location: "+locationName,
                attributes: [
                    .underlineStyle:NSUnderlineStyle.single.rawValue,
                    .font:  UIFont(name: "HelveticaNeue-Bold", size: 16.0) ?? UIFont()
                            ]
            )
            locationButton.setAttributedTitle(attributeString, for: .normal)
        }
    }
    
    private var viewModel:RecipeDetailViewModelProtocol?
    
    init(recipeId: String, location: String) {
        super.init(nibName: String(describing: RecipeDetailViewController.self), bundle: Bundle.main)
        self.viewModel = RecipeDetailViewModel(recipeId: recipeId, location: location, view: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.getDetail()
        view.addSpinner()
    }
    
    private func setLabel(label: UILabel?){
        label?.text =  ""
        label?.textColor = UIColor(named: "colorLetras")
        label?.font = UIFont(name: "HelveticaNeue", size: 12.0)
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
        vc.viewModel = LocationViewModel(view: vc, location: viewModel?.location ?? "")
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension RecipeDetailViewController: RecipeDetailViewControllerProtocol {
    func updateDetail() {
        view.removeSpinner()
        if let recipe = viewModel?.recipe {
            setupView(with: recipe)
        } else {
            showError()
        }
    }
}
