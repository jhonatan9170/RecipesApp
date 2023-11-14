//
//  LocationBuilder.swift
//  RecipesApp
//
//  Created by Jhonatan chavez chavez on 14/11/23.
//

import UIKit

final class LocationBuilder {
    
    private let viewModel: LocationViewModelProtocol
    
    init(baseViewController: UINavigationController, location: String) {
        let router = LocationRouter(navigation: baseViewController)
        viewModel = LocationViewModel(router: router, location: location)
    }
    
    func showScreen() {
        return viewModel.showScreen()
    }
}
