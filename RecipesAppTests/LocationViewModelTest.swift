//
//  LocationViewModelTest.swift
//  RecipesAppTests
//
//  Created by Jhonatan chavez chavez on 10/11/23.
//

import XCTest
import CoreLocation
@testable import RecipesApp

class MockLocationService: LocationServiceProtocol {
    var mockCoordinates: CLLocationCoordinate2D?
    var shouldReturnError: Bool = false

    func coordinate(for address: String, completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        if shouldReturnError {
            completion(nil)
        } else {
            completion(mockCoordinates)
        }
    }
}

class LocationViewModelTests: XCTestCase {
    
    var viewModel: LocationViewModel!
    var mockService: MockLocationService!
    var delegate: MockLocationViewModelDelegate!

    override func setUp() {
        super.setUp()
        mockService = MockLocationService()
        viewModel = LocationViewModel(service: mockService, location: "Test Location")
        delegate = MockLocationViewModelDelegate()
        viewModel.delegate = delegate
    }

    override func tearDown() {
        viewModel = nil
        mockService = nil
        delegate = nil
        super.tearDown()
    }

    func testGetCoordinates_Success() {
        let expectedCoordinate = CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060) // Example coordinates
        mockService.mockCoordinates = expectedCoordinate

        viewModel.getCoordinates()

        XCTAssertTrue(delegate.successCalled)
        XCTAssertFalse(delegate.errorCalled)
        XCTAssertEqual(viewModel.coordinates?.latitude, expectedCoordinate.latitude)
        XCTAssertEqual(viewModel.coordinates?.longitude, expectedCoordinate.longitude)
    }

    func testGetCoordinates_Failure() {
        mockService.shouldReturnError = true

        viewModel.getCoordinates()

        XCTAssertFalse(delegate.successCalled)
        XCTAssertTrue(delegate.errorCalled)
        XCTAssertNil(viewModel.coordinates)
    }
}

class MockLocationViewModelDelegate: LocationViewModelDelegate {
    var successCalled = false
    var errorCalled = false

    func success(_ viewModel: LocationViewModel) {
        successCalled = true
    }

    func error(_ viewModel: LocationViewModel) {
        errorCalled = true
    }
}
