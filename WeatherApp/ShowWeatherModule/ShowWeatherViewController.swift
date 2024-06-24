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
    
    lazy var locationLabel: UILabel = {
        let locationLabel = UILabel()
        locationLabel.textAlignment = .center
        return locationLabel
    }()

    func textTransmission() {
        locationLabel.text = self.location
    }
    
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
        
        locationLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.top).offset(120)
            make.width.equalTo(view.frame.width / 3)
            make.height.equalTo(30)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        textTransmission()
    }
}
