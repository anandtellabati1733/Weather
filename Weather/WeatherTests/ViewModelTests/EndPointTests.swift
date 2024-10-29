//
//  EndPointTests.swift
//  Weather
//
//  Created by Anand on 10/29/24.
//

import XCTest

@testable import Weather

class EndPointTests: XCTestCase {
    
    //MARK: - Declare variables
    var sut: EndPoint!
    
    //MARK: - Configure and initialize setup process
    override func setUp() {
        super.setUp()
        sut = EndPoint.baseURL
    }
    
    //MARK: - Execute and validate test cases
    func testSuccessfulError() {
        sut = EndPoint.baseURL
        XCTAssertNotNil(sut.rawValue, "Base URL should be there.")
        sut = EndPoint.appId
        XCTAssertNotNil(sut.rawValue, "App ID should be there.")
        sut = EndPoint.todayForecast
        XCTAssertNotNil(sut.rawValue, "Today's forecast should be there.")
        sut = EndPoint.latitude
        XCTAssertNotNil(sut.rawValue, "Latitude should be there.")
        sut = EndPoint.longitude
        XCTAssertNotNil(sut.rawValue, "Longitude should be there.")
        sut = EndPoint.query
        XCTAssertNotNil(sut.rawValue, "Query should be there.")
    }
    
    func testFailureError() {
        sut = EndPoint.baseURL
        XCTAssertNotEqual(sut.rawValue, "empty", "Base URL shouldn't be empty.")
        sut = EndPoint.appId
        XCTAssertNotEqual(sut.rawValue, "empty", "App ID shouldn't be empty.")
        sut = EndPoint.todayForecast
        XCTAssertNotEqual(sut.rawValue, "empty", "Today's forecast shouldn't be empty.")
        sut = EndPoint.latitude
        XCTAssertNotEqual(sut.rawValue, "empty", "Latitude shouldn't be empty.")
        sut = EndPoint.longitude
        XCTAssertNotEqual(sut.rawValue, "empty", "Longitude shouldn't be empty.")
        sut = EndPoint.query
        XCTAssertNotEqual(sut.rawValue, "empty", "Query shouldn't be empty.")

    }
    
    //MARK: - Teardown
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
}

