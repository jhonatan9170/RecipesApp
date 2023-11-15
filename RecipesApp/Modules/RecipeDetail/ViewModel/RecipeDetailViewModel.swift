//
//  RecipeDetailViewModel.swift
//  RecipesApp
//
//  Created by Jhonatan chavez chavez on 10/11/23.
//

import Foundation

protocol RecipeDetailViewModelProtocol: AnyObject {
    var location: String { get }
    func getDetail()
    
    func setViewControllerProtocol(view : RecipeDetailViewControllerProtocol)
    func showScreen()
    func showLocation()
}

class RecipeDetailViewModel{

    let _location: String
        
    private let recipeId: String
    
    private var service: RecipesDataSourceProtocol
    
    private weak var view: RecipeDetailViewControllerProtocol?
    private let router: RecipeDetailRouterProtocol
    private let mainDispatchQueue: DispatchQueueType

    init(service: RecipesDataSourceProtocol = RecipesDataSource(),router: RecipeDetailRouterProtocol, recipeId: String, location: String,mainDispatchQueue: DispatchQueueType = DispatchQueue.main) {
        self.service = service
        self.recipeId = recipeId
        self._location = location
        self.router = router
        self.mainDispatchQueue = mainDispatchQueue
    }
    
    private func getRecipeModel(from recipeResponse: RecipeResponse)->Recipe{
        let ingredients = getIngredientsText(recipeResponse.ingredients)
        let procedure = getProcedureText(recipeResponse.steps)
        return Recipe(name: recipeResponse.name,
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
    
    func setViewControllerProtocol(view: RecipeDetailViewControllerProtocol) {
        self.view = view
    }
    
    func getDetail(){
        view?.updateSpinner(loading: true)
        service.getRecipe(recipeId: recipeId) { [weak self ] recipe in
            guard let recipe else {
                self?.mainDispatchQueue.async { [weak self] in
                    self?.view?.updateSpinner(loading: false)
                    self?.router.showError(error: "No se pudo cargar la receta")
                }
                return
            }
            self?.mainDispatchQueue.async { [weak self] in
                if let self {
                    self.view?.updateSpinner(loading: false)
                    self.view?.updateDetail(with: self.getRecipeModel(from: recipe))
                }
            }
        }
    }
    

    
    func showScreen() {
        router.showScreen(viewModel: self)
    }
    
    func showLocation() {
        router.showLocation(location: location)
    }
    
}
