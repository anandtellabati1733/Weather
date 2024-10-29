//
//  WeatherViewController.swift
//  Weather
//
//  Created by Anand on 10/29/24.
//

import UIKit

/// The main Weather ViewController for displaying weather information.
class WeatherViewController: UIViewController {

    let weatherImageView = UIImageView()
    let cityLabel = UILabel()
    let tableView = UITableView()
    let searchButton = UIButton()
    
    var viewModel: WeatherViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        viewModel.delegate = self
        
        setupUI()           // Set up the user interface components
        setupTableView()    // Configure the table view
        setupConstraints()  // Set up layout constraints
    }

    /// Configures the user interface components.
    private func setupUI() {
        // Configure Weather Image View
        weatherImageView.contentMode = .scaleAspectFit
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        weatherImageView.layer.cornerRadius = 10
        weatherImageView.layer.shadowColor = UIColor.black.cgColor
        weatherImageView.layer.shadowOpacity = 0.2
        weatherImageView.layer.shadowOffset = CGSize(width: 0, height: 2)
        weatherImageView.layer.shadowRadius = 4
        weatherImageView.clipsToBounds = true

        // Configure City Label with Dynamic Typing
        cityLabel.text = "City: "
        cityLabel.textColor = .white // Change text color for better contrast
        cityLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        cityLabel.adjustsFontForContentSizeCategory = true
        cityLabel.backgroundColor = UIColor(white: 0, alpha: 0.5) // Semi-transparent background
        cityLabel.layer.cornerRadius = 8
        cityLabel.clipsToBounds = true
        cityLabel.textAlignment = .center

        // Configure Search Button
        searchButton.setTitle("Search for City", for: .normal)
        searchButton.backgroundColor = .systemBlue
        searchButton.layer.cornerRadius = 8
        searchButton.addTarget(self, action: #selector(clickSearch), for: .touchUpInside)
        searchButton.layer.shadowColor = UIColor.black.cgColor
        searchButton.layer.shadowOpacity = 0.2
        searchButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        searchButton.layer.shadowRadius = 4
        searchButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)

        // Add components to the view
        view.addSubview(weatherImageView)
        view.addSubview(cityLabel)
        view.addSubview(tableView)
        view.addSubview(searchButton)
    }

    /// Configures the table view.
    private func setupTableView() {
        tableView.register(WeatherTableViewCell.self, forCellReuseIdentifier: "WeatherCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.cornerRadius = 10
        tableView.layer.shadowColor = UIColor.black.cgColor
        tableView.layer.shadowOpacity = 0.1
        tableView.layer.shadowOffset = CGSize(width: 0, height: 1)
        tableView.layer.shadowRadius = 2
        tableView.clipsToBounds = false
    }

    /// Sets up the layout constraints for the user interface components.
    private func setupConstraints() {
        // Disable autoresizing mask translation
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        searchButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            weatherImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            weatherImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25),
            weatherImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            
            cityLabel.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor, constant: 10),
            cityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cityLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8), // Ensure the label width is appropriate

            tableView.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: searchButton.topAnchor, constant: -10),
            
            searchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            searchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchButton.widthAnchor.constraint(equalToConstant: 200),
            searchButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    /// Applies a gradient background to the view.
    private func applyGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.systemBlue.cgColor, UIColor.systemPurple.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    /// Action method for the search button.
    @objc func clickSearch() {
        viewModel.loadSerachCityViewController()
    }
}

extension WeatherViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 // Assume this is an array of weather data models
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as? WeatherTableViewCell else {
            return UITableViewCell()
        }
        
        guard let weatherDataModel = viewModel else { return UITableViewCell() }
        cell.configure(with: weatherDataModel) // Assuming your viewModel has a method to get weather model
        return cell
    }
}

extension WeatherViewController: ActivityView {
    
    func showHideActivityView(status: Bool) {
        if status {
            showActivityInidcator() // Show your custom activity indicator
        } else {
            hideActivityInidicator() // Hide your custom activity indicator
        }
    }
    
}
extension WeatherViewController: WeatherViewModelDelegate {
    func showAlertWithMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    func updateWeatherIcon(iconImage: UIImage) {
        DispatchQueue.main.async {
            self.weatherImageView.image = iconImage
        }
    }

    func onReceivingWeatherInfoSuccess(city: String) {
        DispatchQueue.main.async {
            self.cityLabel.text = "City: \(city)" // Update city label with the current city
            self.tableView.reloadData() // Reload table
        }
    }
}
