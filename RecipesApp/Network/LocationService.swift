//
//  LocationService.swift
//  RecipesApp
//
//  Created by Jhonatan chavez chavez on 10/11/23.
//

import CoreLocation

class LocationService:LocationServiceProtocol {
    
    var geoCoder: GeoCoderProtocol = CLGeocoder()
    func coordinate(for address: String, completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        geoCoder.geocodeAddressString(address) { places , error in
            guard let coordinate = places?.first?.location?.coordinate  else {
                completion(nil)
                return
            }
            let latitude = coordinate.latitude
            let longitude = coordinate.longitude
            
            completion(CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        }
    }
    
}

protocol LocationServiceProtocol {
    func coordinate(for address:String,completion: @escaping (CLLocationCoordinate2D?)-> Void)
}

protocol GeoCoderProtocol {
    func geocodeAddressString(_ addressString: String, completionHandler: @escaping CLGeocodeCompletionHandler)
}

extension CLGeocoder: GeoCoderProtocol {
    
}
