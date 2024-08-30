//
//  WeatherTests.swift
//  WeatherTests
//
//  Created by Uma on 29/08/24..
//

import XCTest

class WeatherTests: XCTestCase {
    
    //MARK: - Variables
    var weather: WeatherResponseModel!
    
    //MARK: - Setup
    override func setUp() {
        super.setUp()
    }

    //MARK: - Tests
    func testWeatherModel() {
        let weather: WeatherResponseModel = MockFileLoader.readDataFromFile(at: "weather_mock_data")
        XCTAssertNotNil(weather, "Weather should not be nil.")
        XCTAssertEqual(weather.weather?[0].id, 801, "Weather ids should be equal.")
        XCTAssertEqual(weather.wind?.deg, 90, "Weather wind degrees should be equal.")
        XCTAssertEqual(weather.main?.temparature, 12.32, "Weather temp.s should be equal.")
    }

    //MARK: - Tear down
    override func tearDown() {
        super.tearDown()
    }
}
