//
//  RecipeDetailViewModelTests.swift
//  RecipesAppTests
//
//  Created by Jhonatan chavez chavez on 10/11/23.
//

import XCTest
@testable import RecipesApp

final class RecipeDetailViewModelTests: XCTestCase {
    
    var sut: RecipeDetailViewModel!
    var mockDataSource: MockRecipesDataSource!
    var mockView: MockRecipeDetailView!
    var mockRouter: MockRecipeDetailRouter!
    var dispatchQueueMock:DispatchQueueType!

    override func setUp() {
        super.setUp()
        mockDataSource = MockRecipesDataSource()
        mockView = MockRecipeDetailView()
        mockRouter = MockRecipeDetailRouter()
        dispatchQueueMock = DispatchQueueMock()
        sut = RecipeDetailViewModel(service: mockDataSource, router: mockRouter, recipeId: "testId", location: "Test Location",mainDispatchQueue: dispatchQueueMock)
        sut.setViewControllerProtocol(view: mockView)
    }

    override func tearDown() {
        sut = nil
        mockDataSource = nil
        mockView = nil
        mockRouter = nil
        dispatchQueueMock = nil
        super.tearDown()
    }

    func testGetDetailSuccess() {
        
        //Given
        let responseRecipe = RecipeResponse(name: "Test Recipe", imageSrc: "test.png", difficulty: "Easy", description: "Test Description", ingredients: ["Ingredient 1","Ingredient 2"], steps: ["1": "Step 1"])
        mockDataSource.mockedRecipe = responseRecipe
        let expectedRecipe = Recipe(name: "Test Recipe", dificulty: "Easy", description: "Test Description", ingredients: "Ingredient 1\nIngredient 2", urlImg: "test.png", procedure: "Step 1: Step 1")
        //When
        sut.getDetail()
        
        //Then
        XCTAssertTrue(mockView.updateSpinnerCalled)
        XCTAssertFalse(mockView.spinnerLoading)
        XCTAssertTrue(mockView.updateDetailCalled)
        XCTAssertEqual(mockView.recipe, expectedRecipe)
    }
    
    func testGetDetailFailure() {
        
        //Given
        mockDataSource.mockedRecipe = nil
        
        //When
        sut.getDetail()
        
        //Then
        XCTAssertTrue(mockView.updateSpinnerCalled)
        XCTAssertFalse(mockView.spinnerLoading)
        XCTAssertTrue(mockRouter.showErrorCalled)
        XCTAssertEqual(mockRouter.errorShowed, "No se pudo cargar la receta")
    }
    
    func testShowLocation() {
        
        //When
        sut.showLocation()
        
        //Then
        XCTAssertTrue(mockRouter.showLocationCalled)
        XCTAssertEqual(mockRouter.location, sut.location)
    }
}
