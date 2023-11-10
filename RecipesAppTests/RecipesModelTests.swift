//
//  RecipesModelTests.swift
//  RecipesAppTests
//
//  Created by Jhonatan chavez chavez on 10/11/23.
//

import XCTest
@testable import RecipesApp

class RecipesServiceTests: XCTestCase {

    var recipesService: RecipesService!
    var mockAPIClient: MockAPIClient!
    
    override func setUp() {
        super.setUp()
        recipesService = RecipesService()
        mockAPIClient = MockAPIClient()
        recipesService.apiClient = mockAPIClient
       
    }
    
    override func tearDown() {
        recipesService = nil
        mockAPIClient = nil
        super.tearDown()
    }
    
    func testGetRecipeFailure() {

        let expectation = self.expectation(description: "GetRecipeFailure")
        
        let expectedRecipeResponse = RecipeResponse(name: "Test name", imageSrc: "www.explample.com/test.png", difficulty: nil, description: nil, ingredients: nil, steps: nil)
        var recipeResult: RecipeResponse?
        
        mockAPIClient.error = .networkError
        mockAPIClient.recipeResponse = expectedRecipeResponse
        
        recipesService.getRecipe(recipeId: "testID") { recipe in
            recipeResult = recipe
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertNil(recipeResult)
    }
    
    func testGetRecipeSuccess() {
        let expectation = self.expectation(description: "GetRecipeSuccess")

        let expectedRecipeResponse = RecipeResponse(name: "Test name", imageSrc: "www.explample.com/test.png", difficulty: nil, description: nil, ingredients: nil, steps: nil)

        mockAPIClient.recipeResponse = expectedRecipeResponse
        
        var recipeResponseResult: RecipeResponse?
        
        recipesService.getRecipe(recipeId: "testID") { recipe in
            recipeResponseResult = recipe
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertNotNil(recipeResponseResult)
        XCTAssertEqual(recipeResponseResult, expectedRecipeResponse)

    }

    func testGetRecipesFailure() {

        let expectation = self.expectation(description: "GetRecipesFailure")
        
        let expectedRecipesResponse = [RecipesElement(origen: "Lima", recipeId: "lomo-saltado", recipeName: "Lomo saltado", description: "Test desco", additionalInfo: nil, imageSrc: nil)]
        var recipesResult: RecipesResponse?
        
        mockAPIClient.error = .networkError
        mockAPIClient.recipesResponse = expectedRecipesResponse
        
        recipesService.getRecipes() { recipes in
            recipesResult = recipes
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertNil(recipesResult)
    }
    
    func testGetRecipesSuccess() {
        let expectation = self.expectation(description: "GetRecipesSuccess")
        
        let expectedRecipesResponse = [RecipesElement(origen: "Lima", recipeId: "lomo-saltado", recipeName: "Lomo saltado", description: "Test desco", additionalInfo: nil, imageSrc: nil)]
        var recipesResult: RecipesResponse?
        
        mockAPIClient.recipesResponse = expectedRecipesResponse
        
        recipesService.getRecipes() { recipes in
            recipesResult = recipes
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertNotNil(recipesResult)
        XCTAssertEqual(recipesResult, expectedRecipesResponse)
    }
}


class MockAPIClient: APIClientProtocol {
    var recipeResponse: RecipeResponse?
    var recipesResponse: RecipesResponse?
    var error: APIClientError?
    
    
    func request<T>(
        url: String,
        method: HTTPMethod,
        headers: [String: String]?,
        parameters: [String: Any]?,
        completion: @escaping (Result<T, APIClientError>) -> Void
    ) where T: Codable {
        if let error  {
            completion(.failure(error))
            return
        }
        if let recipeResponse =  recipeResponse as? T {
            completion(.success(recipeResponse))
            return
        }
        if let recipesResponse = recipesResponse as? T {
            completion(.success(recipesResponse))
            return
        }
        completion(.failure(.decodingError))
    }
}
