//
//  RecipeDetailRouter.swift
//  RecipesApp
//
//  Created by Jhonatan chavez chavez on 13/11/23.
//

import UIKit

protocol RecipeDetailRouterProtocol {
    func showScreen(viewModel: RecipeDetailViewModelProtocol)
    func showLocation(location:String)
    func showError(error: String)
}

class RecipeDetailRouter {
    
    var navigation: UINavigationController?
    
    init(navigation: UINavigationController? = nil) {
        self.navigation = navigation
    }
    
}

extension RecipeDetailRouter:RecipeDetailRouterProtocol{
    func showScreen(viewModel: RecipeDetailViewModelProtocol) {
        let viewController = RecipeDetailViewController(viewModel: viewModel)
        navigation?.pushViewController(viewController, animated: true)
    }
    func showLocation(location: String) {
        if let navigation {
            let builder = LocationBuilder(baseViewController: navigation, location: location)
            builder.showScreen()
        }
    }
    
    func showError(error: String) {
        navigation?.showErrorAlert(error: error)
    }
}
