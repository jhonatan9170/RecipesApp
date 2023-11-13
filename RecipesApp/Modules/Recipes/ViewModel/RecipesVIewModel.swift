//
//  RecipesVIewModel.swift
//  RecipesApp
//
//  Created by Jhonatan chavez chavez on 10/11/23.
//

import Foundation

protocol RecipesViewModelDelegate:AnyObject {
    func success(_ viewModel:RecipesViewModel )
    func error(_ viewModel:RecipesViewModel )
}

class RecipesViewModel {
    
    var service:RecipesServiceProtocol
    
    weak var delegate: RecipesViewModelDelegate?
    
    var recipes:RecipesResponse = []
    var allRecipes:RecipesResponse = []
    
    init(service: RecipesServiceProtocol = RecipesService()) {
        self.service = service
    }
    
    func getRecipes(){
        service.getRecipes {[weak self] recipes in
            guard let self else {return}
            
            guard let recipes else {
                self.delegate?.error(self)
                return
            }
            self.recipes = recipes
            self.allRecipes = recipes
            self.delegate?.success(self)
        }
    }
    
    func recipeForCellAtIndex(_ index : Int) -> RecipesElement {
        return recipes[index]
    }
    
    func recipeIdForCellAtIndex(_ index : Int) -> String {
        return recipes[index].recipeId
    }
    
    func filterByName(text: String) {
        self.recipes = allRecipes.filter { $0.recipeName.lowercased().contains(text.lowercased()) }
        self.delegate?.success(self)
    }
    
    func cleanFilter(){
        self.recipes = self.allRecipes
        self.delegate?.success(self)
    }
    
}
