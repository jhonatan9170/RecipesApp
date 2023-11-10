//
//  RecipeModel.swift
//  RecipesApp
//
//  Created by Jhonatan chavez chavez on 10/11/23.
//

import Foundation

// MARK: - Recipe
struct RecipeResponse: Codable {
    let name: String
    let imageSrc: String
    let difficulty, description: String?
    let ingredients: [String]?
    let steps: [String: String]?
}

extension RecipeResponse: Equatable {
    
}
