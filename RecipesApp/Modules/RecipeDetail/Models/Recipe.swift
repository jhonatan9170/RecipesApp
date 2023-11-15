//
//  Recipe.swift
//  RecipesApp
//
//  Created by Jhonatan chavez chavez on 13/11/23.
//

import Foundation

struct Recipe {
    let name: String
    let dificulty: String
    let description: String
    let ingredients: String
    let urlImg: String
    let procedure: String
}
extension Recipe:Equatable {
    
}


