//
//  WeatherInfoViewController.swift
//  Weather
//
//  Created by Uma on 29/08/24..
//

import UIKit
import SwiftUI
import CoreLocation

class WeatherInfoViewController: UIViewController,Storyboarded {

    @IBOutlet weak private var inputTextField: UITextField!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var tempLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!
    @IBOutlet weak private var humiditylabel: UILabel!
    @IBOutlet weak private var windLabel: UILabel!
    @IBOutlet weak private var weatherDescIcon: UIImageView!
    @IBOutlet weak private var pressureLabel: UILabel!

    @IBOutlet weak var weatherInfoView: UIView!
    
    // MARK: - Properties
    weak var coordinator: MainCoordinator?
    var viewModel : WeatherInfoViewModel!
    let locationManager = CLLocationManager()
    var isCurrentLocationWeather: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.weatherInfoView.isHidden = true
        self.title = AppStrings.WEATHER_SCREEN_TITLE
        self.checkLocationPermissionStatusAndNotifyUser()
        self.configureErrorHandler()
        self.initiateDataModelUpdate()
        self.listenForCurrentLocationStatus()
        self.viewModel.checkForPreviousSearchResult()
    }


    func listenForCurrentLocationStatus() {
        self.viewModel.updateCurrentLocation = { status in
            self.isCurrentLocationWeather = status
            if status == true {
                self.requestLocationServices()
            }
        }
    }
    
    //Bind ResponseModeldata to UI
    func initiateDataModelUpdate() {
        self.viewModel.updateWeatherModelToView = { [weak self] model in
            guard let dataModel = model else {
                return
            }
            DispatchQueue.main.async {
                self?.loadWeatherData(model: dataModel)
            }
        }
    }
    
    //set error handler
    private func configureErrorHandler(){
        viewModel.errorHandler = {[weak self] error in
            self?.presentSimpleAlert(title:AppStrings.Error, message: error)
        }
    }
    
    //check Location permission status
    private func checkLocationPermissionStatusAndNotifyUser(){
        if self.isCurrentLocationWeather{
            let authorizationStatus = locationManager.authorizationStatus
                switch authorizationStatus{
                case .denied, .restricted:
                    
                    self.presentSimpleAlert(title: AppStrings.WEATHER_SCREEN_TITLE, message: AppStrings.LOCATION_SERVICES_DIABLED_ALERT_MSG)
                default:
                    break
            }
        }
       
    }
    
    //Request location authentication
    private func requestLocationServices() {
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    private func loadWeatherData(model: WeatherDataModel) {
        self.weatherInfoView.isHidden = false
        if self.isCurrentLocationWeather {
            self.titleLabel.text = "\(AppStrings.TITLE_WEATHER_IFO) \(model.city)(\(AppStrings.USER_LOCATION))"
        } else {
            self.titleLabel.text = "\(AppStrings.TITLE_WEATHER_IFO) \(model.city)"
        }
        self.tempLabel.text = "\(AppStrings.TITLE_TEMPERATURE) \(model.temparature) \(AppStrings.UNIT_K)"
        self.descriptionLabel.text = "\(AppStrings.TITLE_DESCIPTION) \(model.description)"
        self.humiditylabel.text = "\(AppStrings.TITLE_HUMIDITY) \(model.humidity)"
        self.pressureLabel.text = "\(AppStrings.TITLE_PRESSURE) \(model.pressure)"
        self.windLabel.text = "\(AppStrings.TITLE_WINDSPEED) \(model.windSpeed)"
        ImageDownloader().downloadImage(model.imageURL) {
            image in
            if let imageObject = image {
                // performing UI operation on main thread
                DispatchQueue.main.async {
                    self.weatherDescIcon.image = imageObject
                }
            }
        }
    }

    //MARK: - API
    private func fetchWeather(cityName: String) {
        viewModel.fetchWeather(cityName: cityName) { status in
            if status {
                self.showActivity()
            } else {
                self.hideActivity()
            }
        }
    }
}


//MARK: - Spinner
extension WeatherInfoViewController: ActivityPresentable {}

//MARK: - CLLocationManagerDelegate
extension WeatherInfoViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .denied, .restricted, .notDetermined:
            self.presentSimpleAlert(title: AppStrings.WEATHER_SCREEN_TITLE, message: AppStrings.LOCATION_SERVICES_DIABLED_ALERT_MSG)
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            viewModel.updateUserLocation(location)
            locationManager.stopUpdatingLocation()
        }
    }
}
extension WeatherInfoViewController: UITextFieldDelegate {
   
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        self.loadSerachCityViewController()
        textField.resignFirstResponder()
    }
}
extension WeatherInfoViewController {
    func loadSerachCityViewController() {
        self.coordinator?.loadCitySearchVC(completion: { [weak self] city in
            self?.isCurrentLocationWeather = false
            guard !city.isEmpty else {
                return
            }
            self?.fetchWeather(cityName: city)
        }, errorHandler: { error in
            print("Error occured while searching a city")
        })        
    }
    
}

