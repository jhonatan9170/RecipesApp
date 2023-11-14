//
//  LocationServiceTests.swift
//  RecipesAppTests
//
//  Created by Jhonatan chavez chavez on 10/11/23.
//

import XCTest
import MapKit
@testable import RecipesApp

class LocationServiceTests: XCTestCase {

    var locationService: LocationDataSource!
    var mockGeoCoder: MockGeoCoder!

    override func setUp() {
        super.setUp()
        mockGeoCoder = MockGeoCoder()
        locationService = LocationDataSource()
        locationService.geoCoder = mockGeoCoder
    }

    override func tearDown() {
        locationService = nil
        mockGeoCoder = nil
        super.tearDown()
    }

    func testCoordinateForAddress_Success() {
        let expectedCoordinate = CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060) // Example coordinates
        mockGeoCoder.mockCoordinate = expectedCoordinate

        let expectation = self.expectation(description: "Geocoding")
        locationService.coordinate(for: "New York") { coordinate in
            XCTAssertEqual(coordinate?.latitude, expectedCoordinate.latitude)
            XCTAssertEqual(coordinate?.longitude, expectedCoordinate.longitude)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testCoordinateForAddress_Error() {
        mockGeoCoder.shouldReturnError = true

        let expectation = self.expectation(description: "Geocoding")
        locationService.coordinate(for: "Invalid Address") { coordinate in
            XCTAssertNil(coordinate)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}

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
