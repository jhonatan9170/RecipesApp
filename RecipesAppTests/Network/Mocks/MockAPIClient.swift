//
//  MockAPIClient.swift
//  RecipesAppTests
//
//  Created by Jhonatan chavez chavez on 14/11/23.
//

import Foundation
@testable import RecipesApp

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
