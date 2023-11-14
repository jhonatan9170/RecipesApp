//
//  RecipesVIewModel.swift
//  RecipesApp
//
//  Created by Jhonatan chavez chavez on 10/11/23.
//

import Foundation

protocol RecipesViewModelProtocol {
    
    var recipesToShow: RecipesResponse {get}
    
    func setViewControllerProtocol(view : RecipesViewControllerProtocol)
    func getRecipes()
    func filterByName(text: String)
    func cleanFilter()
    func recipeForCellAtIndex(_ index : Int) -> RecipesElement
    
    func showDetail(index: Int)
    func showScreen()
}

class RecipesViewModel {
    
    private var service: RecipesDataSourceProtocol
    private weak var view:RecipesViewControllerProtocol?
    private let router: RecipesRouterProtocol
    private var _recipesToShow: RecipesResponse = []
    
    private var allRecipes: RecipesResponse = []
    
    init(service: RecipesDataSourceProtocol = RecipesDataSource(),router: RecipesRouterProtocol) {
        self.service = service
        self.router = router
    }
        
}

extension RecipesViewModel:RecipesViewModelProtocol{
    
    var recipesToShow: RecipesResponse {
        return _recipesToShow
    }
    
    func setViewControllerProtocol(view: RecipesViewControllerProtocol) {
        self.view = view
    }
    
    func getRecipes(){
        view?.updateSpinner(loading: true)
        service.getRecipes { recipes in
            guard let recipes else {
                DispatchQueue.main.async { [weak self] in
                    self?.view?.updateSpinner(loading: false)
                    self?.router.showError(error: "No se pudo cargar las recetas")
                }
                return
            }
            DispatchQueue.main.async { [weak self] in
                self?._recipesToShow = recipes
                self?.allRecipes = recipes
                self?.view?.updateSpinner(loading: false)
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

    func showScreen() {
        return router.showScreen(viewModel: self)
    }
    
    func showDetail(index: Int) {
        let recipe = recipeForCellAtIndex(index)
        router.showRecipeDetail(recipe:recipe)
    }

}
