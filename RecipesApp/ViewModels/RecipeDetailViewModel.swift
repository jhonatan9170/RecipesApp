//
//  RecipeDetailViewModel.swift
//  RecipesApp
//
//  Created by Jhonatan chavez chavez on 10/11/23.
//

import Foundation

protocol RecipeDetailViewModelDelegate:AnyObject {
    func success(_ viewModel:RecipeDetailViewModel )
    func error(_ viewModel:RecipeDetailViewModel )
}

class RecipeDetailViewModel{
    
    var recipeId:String
    var title = ""
    var difficulty: String?
    var description: String?
    var urlImage = ""
    var ingredients = ""
    var procedure = ""
    var location = ""
    
    var service:RecipesServiceProtocol
    
    weak var delegate: RecipeDetailViewModelDelegate?


    init(service: RecipesServiceProtocol = RecipesService(),recipeId:String) {
        self.recipeId = recipeId
        self.service = service
    }
    
    func getDetail(){
        service.getRecipe(recipeId: recipeId) {[weak self] recipe in
            guard let self else {
                return
            }
            
            guard let recipe else {
                self.delegate?.error(self)
                return
            }
            
            self.title = recipe.name
            self.description = recipe.description
            self.difficulty = recipe.difficulty
            self.urlImage = recipe.imageSrc
            self.ingredients = self.getIngredientsText(recipe.ingredients)
            self.procedure = self.getProcedureText(recipe.steps)
            self.delegate?.success(self)
        }
    }
    
    func getIngredientsText(_ ingredients: [String]?) -> String {
        guard let ingredients, !ingredients.isEmpty else {
            return "No ingredients available"
        }
        
        return ingredients.joined(separator: "\n")
    }
    
    func getProcedureText(_ steps: [String: String]?) -> String {
        guard let steps = steps, !steps.isEmpty else {
            return "No steps available"
        }
        
        let sortedSteps = steps.sorted(by: { $0.key < $1.key })
        let stepDescriptions = sortedSteps.map { "Step \($0.key): \($0.value)" }

        return stepDescriptions.joined(separator: "\n\n")
    }
    
}
