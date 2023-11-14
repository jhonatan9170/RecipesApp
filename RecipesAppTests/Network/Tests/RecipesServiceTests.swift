//
//  RecipesModelTests.swift
//  RecipesAppTests
//
//  Created by Jhonatan chavez chavez on 10/11/23.
//

import XCTest
@testable import RecipesApp

final class RecipesServiceTests: XCTestCase {

    var sut: RecipesDataSource!
    var mockAPIClient: MockAPIClient!
    
    override func setUp() {
        super.setUp()
        sut = RecipesDataSource()
        mockAPIClient = MockAPIClient()
        sut.apiClient = mockAPIClient
       
    }
    
    override func tearDown() {
        sut = nil
        mockAPIClient = nil
        super.tearDown()
    }
    
    func testGetRecipeFailure() {

        //GIVEN
        let expectation = self.expectation(description: "GetRecipeFailure")
        let expectedRecipeResponse = RecipeResponse(name: "Test name", imageSrc: "www.explample.com/test.png", difficulty: nil, description: nil, ingredients: nil, steps: nil)
        var recipeResult: RecipeResponse?
        mockAPIClient.error = .networkError
        mockAPIClient.recipeResponse = expectedRecipeResponse
        
        //WHEN
        sut.getRecipe(recipeId: "testID") { recipe in
            recipeResult = recipe
            expectation.fulfill()
        }
        
        //THEN
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertNil(recipeResult)
    }
    
    func testGetRecipeSuccess() {
        
        //GIVEN
        let expectation = self.expectation(description: "GetRecipeSuccess")
        let expectedRecipeResponse = RecipeResponse(name: "Test name", imageSrc: "www.explample.com/test.png", difficulty: nil, description: nil, ingredients: nil, steps: nil)
        mockAPIClient.recipeResponse = expectedRecipeResponse
        var recipeResponseResult: RecipeResponse?
        
        //WHEN
        sut.getRecipe(recipeId: "testID") { recipe in
            recipeResponseResult = recipe
            expectation.fulfill()
        }
        
        //THEN
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertNotNil(recipeResponseResult)
        XCTAssertEqual(recipeResponseResult, expectedRecipeResponse)

    }

    func testGetRecipesFailure() {
        
        //GIVEN
        let expectation = self.expectation(description: "GetRecipesFailure")
        let expectedRecipesResponse = [RecipesElement(origen: "Lima", recipeId: "lomo-saltado", recipeName: "Lomo saltado", description: "Test desco", additionalInfo: nil, imageSrc: nil)]
        var recipesResult: RecipesResponse?
        mockAPIClient.error = .networkError
        mockAPIClient.recipesResponse = expectedRecipesResponse
        
        //WHEN
        sut.getRecipes() { recipes in
            recipesResult = recipes
            expectation.fulfill()
        }

        //THEN
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertNil(recipesResult)
    }
    
    func testGetRecipesSuccess() {
        
        //GIVEN
        let expectation = self.expectation(description: "GetRecipesSuccess")
        let expectedRecipesResponse = [RecipesElement(origen: "Lima", recipeId: "lomo-saltado", recipeName: "Lomo saltado", description: "Test desco", additionalInfo: nil, imageSrc: nil)]
        var recipesResult: RecipesResponse?
        mockAPIClient.recipesResponse = expectedRecipesResponse
        
        //WHEN
        sut.getRecipes() { recipes in
            recipesResult = recipes
            expectation.fulfill()
        }

        //THEN
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertNotNil(recipesResult)
        XCTAssertEqual(recipesResult, expectedRecipesResponse)
    }
}


