//
//  LocationRouter.swift
//  RecipesApp
//
//  Created by Jhonatan chavez chavez on 14/11/23.
//

import UIKit

protocol LocationRouterProtocol {
    func showScreen(viewModel: LocationViewModelProtocol)
    func showError(error: String)
}

class LocationRouter{
    var navigation: UINavigationController?
    
    init(navigation: UINavigationController? = nil) {
        self.navigation = navigation
    }
}
extension LocationRouter: LocationRouterProtocol{
    func showScreen(viewModel: LocationViewModelProtocol) {
        let viewController = LocationViewController(viewModel: viewModel)
        navigation?.pushViewController(viewController, animated: true)
    }
    
    func showError(error: String) {
        navigation?.showErrorAlert(error: error)
    }
}
