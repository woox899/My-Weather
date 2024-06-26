//
//  ShowWeatherViewController.swift
//  WeatherApp
//
//  Created by Андрей Бабкин on 17.06.2024.
//

import UIKit
import SnapKit

class ShowWeatherViewController: UIViewController, UITextFieldDelegate {
    
    var viewModel: ShowWeatherViewModelProtocol
    
    var location: String
    
    var model: Welcome?
    
    private let locationLabel: UILabel = {
        let locationLabel = UILabel()
        locationLabel.textAlignment = .center
        return locationLabel
    }()
    
    private let coutryLabel: UILabel = {
        let coutryLabel = UILabel()
        return coutryLabel
    }()
    
    private let weatherDescriptionLabel: UILabel = {
        let weatherDescriptionLabel = UILabel()
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
    
    func setupUI() {
        view.backgroundColor = .systemGray
        
        view.addSubview(locationLabel)
        view.addSubview(coutryLabel)
        view.addSubview(weatherDescriptionLabel)
        
        locationLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.top).offset(120)
            make.width.equalTo(view.frame.width / 3)
            make.height.equalTo(30)
        }
        
        coutryLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(locationLabel.snp.bottom).offset(15)
        }
        
        weatherDescriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(coutryLabel.snp.bottom).offset(15)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.delegate = self
        viewModel.getLocation()
    }
}

extension ShowWeatherViewController: ShowWeatherViewModelDelegate {
    func displayWeather(model: Welcome) {
        self.model = model
        self.locationLabel.text = model.location?.name
        self.coutryLabel.text = model.location?.country
        self.weatherDescriptionLabel.text = model.current?.condition?.text
    }
}
