//
//  UserService.swift
//  PruebaBancom
//
//  Created by Jhonatan chavez chavez on 8/11/23.
//

import Foundation


protocol RecipesDataSourceProtocol {
    func getRecipe(recipeId:String , completion: @escaping (RecipeResponse?) -> Void )
    func getRecipes(completion: @escaping (RecipesResponse?) -> Void)
}

class RecipesDataSource:RecipesDataSourceProtocol {
    
    var apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol = APIClient.shared) {
        self.apiClient = apiClient
    }
    
    func getRecipe(recipeId:String , completion: @escaping (RecipeResponse?) -> Void ) {
        let headers = [
            "X-RapidAPI-Key": Constants.rapidAPIKey,
            "X-RapidAPI-Host": Constants.rapidAPIHost
        ]
        let url = Constants.baseAPIURL + recipeId
        apiClient.request(url: url, method: .get, headers: headers, parameters: nil){(result : Result<RecipeResponse, APIClientError>) in
            switch result {
            case .success(let recipe):
                completion(recipe)
            case .failure(_):
                completion(nil)
            }
        }
    }
    func getRecipes(completion: @escaping (RecipesResponse?) -> Void) {
        apiClient.request(url: Constants.recipesURL, method: .get, headers: nil, parameters: nil) { (result : Result<RecipesResponse, APIClientError>) in
            switch result {
            case .success(let recipes):
                completion(recipes)
            case .failure(_):
                completion(nil)
            }
        }
    }
}



