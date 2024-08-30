//
//  WeatherInfoViewModel.swift
//  Weather
//
//  Created by Uma on 29/08/24..
//

import Foundation
import CoreLocation
import UIKit
class WeatherInfoViewModel {
    private var apiManager: APIService!
    var userLocation: CLLocation?
    
    private(set) var weatherDataModel : WeatherDataModel? {
        didSet {
            self.updateWeatherModelToView?(self.weatherDataModel)
        }
    }
    var updateWeatherModelToView: ((WeatherDataModel?)-> Void)?
    var errorHandler : ((String) -> ()) = {error in }
    init(apiManager: APIService) {
        self.apiManager = apiManager
    }
    
    func updateUserLocation(_ location: CLLocation) {
        self.userLocation = location
        self.fetchCurrentLocationWeather()
    }
    
    var updateCurrentLocation:((Bool) -> Void)?
}

//MARK: - Networking
extension WeatherInfoViewModel {
    func fetchWeather(cityName: String,
                      completion:@escaping (Bool) -> Void) {
        var request = WeatherRequest()
        request.parameters = [.query: cityName]
        apiManager.fetchData(with: request) {[weak self] (weather: WeatherResponseModel?, error: NetworkError?) in
            if let weather = weather {
                //check if the weather model contains any nessage
                if weather.message == AppStrings.NO_INFO_FOR_CITY_MESSAGE{
                    completion(false)
                    self?.errorHandler(AppStrings.NO_DATA_FOUND_FOR_CITY)
                }else{
                    self?.weatherDataModel = WeatherDataModel().createWeatherDataModel(model: weather)
                    self?.saveWeatherData()
                }
                
            } else if let error = error {
                print("Error occured on fetch data\(error.localizedDescription )")
                self?.errorHandler(error.description)
            }
            completion(false)
        }
        completion(true)
    }
    
    func saveWeatherData() {
        let defaults = UserDefaults.standard
        if let quotes = self.weatherDataModel {
            defaults.set(codable: quotes, forKey: AppStrings.KEY_WEATHER_DATA)
        }
    }

    func fetchCurrentLocationWeather() {
        var request = WeatherRequest()
        request.parameters = [
            .latitude: "\(userLocation?.coordinate.latitude ?? 0)",
            .longitude: "\(userLocation?.coordinate.longitude ?? 0)"
        ]
        apiManager.fetchData(with: request) {[weak self] (weather: WeatherResponseModel?, error: NetworkError?) in
            if let weather = weather {
                self?.weatherDataModel = WeatherDataModel().createWeatherDataModel(model: weather)
            } else if let error = error {
                print("Error occured on fetch data\(error)")
                //pass this error to ErrorHandler
                self?.errorHandler(error.description)
                
            }
        }
    }
    
    func loadExistingWeatherData(model: WeatherDataModel) {
        self.weatherDataModel = model
    }
    
    func checkForPreviousSearchResult() {
        if let existingModel = UserDefaults.standard.codable(WeatherDataModel.self, forKey: AppStrings.KEY_WEATHER_DATA)  {
            self.updateCurrentLocation?(false)
            self.updateWeatherModelToView?(existingModel)
        } else {
            self.updateCurrentLocation?(true)
        }
    }
}
