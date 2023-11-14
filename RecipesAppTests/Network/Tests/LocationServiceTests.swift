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

    var sut: LocationDataSource!
    var mockGeoCoder: MockGeoCoder!

    override func setUp() {
        super.setUp()
        mockGeoCoder = MockGeoCoder()
        sut = LocationDataSource()
        sut.geoCoder = mockGeoCoder
    }

    override func tearDown() {
        sut = nil
        mockGeoCoder = nil
        super.tearDown()
    }

    func testCoordinateForAddress_Success() {
        
        //GIVEN
        let expectation = self.expectation(description: "Geocoding")
        let expectedCoordinate = CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060) // Example coordinates
        mockGeoCoder.mockCoordinate = expectedCoordinate
        
        //WHEN
        sut.coordinate(for: "New York") { coordinate in
            
            //THEN
            XCTAssertEqual(coordinate?.latitude, expectedCoordinate.latitude)
            XCTAssertEqual(coordinate?.longitude, expectedCoordinate.longitude)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testCoordinateForAddress_Error() {
        
        ///GIVEN
        let expectation = self.expectation(description: "Geocoding")
        mockGeoCoder.shouldReturnError = true

        //WHEN
        sut.coordinate(for: "Invalid Address") { coordinate in
            
            //THEN
            XCTAssertNil(coordinate)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}
