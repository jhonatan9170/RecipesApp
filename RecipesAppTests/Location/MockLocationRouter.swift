//
//  MockLocationRouter.swift
//  RecipesAppTests
//
//  Created by Jhonatan chavez chavez on 14/11/23.
//

@testable import RecipesApp

class MockLocationRouter: LocationRouterProtocol {
    var showErrorCalled = false
    var showScreenCalled = false
    var errorShowed: String = ""

    func showError(error: String) {
        showErrorCalled = true
        errorShowed = error
    }

    func showScreen(viewModel: LocationViewModelProtocol) {
        showScreenCalled = true
    }
}
