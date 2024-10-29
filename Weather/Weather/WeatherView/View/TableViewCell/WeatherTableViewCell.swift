//
//  WeatherTableViewCell.swift
//  Weather
//
//  Created by Anand on 10/29/24.
//
import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    let descriptionLabel = UILabel()
    let humidityLabel = UILabel()
    let pressureLabel = UILabel()
    let temperatureLabel = UILabel()
    let windSpeedLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        let labels = [descriptionLabel, humidityLabel, pressureLabel, temperatureLabel, windSpeedLabel]
        
        for label in labels {
            label.textAlignment = .left
            label.font = UIFont.preferredFont(forTextStyle: .body)
            label.adjustsFontForContentSizeCategory = true
            contentView.addSubview(label)
        }

        for label in labels {
            label.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),

            humidityLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5),
            humidityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            humidityLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),

            pressureLabel.topAnchor.constraint(equalTo: humidityLabel.bottomAnchor, constant: 5),
            pressureLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            pressureLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),

            temperatureLabel.topAnchor.constraint(equalTo: pressureLabel.bottomAnchor, constant: 5),
            temperatureLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            temperatureLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),

            windSpeedLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 5),
            windSpeedLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            windSpeedLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            windSpeedLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
        
        // Visual enhancements
        contentView.backgroundColor = UIColor(white: 1.0, alpha: 0.9) // Light background color for the cell
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowOffset = CGSize(width: 0, height: 1)
        contentView.layer.shadowRadius = 2
        contentView.clipsToBounds = true // Ensure the corner radius is applied
    }

    func configure(with viewModel: WeatherViewModel) {
        descriptionLabel.text = "Description: \(viewModel.weatherDataModel?.description.capitalized ?? "N/A")"
        humidityLabel.text = "Humidity: \(viewModel.weatherDataModel?.humidity ?? "N/A")"
        pressureLabel.text = "Pressure: \(viewModel.weatherDataModel?.pressure ?? "N/A")"
        temperatureLabel.text = "Temperature: \(viewModel.weatherDataModel?.temparature ?? "N/A") \(AppStrings.UNIT_K)"
        windSpeedLabel.text = "Wind Speed: \(viewModel.weatherDataModel?.windSpeed ?? "N/A")"
    }
}

