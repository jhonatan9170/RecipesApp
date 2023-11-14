//
//  RecipeDetailBuilder.swift
//  RecipesApp
//
//  Created by Jhonatan chavez chavez on 13/11/23.
//

import UIKit

final class RecipeDetailBuilder{
    
    private let viewModel: RecipeDetailViewModelProtocol
    
    init(baseViewController: UINavigationController, recipe: RecipesElement) {
        let router = RecipeDetailRouter(navigation: baseViewController)
        viewModel = RecipeDetailViewModel(router: router, recipeId: recipe.recipeId, location: recipe.origen)
    }
    
    func showScreen() {
        return viewModel.showScreen()

    }
}
