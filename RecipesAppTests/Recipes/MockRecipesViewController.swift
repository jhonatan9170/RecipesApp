//
//  MockRecipesViewController.swift
//  RecipesAppTests
//
//  Created by Jhonatan chavez chavez on 14/11/23.
//

import XCTest
@testable import RecipesApp

class MockRecipesViewController: RecipesViewControllerProtocol {
    var updateSpinnerCalled = false
    var spinnerLoading = false
    var reloadTableViewCalled = false

    func updateSpinner(loading: Bool) {
        updateSpinnerCalled = true
        spinnerLoading = loading
    }

    func reloadTableView() {
        reloadTableViewCalled = true
    }
}
