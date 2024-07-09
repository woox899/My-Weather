//
//  ShowWeatherCollectionViewCell.swift
//  WeatherApp
//
//  Created by Андрей Бабкин on 27.06.2024.
//

import UIKit
import SnapKit

class ShowWeatherCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "ShowWeatherCollectionViewCell"
    
    var model: List?
    
    private let weatherView: UIView = {
        let weatherView = UIView()
        weatherView.backgroundColor = .clear
        weatherView.layer.cornerRadius = 45
        return weatherView
    }()
    
    private let timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.textColor = .white
        return timeLabel
    }()
    
    private let weatherImageView: UIImageView = {
        let weatherImageView = UIImageView()
        return weatherImageView
    }()
    
    private let degreeseWeatherLabel: UILabel = {
        let degreeseWeatherLabel = UILabel()
        degreeseWeatherLabel.textColor = .white
        return degreeseWeatherLabel
    }()
    
    func configure(model: List) {
        self.model = model
        degreeseWeatherLabel.text = "\(String(format: "%.0f", model.main.temp))" + "°C"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let monthString = dateFormatter.string(from: model.dt)

        timeLabel.text = "\(monthString)"

        var weatherIconURL: URL {
            let baseIconURL = "https://openweathermap.org/img/wn/\(String(describing: model.weather[0].icon))@2x.png"
            return URL(string: baseIconURL)!
        }
        weatherImageView.kf.setImage(with: weatherIconURL)
    }
    
    func setupUI() {
        contentView.addSubview(weatherView)
        weatherView.addSubview(timeLabel)
        weatherView.addSubview(weatherImageView)
        weatherView.addSubview(degreeseWeatherLabel)
        
        weatherView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        timeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
        }
        
        weatherImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(timeLabel.snp.bottom).offset(5)
            make.width.equalTo(70)
            make.height.equalTo(70)
        }
        
        degreeseWeatherLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(weatherImageView.snp.bottom).offset(5)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
