//
//  RecipesRouter.swift
//  RecipesApp
//
//  Created by Jhonatan chavez chavez on 14/11/23.
//

import UIKit

protocol RecipesRouterProtocol {
    func showScreen(viewModel: RecipesViewModelProtocol)
    func showRecipeDetail(recipe: RecipesElement)
    func showError(error: String)
}

class RecipesRouter {
    private var window: UIWindow
    private weak var baseController: UIViewController?
    
    init(window: UIWindow) {
        self.window = window
    }
}

extension RecipesRouter: RecipesRouterProtocol {
    func showScreen(viewModel: RecipesViewModelProtocol) {
        let viewController = RecipesViewController(viewModel: viewModel)
        let navigation = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigation
        baseController = navigation
    }
    
     func showError(error: String) {
         baseController?.showErrorAlert(error: error)
     }
    
    func showRecipeDetail(recipe: RecipesElement) {
        guard let navigation = baseController as? UINavigationController else { return }
        let builder = RecipeDetailBuilder(baseViewController: navigation, recipe: recipe)
        builder.showScreen()
    }
}
