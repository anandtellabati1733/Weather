//
//  APIRequestTests.swift
//  Weather
//
//  Created by Anand on 10/29/24.
//

import XCTest

@testable import Weather

class APIRequestTests: XCTestCase {

    //MARK: - Declare variables
    var sut: APIRequest!
    
    //MARK: - Configure and initialize setup process
    override func setUp() {
        super.setUp()
        sut = MockRequest()
    }
    
    //MARK: - Execute and validate test cases
    func testSuccessfulRequest() {
        let request = sut.request()
        XCTAssertNotNil(request.httpMethod, "HTTP Method should be there.")
        XCTAssertEqual(request.httpMethod, HTTPMethod.GET.rawValue, "HTTP Methods should be same.")
        XCTAssertNotNil(request.url, "URL should be there.")
        XCTAssertEqual(request.url?.absoluteString, "http://api.openweathermap.org/data/2.5/weather?appid=2db00a6ab478969db2453b95f26b9f6a", "URL should be there.")
        XCTAssertNil(request.httpBody, "There is no body for the request.")
        XCTAssertNotNil(request.allHTTPHeaderFields, "Header Fields should be there.")
    }
    
    func testFailureRequest() {
        let request = sut.request()
        XCTAssertNotEqual(request.httpMethod, "empty","HTTP Method shouldn't be empty.")
        XCTAssertNotEqual(request.url?.absoluteString, "empty", "URL shouldn't be empty.")
        XCTAssertNotEqual(request.httpBody, Data(), "Data should be empty")
        XCTAssertNotEqual(request.allHTTPHeaderFields, [:], "Header Fields should not be empty.")
    }
    
    //MARK: - Teardown
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
}

struct MockRequest: APIRequest {
    var method: HTTPMethod = .GET
    var path: EndPoint = .todayForecast
    var parameters: [EndPoint : String] = [:]
    var body: [String : Any]? = nil
}

struct Model: Codable {}
