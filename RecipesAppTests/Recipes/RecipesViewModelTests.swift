//
//  RecipesViewModelTests.swift
//  RecipesAppTests
//
//  Created by Jhonatan chavez chavez on 10/11/23.
//

import XCTest
@testable import RecipesApp

class RecipesViewModelTests: XCTestCase {

    var sut: RecipesViewModel!
    var mockDataSource: MockRecipesDataSource!
    var mockView: MockRecipesViewController!
    var mockRouter: MockRecipesRouter!
    var dispatchQueueMock:DispatchQueueType!

    override func setUp() {
        super.setUp()
        mockDataSource = MockRecipesDataSource()
        mockView = MockRecipesViewController()
        mockRouter = MockRecipesRouter()
        dispatchQueueMock = DispatchQueueMock()
        sut = RecipesViewModel(service: mockDataSource, router: mockRouter,mainDispatchQueue: dispatchQueueMock)
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

    func testGetRecipesSuccess() {
        
        // Given
        let expectedRecipes = [RecipesElement(origen: "Ica", recipeId: "lomo-saltado", recipeName: "Lomo Saltado", description: "Test description", additionalInfo: nil, imageSrc: nil)]
        mockDataSource.mockedRecipes = expectedRecipes
        
        // When
        sut.getRecipes()
        // Then
        XCTAssertEqual(self.sut.recipesToShow, expectedRecipes)
        XCTAssertFalse(self.mockView.spinnerLoading)
        XCTAssertTrue(self.mockView.updateSpinnerCalled)
        XCTAssertTrue(self.mockView.reloadTableViewCalled)
        
    }

    func testGetRecipesFailure() {
        // Given
        mockDataSource.mockedRecipes = nil

        // When
        sut.getRecipes()

        // Then
        XCTAssertTrue(sut.recipesToShow.isEmpty)
        XCTAssertTrue(mockView.updateSpinnerCalled)
        XCTAssertFalse(mockView.spinnerLoading)
        XCTAssertFalse(mockView.reloadTableViewCalled)
        XCTAssertTrue(mockRouter.showErrorCalled)
        XCTAssertEqual(mockRouter.errorShowed, "No se pudo cargar las recetas")
    }

    func testFilterByName() {
        // Given
        let allRecipes = [RecipesElement(origen: "Ica", recipeId: "lomo-saltado", recipeName: "Lomo Saltado", description: "Test1 description", additionalInfo: nil, imageSrc: nil),
                          RecipesElement(origen: "Cajamarca", recipeId: "causa-rellena", recipeName: "Causa Rellena", description: "Test2 description", additionalInfo: nil, imageSrc: nil)
        ]
        let expectedFilteredRecipes = [allRecipes[0]]
        mockDataSource.mockedRecipes = allRecipes
        // When
        sut.getRecipes()
        sut.filterByName(text: "Lomo")

        // Then
        XCTAssertEqual(sut.recipesToShow, expectedFilteredRecipes)
        XCTAssertTrue(mockView.reloadTableViewCalled)
    }

    func testCleanFilter() {
        // Given
        let allRecipes = [RecipesElement(origen: "Ica", recipeId: "lomo-saltado", recipeName: "Lomo Saltado", description: "Test1 description", additionalInfo: nil, imageSrc: nil),
                          RecipesElement(origen: "Cajamarca", recipeId: "causa-rellena", recipeName: "Causa Rellena", description: "Test2 description", additionalInfo: nil, imageSrc: nil)
        ]
        mockDataSource.mockedRecipes = allRecipes

        // When
        sut.getRecipes()
        sut.filterByName(text: "xxxxxxxx")
        sut.cleanFilter()

        // Then
        XCTAssertEqual(sut.recipesToShow, allRecipes)
        XCTAssertTrue(mockView.reloadTableViewCalled)
    }

    func testShowDetail() {
        // Given
        let allRecipes = [RecipesElement(origen: "Ica", recipeId: "lomo-saltado", recipeName: "Lomo Saltado", description: "Test1 description", additionalInfo: nil, imageSrc: nil),
                          RecipesElement(origen: "Cajamarca", recipeId: "causa-rellena", recipeName: "Causa Rellena", description: "Test2 description", additionalInfo: nil, imageSrc: nil)]
        let expectedRecipe = allRecipes[0]

        // When
        mockDataSource.mockedRecipes = allRecipes
        sut.getRecipes()
        sut.showDetail(index: 0)

        // Then
        XCTAssertTrue(mockRouter.showRecipeDetailCalled)
        XCTAssertEqual(mockRouter.recipe, expectedRecipe)
                          
    }

    func testShowScreen() {
        // When
        sut.showScreen()

        // Then
        XCTAssertTrue(mockRouter.showScreenCalled)
    }
}
