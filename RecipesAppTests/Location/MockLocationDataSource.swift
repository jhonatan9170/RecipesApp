//
//  MockLocationDataSource.swift
//  RecipesAppTests
//
//  Created by Jhonatan chavez chavez on 14/11/23.
//

import CoreLocation
@testable import RecipesApp

class MockLocationDataSource: LocationDateSourceProtocol {
    var mockCoordinate: CLLocationCoordinate2D?
    func coordinate(for location: String, completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        completion(mockCoordinate)
    }
}
