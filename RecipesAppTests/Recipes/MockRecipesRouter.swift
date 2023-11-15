//
//  MockRecipesRouter.swift
//  RecipesAppTests
//
//  Created by Jhonatan chavez chavez on 14/11/23.
//

import XCTest
@testable import RecipesApp

class MockRecipesRouter: RecipesRouterProtocol {
    
    var showErrorCalled = false
    var errorShowed = ""
    
    var showScreenCalled = false
    
    var showRecipeDetailCalled = false
    var recipe: RecipesElement?

    func showError(error: String) {
        showErrorCalled = true
        errorShowed = error
    }

    func showScreen(viewModel: RecipesViewModelProtocol) {
        showScreenCalled = true
    }

    func showRecipeDetail(recipe: RecipesElement) {
        showRecipeDetailCalled = true
        self.recipe = recipe
    }
}
