//
//  LocationVIewModel.swift
//  RecipesApp
//
//  Created by Jhonatan chavez chavez on 10/11/23.
//

import CoreLocation


protocol LocationViewModelProtocol:AnyObject {
    var location: String { get }
    func setViewControllerProtocol(view: LocationViewControllerProtocol)
    func getCoordinates()
    
    func showScreen()

}

class LocationViewModel {
    
    private var service:LocationDateSourceProtocol
    private weak var view: LocationViewControllerProtocol?
    private let router: LocationRouterProtocol
    private var _location: String
    private let mainDispatchQueue: DispatchQueueType
    
    init( service: LocationDateSourceProtocol = LocationDataSource(),router:LocationRouter, location:String,mainDispatchQueue: DispatchQueueType = DispatchQueue.main) {
        _location = location
        self.service = service
        self.router = router
        self.mainDispatchQueue = mainDispatchQueue
    }

}

extension LocationViewModel: LocationViewModelProtocol {
    
    var location: String {
        return _location
    }
    
    func setViewControllerProtocol(view: LocationViewControllerProtocol) {
        self.view = view
    }
    
    func getCoordinates() {
        view?.updateSpinner(loading: true)
        service.coordinate(for: location) { [weak self]coordinate in
            guard let coordinate else  {
                self?.mainDispatchQueue.async { [weak self] in
                    self?.view?.updateSpinner(loading: false)
                    self?.router.showError(error: "No se cargaron las coordenadas")
                }
                return
            }
            self?.mainDispatchQueue.async { [weak self] in
                self?.view?.updateSpinner(loading: false)
                self?.view?.updateMap(with: coordinate)
            }
        }
    }

    func showScreen() {
        router.showScreen(viewModel: self)
    }
}
