//
//  ShowWeatherViewController.swift
//  WeatherApp
//
//  Created by Андрей Бабкин on 17.06.2024.
//

import UIKit
import SnapKit
import Kingfisher

class ShowWeatherViewController: UIViewController, UITextFieldDelegate {
    
    var viewModel: ShowWeatherViewModelProtocol
    
    var location: String
    
    var model: Welcome?

    private let temperatureLabel: UILabel = {
        let temperatureLabel = UILabel()
        temperatureLabel.textColor = .white
        temperatureLabel.font = .systemFont(ofSize: 120)
        return temperatureLabel
    }()

    private let locationLabelCity: UILabel = {
        let locationLabelCity = UILabel()
        locationLabelCity.textAlignment = .center
        locationLabelCity.textColor = .white
        return locationLabelCity
    }()

    private let degreesCelsius: UILabel = {
        let degreesCelsius = UILabel()
        degreesCelsius.textColor = .white
        degreesCelsius.text = "°C"
        return degreesCelsius
    }()
    
    private let weatherDescriptionLabel: UILabel = {
        let weatherDescriptionLabel = UILabel()
        weatherDescriptionLabel.textColor = .white
        weatherDescriptionLabel.numberOfLines = 0
        weatherDescriptionLabel.textAlignment = .center
        return weatherDescriptionLabel
    }()

    init(viewModel: ShowWeatherViewModelProtocol, location: String) {
        self.viewModel = viewModel
        self.location = location
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupNavigationItemTitleColor() {
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        navigationItem.title = "Weather App"
    }

    func setupUI() {
        view.backgroundColor = UIColor(red: 39/255, green: 41/255, blue: 48/255, alpha: 1)

        view.addSubview(locationLabelCity)
        view.addSubview(temperatureLabel)
        view.addSubview(degreesCelsius)
        view.addSubview(weatherDescriptionLabel)

        temperatureLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.top).offset(150)
        }
        
        locationLabelCity.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(temperatureLabel.snp.bottom).offset(30)
            make.width.equalTo(view.frame.width * 0.8)
            make.height.equalTo(30)
        }

        degreesCelsius.snp.makeConstraints { make in
            make.leading.equalTo(temperatureLabel.snp.trailing).offset(2)
            make.top.equalTo(temperatureLabel.snp.top).offset(15)
        }
        
        weatherDescriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(locationLabelCity.snp.bottom).offset(15)
            make.width.equalTo(view.frame.width * 0.8)
            make.height.equalTo(50)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.delegate = self
        viewModel.getLocation()
        setupNavigationItemTitleColor()
    }
}

extension ShowWeatherViewController: ShowWeatherViewModelDelegate {
    
    func displayWeather(model: Welcome) {
        locationLabelCity.text = model.location.name
        temperatureLabel.text = "\(String(format: "%.0f" ,model.current.tempC))"
        weatherDescriptionLabel.text = model.current.condition?.text
    }
}
