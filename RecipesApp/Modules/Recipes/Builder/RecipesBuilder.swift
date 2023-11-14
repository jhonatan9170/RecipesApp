//
//  RecipesBuilder.swift
//  RecipesApp
//
//  Created by Jhonatan chavez chavez on 14/11/23.
//

import UIKit

final class RecipesBuilder {
    private let viewModel: RecipesViewModelProtocol
    
    init(window: UIWindow) {
        let router = RecipesRouter(window: window)
        viewModel = RecipesViewModel(router: router)
    }
    
    func showScreen() {
        return viewModel.showScreen()
    }
}
