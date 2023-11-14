//
//  RecipeDetailViewModel.swift
//  RecipesApp
//
//  Created by Jhonatan chavez chavez on 10/11/23.
//

import Foundation

protocol RecipeDetailViewModelProtocol: AnyObject {
    var location: String { get }
    var recipe: Recipe? { get }
    func getDetail()
}

class RecipeDetailViewModel{

    let _location: String
    
    private var _recipe:Recipe?
    
    private let recipeId: String
    
    private var service: RecipesServiceProtocol
    
    private weak var view: RecipeDetailViewControllerProtocol?

    init(service: RecipesServiceProtocol = RecipesService(),recipeId:String,location: String,view:RecipeDetailViewControllerProtocol) {
        self.recipeId = recipeId
        self.service = service
        self._location = location
        self.view = view
    }
    
    private func setRecipeModel(from recipeResponse: RecipeResponse?){
        
        guard let recipeResponse else {
            return
        }
        
        let ingredients = getIngredientsText(recipeResponse.ingredients)
        let procedure = getProcedureText(recipeResponse.steps)
        self._recipe = Recipe(name: recipeResponse.name,
                             dificulty: recipeResponse.difficulty ?? "",
                             description: recipeResponse.description ?? "",
                             ingredients: ingredients,
                             urlImg: recipeResponse.imageSrc,
                             procedure: procedure)
    }
    
    
    private func getIngredientsText(_ ingredients: [String]?) -> String {
        guard let ingredients, !ingredients.isEmpty else {
            return "No ingredients available"
        }
        
        return ingredients.joined(separator: "\n")
    }
    
    private func getProcedureText(_ steps: [String: String]?) -> String {
        guard let steps = steps, !steps.isEmpty else {
            return "No steps available"
        }
        
        let sortedSteps = steps.sorted(by: { $0.key < $1.key })
        let stepDescriptions = sortedSteps.map { "Step \($0.key): \($0.value)" }

        return stepDescriptions.joined(separator: "\n\n")
    }
    
}

extension RecipeDetailViewModel: RecipeDetailViewModelProtocol {
    var location: String {
        return _location
    }
    
    var recipe: Recipe? {
        return _recipe
    }
    func getDetail(){
        service.getRecipe(recipeId: recipeId) {recipe in
            DispatchQueue.main.async { [weak self] in
                self?.setRecipeModel(from: recipe)
                self?.view?.updateDetail()
            }
        }
    }
}
