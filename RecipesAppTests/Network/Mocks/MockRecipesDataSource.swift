//
//  MockRecipesDataSource.swift
//  RecipesAppTests
//
//  Created by Jhonatan chavez chavez on 14/11/23.
//

import Foundation
@testable import RecipesApp

class MockRecipesDataSource: RecipesDataSourceProtocol {

    var mockedRecipe: RecipeResponse?
    var mockedRecipes: RecipesResponse?

    func getRecipes(completion: @escaping (RecipesResponse?) -> Void) {
       completion(mockedRecipes)

    }
    
    func getRecipe(recipeId: String, completion: @escaping (RecipeResponse?) -> Void) {
        completion(mockedRecipe)
    }
}
