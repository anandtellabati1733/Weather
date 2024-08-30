//
//  AppConstants.swift
//  Weather
//
//  Created by Uma on 29/08/24..
//

import Foundation

struct AppConstants {
    // Need to store such keys in a sceured way (ex using keychain). Having limited time keeping it here.
    static let OWM_API_KEY = "2f591120f288ed9c4e318d6ec52ca873"
}

struct AppStrings {
    static let COUNTRY_NAME_US = "united states"
    static let WEATHER_SCREEN_TITLE = "Weather Info"
    
    //WeatherInfoViewController strings
    static let TITLE_WEATHER_IFO = "Weather Info:"
    static let TITLE_TEMPERATURE = "Temparature:"
    static let TITLE_DESCIPTION = "Description:"
    static let TITLE_HUMIDITY = "Humidity:"
    static let TITLE_PRESSURE = "Pressure:"
    static let TITLE_WINDSPEED = "WindSpeed:"
    static let USER_LOCATION = "User Location"
    static let UNIT_K = "k"
    
    //WeatherInfoViewModel strings
    static let KEY_WEATHER_DATA = "weatherData"
    
    //Error Messages
    static let LOCATION_SERVICES_DIABLED_ALERT_MSG = "Location services are disabled. Please go to Settings to enable the same. You can still search for a city to get it's weather information."
    static let NO_DATA_FOUND_FOR_CITY = "Sorry. Weather data is not available for the selected city."
    static let NO_INFO_FOR_CITY_MESSAGE = "city not found"
    
    //Common Strings
    static let OK = "Ok"
    static let Error = "Error"

}
