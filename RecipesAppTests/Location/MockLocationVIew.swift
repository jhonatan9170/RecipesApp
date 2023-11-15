//
//  MockLocationVIew.swift
//  RecipesAppTests
//
//  Created by Jhonatan chavez chavez on 14/11/23.
//

import CoreLocation
@testable import RecipesApp

class MockLocationView: LocationViewControllerProtocol {
    var updateSpinnerCalled = false
    var spinnerLoading = false
    var updateMapCalled = false
    var coordinate:CLLocationCoordinate2D?
    
    func updateSpinner(loading: Bool) {
        updateSpinnerCalled = true
        spinnerLoading = loading
    }

    func updateMap(with coordinate: CLLocationCoordinate2D) {
        updateMapCalled = true
        self.coordinate = coordinate
    }
}
