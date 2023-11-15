//
//  LocationTests.swift
//  RecipesAppTests
//
//  Created by Jhonatan chavez chavez on 14/11/23.
//

import XCTest
import CoreLocation
@testable import RecipesApp

final class LocationViewMoodelTests: XCTestCase {
    
    var sut: LocationViewModel!
    var mockDataSource: MockLocationDataSource!
    var mockView: MockLocationView!
    var mockRouter: MockLocationRouter!
    var dispatchQueueMock:DispatchQueueType!

    override func setUp() {
        super.setUp()
        mockDataSource = MockLocationDataSource()
        mockView = MockLocationView()
        mockRouter = MockLocationRouter()
        dispatchQueueMock = DispatchQueueMock()
        sut = LocationViewModel(service: mockDataSource, router: mockRouter, location: "Test Location",mainDispatchQueue: dispatchQueueMock)
        sut.setViewControllerProtocol(view: mockView)
    }
    
    override func tearDown() {
        sut = nil
        mockDataSource = nil
        mockView = nil
        mockRouter = nil
        dispatchQueueMock = nil 
        super.tearDown()
    }
    
    func testGetCoordinatesSuccess() {
        // Given
        let mockCoordinate = CLLocationCoordinate2D(latitude: 123.456, longitude: 78.910)
        mockDataSource.mockCoordinate = mockCoordinate
        
        // When
        sut.getCoordinates()
        
        // Then
        XCTAssertTrue(mockView.updateSpinnerCalled)
        XCTAssertFalse(mockView.spinnerLoading)
        XCTAssertTrue(mockView.updateMapCalled)
        XCTAssertEqual(mockView.coordinate?.latitude, mockCoordinate.latitude)
        XCTAssertEqual(mockView.coordinate?.longitude, mockCoordinate.longitude)

    }
    func testGetCoordinatesFailure() {
        // Given
        mockDataSource.mockCoordinate = nil
        
        // When
        sut.getCoordinates()
        
        // Then
        XCTAssertTrue(mockView.updateSpinnerCalled)
        XCTAssertTrue(mockRouter.showErrorCalled)
        XCTAssertEqual(mockRouter.errorShowed, "No se cargaron las coordenadas")
    }
}

