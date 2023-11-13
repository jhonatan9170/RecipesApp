//
//  LocationVIewModel.swift
//  RecipesApp
//
//  Created by Jhonatan chavez chavez on 10/11/23.
//

import CoreLocation


protocol LocationViewModelDelegate:AnyObject {
    func success(_ viewModel:LocationViewModel )
    func error(_ viewModel:LocationViewModel )
}

class LocationViewModel {
    
    var service:LocationServiceProtocol
    
    weak var delegate: LocationViewModelDelegate?
    
    let location:String
    
    var coordinates:CLLocationCoordinate2D?
    
    init(service: LocationServiceProtocol = LocationService(), location:String) {
        self.location = location
        self.service = service
    }
    
    func getCoordinates() {
        service.coordinate(for: location) {[weak self] coordinate in
            guard let self else {
                return
            }
            guard let coordinate else {
                self.delegate?.error(self)
                return
            }
            self.coordinates = coordinate
            self.delegate?.success(self)
        }
    }
}
