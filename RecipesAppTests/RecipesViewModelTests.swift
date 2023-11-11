//
//  RecipesViewModelTests.swift
//  RecipesAppTests
//
//  Created by Jhonatan chavez chavez on 10/11/23.
//

import XCTest
@testable import RecipesApp

class MockRecipesService: RecipesServiceProtocol {

    
    var mockRecipesResponse: RecipesResponse?
    var mockRecipeResponse: RecipeResponse?
    var shouldReturnError: Bool = false

    func getRecipes(completion: @escaping (RecipesResponse?) -> Void) {
        if shouldReturnError {
            completion(nil)
        } else {
            completion(mockRecipesResponse)
        }
    }
    func getRecipe(recipeId: String, completion: @escaping (RecipeResponse?) -> Void) {
        if shouldReturnError {
            completion(nil)
        } else {
            completion(mockRecipeResponse)
        }
    }
}

class RecipesViewModelTests: XCTestCase {
    
    var viewModel: RecipesViewModel!
    var mockService: MockRecipesService!
    var delegate: MockRecipesViewModelDelegate!

    override func setUp() {
        super.setUp()
        mockService = MockRecipesService()
        viewModel = RecipesViewModel(service: mockService)
        delegate = MockRecipesViewModelDelegate()
        viewModel.delegate = delegate
    }

    override func tearDown() {
        viewModel = nil
        mockService = nil
        delegate = nil
        super.tearDown()
    }

    func testGetRecipes_Success() {
        mockService.mockRecipesResponse = [RecipesElement(origen: "Lima", recipeId: "lomo-saltado", recipeName: "Lomo saltado", description: "Test desco", additionalInfo: nil, imageSrc: nil)]
        viewModel.getRecipes()

        XCTAssertTrue(delegate.successCalled)
        XCTAssertFalse(delegate.errorCalled)
        XCTAssertEqual(viewModel.recipes.count, 1)
    }

    func testGetRecipes_Failure() {
        mockService.shouldReturnError = true

        viewModel.getRecipes()

        XCTAssertFalse(delegate.successCalled)
        XCTAssertTrue(delegate.errorCalled)
    }

    func testFilterByName() {
        mockService.mockRecipesResponse = [RecipesElement(origen: "Lima", recipeId: "lomo-saltado", recipeName: "Lomo saltado", description: "Test desco", additionalInfo: nil, imageSrc: nil),
                                           RecipesElement(origen: "Cajamarca", recipeId: "durazno-dulce", recipeName: "Durazno dulce", description: "Test desco", additionalInfo: nil, imageSrc: nil)]
        viewModel.getRecipes()
        viewModel.filterByName(text: "lomo")

        XCTAssertEqual(viewModel.recipes.count, 1)
        XCTAssertEqual(viewModel.recipes[0].recipeName, "Lomo saltado")
    }

    func testRecipeForCellAtIndex() {
        let testRecipes = [RecipesElement(origen: "Test", recipeId: "1", recipeName: "Recipe 1", description: "desc 1", additionalInfo: nil, imageSrc: nil),
                           RecipesElement(origen: "Test", recipeId: "2", recipeName: "Recipe 2", description: "desc 2", additionalInfo: nil, imageSrc: nil)]
        mockService.mockRecipesResponse = testRecipes
        viewModel.getRecipes()

        let firstRecipe = viewModel.recipeForCellAtIndex(0)
        XCTAssertEqual(firstRecipe.recipeName, "Recipe 1")
        XCTAssertEqual(firstRecipe.recipeId, "1")
    }

    func testRecipeIdForCellAtIndex() {
        let testRecipes = [RecipesElement(origen: "Test", recipeId: "1", recipeName: "Recipe 1", description: "desc 1", additionalInfo: nil, imageSrc: nil),
                           RecipesElement(origen: "Test", recipeId: "2", recipeName: "Recipe 2", description: "desc 2",additionalInfo: nil, imageSrc: nil)]
        mockService.mockRecipesResponse = testRecipes
        viewModel.getRecipes()

        let firstRecipeId = viewModel.recipeIdForCellAtIndex(0)
        XCTAssertEqual(firstRecipeId, "1")
    }

    func testCleanFilter() {
        let testRecipes = [RecipesElement(origen: "Test", recipeId: "1", recipeName: "Recipe 1", description: "desc 1", additionalInfo: nil, imageSrc: nil),
                           RecipesElement(origen: "Test", recipeId: "2", recipeName: "Recipe 2", description: "desc 2",additionalInfo: nil, imageSrc: nil)]
        mockService.mockRecipesResponse = testRecipes
        viewModel.getRecipes()

        viewModel.filterByName(text: "Recipe 1")
        XCTAssertEqual(viewModel.recipes.count, 1)

        viewModel.cleanFilter()
        XCTAssertEqual(viewModel.recipes.count, testRecipes.count)
        XCTAssertEqual(viewModel.recipes, testRecipes)
    }
}

class MockRecipesViewModelDelegate: RecipesViewModelDelegate {
    var successCalled = false
    var errorCalled = false

    func success(_ viewModel: RecipesViewModel) {
        successCalled = true
    }

    func error(_ viewModel: RecipesViewModel) {
        errorCalled = true
    }
}

