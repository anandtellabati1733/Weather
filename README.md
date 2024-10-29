Weather App
Overview
This Weather App is a simple, user-friendly application that allows users to search for weather information by entering a US city. The app leverages the OpenWeatherMap API to fetch and display weather data, including temperature, humidity, wind speed, and weather icons. The app is designed to be intuitive, with a focus on proper function, well-constructed code, and defensive programming.

Features
Search Screen: Users can enter a US city to retrieve weather information.

API Integration: Utilizes the OpenWeatherMap API to fetch weather data.

Weather Icons: Downloads and displays weather icons based on the current weather conditions.

Image Cache: Implements image caching to optimize performance.

Auto-load Last City: Automatically loads the last searched city upon app launch.

Location Access: Requests user permission to access location and retrieves weather data based on the user's current location.

Error Handling: Gracefully handles unexpected edge cases with user-friendly error messages.

Requirements
iOS
Architecture: MVVM-C (Model-View-ViewModel-Coordinator)

UI Frameworks: UIKit and SwiftUI (no storyboards)

Dependency Injection: Implemented for managing dependencies

Orientation and Size Classes: Supports both landscape and portrait orientations; adapts UI for different size classes

Third-Party Libraries: No third-party libraries; relies solely on native Swift and Apple frameworks

Testing: Unit tests for ViewModel and Model layers

Error Handling: Robust error handling with user-friendly messages

Getting Started
Prerequisites
Xcode 15.0 or later

Swift 5.0 or later

An API key from OpenWeatherMap

Installation
Clone the repository:

bash
Copy
git clone https://github.com/anandtellabati1733/weather.git
Open the project in Xcode:

bash
Copy
cd weather
open Weather.xcodeproj
Replace YOUR_API_KEY in the APIConstants.swift file with your OpenWeatherMap API key.

Build and run the project on the simulator or a physical device.

Usage
Search Screen: Enter a US city in the search bar and tap "Search" to retrieve weather information.

Auto-load Last City: The app will automatically load the weather for the last searched city upon launch.

Location Access: If the user grants location access, the app will retrieve weather data based on the user's current location.

Testing
The project includes unit tests for the ViewModel and Model layers. To run the tests, navigate to the WeatherAppTests directory and execute the tests using Xcode's testing tools.

Error Handling
The app includes robust error handling to manage unexpected scenarios, such as network failures or invalid user input. Error messages are displayed in a user-friendly manner to guide the user.

Contributing
Contributions are welcome! Please feel free to submit a pull request or open an issue for any bugs or feature requests.
