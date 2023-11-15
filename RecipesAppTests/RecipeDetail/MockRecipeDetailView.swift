//
//  MockRecipeDetailView.swift
//  RecipesAppTests
//
//  Created by Jhonatan chavez chavez on 14/11/23.
//

import XCTest
@testable import RecipesApp

class MockRecipeDetailView: RecipeDetailViewControllerProtocol {
    var updateSpinnerCalled = false
    var spinnerLoading = false
    var updateDetailCalled = false
    var recipe: Recipe?

    func updateSpinner(loading: Bool) {
        updateSpinnerCalled = true
        spinnerLoading = loading
    }

    func updateDetail(with recipe: Recipe) {
        updateDetailCalled = true
        self.recipe = recipe
    }
}
