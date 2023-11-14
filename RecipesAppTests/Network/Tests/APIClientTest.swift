//
//  APIClientTest.swift
//  RecipesAppTests
//
//  Created by Jhonatan chavez chavez on 9/11/23.
//

import XCTest
@testable import RecipesApp

final class APIClientTests: XCTestCase {
    
    var sut: APIClient!
    var mockURLSession: MockURLSession!
    
    override func setUp() {
        super.setUp()
        sut = APIClient.shared
        mockURLSession = MockURLSession()
        sut.session = mockURLSession
    }
    
    override func tearDown() {
        sut = nil
        mockURLSession = nil
        super.tearDown()
    }
    
    func testRequestWithInvalidURL() {
        
        //GIVEN
        let expectation = self.expectation(description: "Completion handler invoked with error")
        // WHEN
        sut.request(url: "ht tp://invalid-url", method: .get) { (result: Result<MockDecodable, APIClientError>) in
            //RESULT
            switch result {
            case .failure(let apiError):
                if case .badURL = apiError {
                    expectation.fulfill()
                } else {
                    XCTFail("Expected bad URL error, received another error.")
                }
            case .success:
                XCTFail("Expected bad URL error, received success.")
            }
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testRequestWithNetworkError() {
        func testRequestWithNetworkError() {
            
            //GIVEN
            let expectation = self.expectation(description: "Network error")
            
            // WHEN
            sut.request(url: "https://example.com", method: .get) { (result: Result<MockDecodable, APIClientError>) in
                //RESULT
                switch result {
                case .failure(let apiError):
                    if case .networkError = apiError {
                        expectation.fulfill()
                    } else {
                        XCTFail("Expected network error, received another error.")
                    }
                case .success:
                    XCTFail("Expected network error, received success.")
                }
            }
            waitForExpectations(timeout: 1, handler: nil)
        }
    }
    
    func testRequestWithBadHTTResponse() {
        
        //GIVEN
        let expectation = self.expectation(description: "Decoding error")
        let urlResponse = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 400, httpVersion: nil, headerFields: nil)
        mockURLSession.nextResponse = urlResponse
        
        // WHEN
        sut.request(url: "https://example.com", method: .get) { (result: Result<MockDecodable, APIClientError>) in
            //RESULT
            switch result {
            case .failure(let apiError):
                if case .httpError(_) = apiError {
                    expectation.fulfill()
                } else {
                    XCTFail("Expected decoding error, received another error.")
                }
            case .success:
                XCTFail("Expected decoding error, received success.")
            }
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testRequestWithDecodingError() {
        
        //GIVEN
        let expectation = self.expectation(description: "Decoding error")
        let incorrectJSONData = "{\"incorrectKey\":\"value\"}".data(using: .utf8)
        mockURLSession.nextData = incorrectJSONData
        
        // WHEN
        sut.request(url: "https://example.com", method: .get) { (result: Result<MockDecodable, APIClientError>) in
            //RESULT
            switch result {
            case .failure(let apiError):
                if case .decodingError = apiError {
                    expectation.fulfill()
                } else {
                    XCTFail("Expected decoding error, received another error.")
                }
            case .success:
                XCTFail("Expected decoding error, received success.")
            }
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testGetRequestSuccess() {
        
        //GIVEN
        let expectation = self.expectation(description: "GET request successful")
        mockURLSession.nextError = nil
        let correctJSONData = "{\"key\":\"value\"}".data(using: .utf8)
        mockURLSession.nextData = correctJSONData
        
        // WHEN
        sut.request(url: "https://example.com", method: .get) { (result: Result<MockDecodable, APIClientError>) in
            //RESULT
            switch result {
            case .success(let decodedData):
                XCTAssertEqual(decodedData.key, "value", "Decoded data should match the mock data")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Expected successful GET request")
            }
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
}
struct MockDecodable: Codable {
    let key: String
}
