//
//  WeatherViewModelTests.swift
//  WeatherTests
//
//  Created by Uma on 29/08/24..
//

import XCTest

class WeatherViewModelTests: XCTestCase {
    
    //MARK: - Variables
    var sut: WeatherInfoViewModel!
    var apiManager: MockDataManager<WeatherResponseModel>!
    
    //MARK: - Setup
    override func setUp() {
        super.setUp()
        apiManager = MockDataManager()
        sut = WeatherInfoViewModel(apiManager: apiManager)
    }
    
    //MARK: - Tests
    func testFetchWeather() {
        
        let expectation = XCTestExpectation(description: "Fetch Weather Data ")
        let emptyModel = WeatherResponseModel(
            weather: nil, base: nil, main: nil, visibility: nil,
            wind: nil, date: nil, id: nil, name: nil, message: nil
        )
        apiManager.model = emptyModel
        sut.fetchWeather(cityName: "New York") { result in
            if result != false {expectation.fulfill()}
        }
        XCTAssertTrue(apiManager.isDataFetched, "Data should be fetched")
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchWeatherFail() {
        
        XCTAssertEqual(sut.weatherDataModel == nil, true)
    }
    
    
    func testSuccessfulFetchWeather() {
        let weather: WeatherResponseModel = MockFileLoader.readDataFromFile(at: "weather_mock_data")
        apiManager.model = weather
        let expectation = XCTestExpectation(description: "Reload tableView triggered")
        sut.fetchWeather(cityName: "New York") { status in
            if status == false { expectation.fulfill() }
        }
        apiManager.fetchWithSuccess()
        let temparature = "\(Int(weather.main?.temparature ?? 0.0)) º"
        if  let model = sut.weatherDataModel?.createWeatherDataModel(model: weather) {
            XCTAssertEqual(model.temparature, temparature)
        }
        wait(for: [expectation], timeout: 1.0)
    }
        
    func testWeatherDataModel() {
        let weather: WeatherResponseModel = MockFileLoader.readDataFromFile(at: "weather_mock_data")
        let weatherFormatted = WeatherDataModel().createWeatherDataModel(model: weather)
        let temparature = "\(Int(weather.main?.temparature ?? 0.0)) º"
        XCTAssertEqual(weatherFormatted.temparature, temparature, "Both temp.s should be equal.")
    }
    
    //MARK: - Tear down
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
}

