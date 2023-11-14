//
//  MockGeocoder.swift
//  RecipesAppTests
//
//  Created by Jhonatan chavez chavez on 14/11/23.
//

import Foundation
import MapKit

@testable import RecipesApp

class MockGeoCoder: GeoCoderProtocol {
    var shouldReturnError: Bool = false
    var mockCoordinate: CLLocationCoordinate2D?

    func geocodeAddressString(_ addressString: String, completionHandler: @escaping CLGeocodeCompletionHandler) {
        if shouldReturnError {
            completionHandler(nil, NSError(domain: "GeocodingError", code: 0, userInfo: nil))
        } else if let coordinate = mockCoordinate {
            let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
            let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: nil)
            completionHandler([placemark], nil)
        } else {
            completionHandler(nil, nil)
        }
    }
}
