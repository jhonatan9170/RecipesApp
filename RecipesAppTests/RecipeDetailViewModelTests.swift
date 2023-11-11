//
//  RecipeDetailViewModelTests.swift
//  RecipesAppTests
//
//  Created by Jhonatan chavez chavez on 10/11/23.
//

import XCTest
@testable import RecipesApp

class RecipeDetailViewModelTests: XCTestCase {
    
    var viewModel: RecipeDetailViewModel!
    var mockService: MockRecipesService!
    var delegate: MockRecipeDetailViewModelDelegate!

    override func setUp() {
        super.setUp()
        mockService = MockRecipesService()
        viewModel = RecipeDetailViewModel(service: mockService, recipeId: "TestID")
        delegate = MockRecipeDetailViewModelDelegate()
        viewModel.delegate = delegate
    }

    override func tearDown() {
        viewModel = nil
        mockService = nil
        delegate = nil
        super.tearDown()
    }
    
    func testGetIngredientsText() {
        let ingredients = ["Ingredient1", "Ingredient2"]
        let ingredientsText = viewModel.getIngredientsText(ingredients)
        XCTAssertEqual(ingredientsText, "Ingredient1\nIngredient2")
    }

    func testGetProcedureText() {
        let steps = ["1": "Step 1", "2": "Step 2"]
        let procedureText = viewModel.getProcedureText(steps)
        XCTAssertEqual(procedureText, "Step 1: Step 1\n\nStep 2: Step 2")
    }

    func testGetDetail_Success() {
        let recipeDetail = RecipeResponse(name: "Test Recipe", imageSrc: "image_url", difficulty: "Easy", description: "Description", ingredients: ["Ingredient1", "Ingredient2"], steps: ["1": "Step 1", "2": "Step 2"])
        mockService.mockRecipeResponse = recipeDetail

        viewModel.getDetail()

        XCTAssertTrue(delegate.successCalled)
        XCTAssertFalse(delegate.errorCalled)
        XCTAssertEqual(viewModel.description, "Description")
        XCTAssertEqual(viewModel.difficulty, "Easy")
        XCTAssertEqual(viewModel.urlImage, "image_url")
        XCTAssertEqual(viewModel.ingredients, "Ingredient1\nIngredient2")
        XCTAssertEqual(viewModel.procedure, "Step 1: Step 1\n\nStep 2: Step 2")
    }

    func testGetDetail_Failure() {
        mockService.shouldReturnError = true

        viewModel.getDetail()

        XCTAssertFalse(delegate.successCalled)
        XCTAssertTrue(delegate.errorCalled)
    }
}

class MockRecipeDetailViewModelDelegate: RecipeDetailViewModelDelegate {
    var successCalled = false
    var errorCalled = false

    func success(_ viewModel: RecipeDetailViewModel) {
        successCalled = true
    }

    func error(_ viewModel: RecipeDetailViewModel) {
        errorCalled = true
    }
}
