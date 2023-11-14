//
//  LocationVIewModel.swift
//  RecipesApp
//
//  Created by Jhonatan chavez chavez on 10/11/23.
//

import CoreLocation


protocol LocationViewModelProtocol:AnyObject {
    var coordidates: CLLocationCoordinate2D? { get }
    var location: String { get }
    func getCoordinates()

}

class LocationViewModel {
    
    private var service:LocationServiceProtocol
    private weak var view: LocationViewControllerProtocol?
    private var _location: String
    private var _coordinates: CLLocationCoordinate2D?
    
    init(view: LocationViewControllerProtocol,
         service: LocationServiceProtocol = LocationService(),
         location:String) {
        self.view = view
        _location = location
        self.service = service
    }

}

extension LocationViewModel: LocationViewModelProtocol {
    var coordidates: CLLocationCoordinate2D? {
        return _coordinates
    }
    
    var location: String {
        return _location
    }
    
    func getCoordinates() {
        service.coordinate(for: location) { coordinate in
            DispatchQueue.main.async { [weak self] in
                self?._coordinates = coordinate
                self?.view?.updateMap()
            }
        }
    }
}
