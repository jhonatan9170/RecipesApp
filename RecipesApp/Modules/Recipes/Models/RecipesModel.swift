//
//  RecipesModel.swift
//  RecipesApp
//
//  Created by Jhonatan chavez chavez on 10/11/23.
//

import Foundation

typealias RecipesResponse = [RecipesElement]

struct RecipesElement: Codable {
    let origen, recipeId, recipeName, description: String
    let additionalInfo: AdditionalInfo?
    let imageSrc: String?
}

// MARK: - AdditionalInfo
struct AdditionalInfo: Codable {
    let timeToPrepare: String
    let difficulty: String?
    let type: String?
}

extension RecipesElement:Equatable {
    static func == (lhs: RecipesElement, rhs: RecipesElement) -> Bool {
        return lhs.recipeId == rhs.recipeId
    }
}
