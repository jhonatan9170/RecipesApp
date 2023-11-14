//
//  RecipesVIewModel.swift
//  RecipesApp
//
//  Created by Jhonatan chavez chavez on 10/11/23.
//

import Foundation

protocol RecipesViewModelProtocol {
    var recipesToShow: RecipesResponse {get}
    func getRecipes()
    func filterByName(text: String)
    func cleanFilter()
    func recipeForCellAtIndex(_ index : Int) -> RecipesElement
}

class RecipesViewModel {
    
    private var service: RecipesDataSourceProtocol
    private weak var view: (RecipesViewControllerProtocol)?
    
    var _recipesToShow: RecipesResponse = []
    
    private var allRecipes: RecipesResponse = []
    
    init(service: RecipesDataSourceProtocol = RecipesDataSource(),view: RecipesViewControllerProtocol) {
        self.service = service
        self.view = view
    }
        
}

extension RecipesViewModel:RecipesViewModelProtocol{
    
    var recipesToShow: RecipesResponse {
        return _recipesToShow
    }
    
    func getRecipes(){
        service.getRecipes { recipes in
            guard let recipes else {
                DispatchQueue.main.async { [weak self] in
                    self?.view?.error(error: "No se pudo cargar las recetas")
                }
                return
            }
            DispatchQueue.main.async { [weak self] in
                self?._recipesToShow = recipes
                self?.allRecipes = recipes
                self?.view?.reloadTableView()
            }
        }
    }
    
    func recipeForCellAtIndex(_ index : Int) -> RecipesElement {
        return _recipesToShow[index]
    }
    
    func filterByName(text: String) {
        self._recipesToShow = allRecipes.filter { $0.recipeName.lowercased().contains(text.lowercased()) }
        view?.reloadTableView()
    }
    
    func cleanFilter(){
        self._recipesToShow = self.allRecipes
        view?.reloadTableView()
    }
}
