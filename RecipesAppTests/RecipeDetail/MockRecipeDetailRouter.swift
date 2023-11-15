//
//  MockRecipeDetailRouter.swift
//  RecipesAppTests
//
//  Created by Jhonatan chavez chavez on 14/11/23.
//

import XCTest
@testable import RecipesApp

class MockRecipeDetailRouter: RecipeDetailRouterProtocol {
    var showErrorCalled = false
    var errorShowed = ""
    var showScreenCalled = false
    var showLocationCalled = false
    var location = ""

    func showError(error: String) {
        showErrorCalled = true
        errorShowed = error
    }

    func showScreen(viewModel: RecipeDetailViewModelProtocol) {
        showScreenCalled = true
    }

    func showLocation(location: String) {
        showLocationCalled = true
        self.location = location
    }
}
