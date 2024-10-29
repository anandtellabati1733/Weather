//
//  AppConstants.swift
//  Weather
//
//  Created by Anand on 10/29/24.
//

import Foundation
struct AppConstants {
    // better option to keep such keys in  keychain
    static let Weather_API_KEY = "2db00a6ab478969db2453b95f26b9f6a"
}

struct AppStrings {
    static let COUNTRY_NAME_US = "united states"
    static let WEATHER_SCREEN_TITLE = "Weather Forecast"
    
    //WeatherInfoViewController strings
    static let TITLE_WEATHER_IFO = "City: "
    static let CURRENT_LOCATION = "My Location"
    static let UNIT_K = "k"
    
    //WeatherInfoViewModel strings
    static let KEY_WEATHER_DATA = "weatherData"
    
    //Error Messages
    static let LOCATION_SERVICES_DIABLED_ALERT_MSG = "Location services are disabled. Please enable them in Settings. You can still search for a city to get weather information."
    static let NO_DATA_FOUND_FOR_CITY = "Apologies, weather data is unavailable for the selected city."
    static let NO_INFO_FOR_CITY_MESSAGE = "city not found"
    
    //Common Strings
    static let OK = "Ok"
    static let Error = "Error"
    static let TITLE_SearchForCity = "Search for City"
    static let TITLE_CloseButton = "Close"


}
