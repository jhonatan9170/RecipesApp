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
    private weak var navigation: UINavigationController?
    
    init(window: UIWindow) {
        self.window = window
    }
}

extension RecipesRouter: RecipesRouterProtocol {
    func showScreen(viewModel: RecipesViewModelProtocol) {
        let viewController = RecipesViewController(viewModel: viewModel)
        let navigation = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigation
        self.navigation = navigation
    }
    
     func showError(error: String) {
         navigation?.showErrorAlert(error: error)
     }
    
    func showRecipeDetail(recipe: RecipesElement) {
        guard let navigation else { return }
        let builder = RecipeDetailBuilder(baseViewController: navigation, recipe: recipe)
        builder.showScreen()
    }
}
