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
    var hourlyWeatherModel = [List]()
    
    private let weatherImageView: UIImageView = {
        let weatherImageView = UIImageView()
        weatherImageView.contentMode = .scaleAspectFit
        return weatherImageView
    }()
    
    private let temperatureLabel: UILabel = {
        let temperatureLabel = UILabel()
        temperatureLabel.textColor = .white
        temperatureLabel.font = .systemFont(ofSize: 80)
        return temperatureLabel
    }()
    
    private let locationLabelCity: UILabel = {
        let locationLabelCity = UILabel()
        locationLabelCity.textAlignment = .center
        locationLabelCity.textColor = UIColor(red: 225/255, green: 227/255, blue: 233/255, alpha: 1)
        locationLabelCity.font = .systemFont(ofSize: 28)
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
        weatherDescriptionLabel.font = .systemFont(ofSize: 20)
        return weatherDescriptionLabel
    }()
    
    private let inDetailCurrentWeather: UIButton = {
        let inDetailCurrentWeather = UIButton()
        inDetailCurrentWeather.setTitle("Подробнее", for: .normal)
        inDetailCurrentWeather.backgroundColor = .lightGray
        inDetailCurrentWeather.layer.cornerRadius = 12
        return inDetailCurrentWeather
    }()
    
    private let briefForecastForTheComingDay: UILabel = {
        let briefForecastForTheComingDay = UILabel()
        briefForecastForTheComingDay.text = "Краткий прогноз на предстоящие сутки"
        briefForecastForTheComingDay.textColor = .white
        briefForecastForTheComingDay.adjustsFontSizeToFitWidth = true
        return briefForecastForTheComingDay
    }()
    
//    private lazy var todayWeatherButton: UIButton = {
//        let todayWeatherButton = UIButton()
//        todayWeatherButton.setTitle("Сегодня", for: .normal)
//        todayWeatherButton.addTarget(self, action: #selector(setupTodayWeatherButton), for: .touchUpInside)
//        return todayWeatherButton
//    }()
    
//    private lazy var tomorrowWeatherButton: UIButton = {
//        let tomorrowWeatherButton = UIButton()
//        tomorrowWeatherButton.setTitle("Завтра", for: .normal)
//        tomorrowWeatherButton.addTarget(self, action: #selector(setupTomorrowWeatherButton), for: .touchUpInside)
//        tomorrowWeatherButton.setTitleColor(.gray, for: .normal)
//        return tomorrowWeatherButton
//    }()
//    
//    private lazy var sevenDaysWeatherButton: UIButton = {
//        let sevenDaysWeatherButton = UIButton()
//        sevenDaysWeatherButton.setTitle("5 дней", for: .normal)
//        sevenDaysWeatherButton.addTarget(self, action: #selector(setupSevenDaysWeatherButton), for: .touchUpInside)
//        sevenDaysWeatherButton.setTitleColor(.gray, for: .normal)
//        return sevenDaysWeatherButton
//    }()
    
//    private let todayWeatherButtonBottomView: UIView = {
//        let todayWeatherButtonBottomView = UIView()
//        todayWeatherButtonBottomView.backgroundColor = .orange
//        todayWeatherButtonBottomView.isHidden = false
//        return todayWeatherButtonBottomView
//    }()
//    
//    private let tomorrowWeatherButtonBottomView: UIView = {
//        let tomorrowWeatherButtonBottomView = UIView()
//        tomorrowWeatherButtonBottomView.backgroundColor = .orange
//        tomorrowWeatherButtonBottomView.isHidden = true
//        return tomorrowWeatherButtonBottomView
//    }()
//    
//    private let sevenDaysWeatherButtonBottomView: UIView = {
//        let sevenDaysWeatherButtonBottomView = UIView()
//        sevenDaysWeatherButtonBottomView.backgroundColor = .orange
//        sevenDaysWeatherButtonBottomView.isHidden = true
//        return sevenDaysWeatherButtonBottomView
//    }()
    
    private lazy var weatherCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize.width = UIScreen.main.bounds.width * 0.22
        layout.itemSize.height = layout.itemSize.width * 1.8
        layout.minimumLineSpacing = 20
        let weatherCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        weatherCollectionView.backgroundColor = UIColor(red: 125/255, green: 195/255, blue: 251/255, alpha: 1)
        weatherCollectionView.dataSource = self
        weatherCollectionView.delegate = self
        weatherCollectionView.showsHorizontalScrollIndicator = false
        weatherCollectionView.contentInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        weatherCollectionView.register(ShowWeatherCollectionViewCell.self, forCellWithReuseIdentifier: ShowWeatherCollectionViewCell.reuseID)
        
        return weatherCollectionView
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
    
//    @objc func setupTodayWeatherButton() {
//        todayWeatherButton.setTitleColor(.white, for: .normal)
//        tomorrowWeatherButton.setTitleColor(.gray, for: .normal)
//        sevenDaysWeatherButton.setTitleColor(.gray, for: .normal)
//        
//        todayWeatherButtonBottomView.isHidden = false
//        tomorrowWeatherButtonBottomView.isHidden = true
//        sevenDaysWeatherButtonBottomView.isHidden = true
//    }
//    
//    @objc func setupTomorrowWeatherButton() {
//        tomorrowWeatherButton.setTitleColor(.white, for: .normal)
//        todayWeatherButton.setTitleColor(.gray, for: .normal)
//        sevenDaysWeatherButton.setTitleColor(.gray, for: .normal)
//        
//        todayWeatherButtonBottomView.isHidden = true
//        tomorrowWeatherButtonBottomView.isHidden = false
//        sevenDaysWeatherButtonBottomView.isHidden = true
//    }
//    
//    @objc func setupSevenDaysWeatherButton() {
//        sevenDaysWeatherButton.setTitleColor(.white, for: .normal)
//        todayWeatherButton.setTitleColor(.gray, for: .normal)
//        tomorrowWeatherButton.setTitleColor(.gray, for: .normal)
//        
//        todayWeatherButtonBottomView.isHidden = true
//        tomorrowWeatherButtonBottomView.isHidden = true
//        sevenDaysWeatherButtonBottomView.isHidden = false
//    }

    func setupUI() {
        view.backgroundColor = UIColor(red: 125/255, green: 195/255, blue: 251/255, alpha: 1)
        
        view.addSubview(weatherImageView)
        view.addSubview(locationLabelCity)
        view.addSubview(temperatureLabel)
        view.addSubview(degreesCelsius)
        view.addSubview(weatherDescriptionLabel)
//        view.addSubview(todayWeatherButton)
//        view.addSubview(tomorrowWeatherButton)
//        view.addSubview(sevenDaysWeatherButton)
        view.addSubview(weatherCollectionView)
//        view.addSubview(todayWeatherButtonBottomView)
//        view.addSubview(tomorrowWeatherButtonBottomView)
//        view.addSubview(sevenDaysWeatherButtonBottomView)
        view.addSubview(inDetailCurrentWeather)
        view.addSubview(briefForecastForTheComingDay)
        
        weatherImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(view.frame.width / 5)
            make.height.equalTo(weatherImageView.snp.width)
            make.top.equalToSuperview().offset(130)
        }
        
        temperatureLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(weatherImageView.snp.bottom).offset(10)
        }
        
        locationLabelCity.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(temperatureLabel.snp.bottom).offset(5)
            make.width.equalTo(view.frame.width * 0.8)
            make.height.equalTo(50)
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
        
//        todayWeatherButton.snp.makeConstraints { make in
//            make.leading.equalToSuperview().offset(18)
//            make.top.equalTo(weatherDescriptionLabel.snp.bottom).offset(40)
//            make.width.equalTo(view.frame.width / 4)
//        }
//        
//        tomorrowWeatherButton.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.top.equalTo(weatherDescriptionLabel.snp.bottom).offset(40)
//            make.width.equalTo(view.frame.width / 4)
//        }
//        
//        sevenDaysWeatherButton.snp.makeConstraints { make in
//            make.trailing.equalToSuperview().offset(-18)
//            make.top.equalTo(weatherDescriptionLabel.snp.bottom).offset(40)
//            make.width.equalTo(view.frame.width / 4)
//        }

//        todayWeatherButtonBottomView.snp.makeConstraints { make in
//            make.top.equalTo(todayWeatherButton.snp.bottom).offset(20)
//            make.height.equalTo(3)
//            make.width.equalTo(view.frame.width / 15)
//            make.centerX.equalTo(todayWeatherButton.snp.centerX)
//        }
//        
//        tomorrowWeatherButtonBottomView.snp.makeConstraints { make in
//            make.top.equalTo(tomorrowWeatherButton.snp.bottom).offset(20)
//            make.height.equalTo(3)
//            make.width.equalTo(view.frame.width / 15)
//            make.centerX.equalTo(tomorrowWeatherButton.snp.centerX)
//        }
//        
//        sevenDaysWeatherButtonBottomView.snp.makeConstraints { make in
//            make.top.equalTo(sevenDaysWeatherButton.snp.bottom).offset(20)
//            make.height.equalTo(3)
//            make.width.equalTo(view.frame.width / 15)
//            make.centerX.equalTo(sevenDaysWeatherButton.snp.centerX)
//        }
        
        inDetailCurrentWeather.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(weatherDescriptionLabel.snp.bottom).offset(20)
            make.width.equalTo(view.frame.width / 3)
        }
        
        briefForecastForTheComingDay.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(weatherCollectionView.snp.top).offset(-10)
            make.width.equalTo(view.frame.width * 0.8)
        }
        
        weatherCollectionView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalToSuperview().offset(-100)
            make.height.equalTo(view.frame.height / 5)
//            make.top.equalTo(inDetailCurrentWeather.snp.bottom).offset(30)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.delegate = self
        viewModel.getCurrentWeather()
        viewModel.getHourlyWeather()
        setupNavigationItemTitleColor()
    }
}

extension ShowWeatherViewController: ShowWeatherViewModelDelegate {

    func displayCurrentWeather(model: Welcome) {
        locationLabelCity.text = model.name
        temperatureLabel.text = "\(String(format: "%.0f", model.main.temp))"
        weatherDescriptionLabel.text = model.weather.first?.description
        
        var weatherIconURL: URL {
            let baseIconURL = "https://openweathermap.org/img/wn/\(model.weather.first?.icon ?? "")@2x.png"
            return URL(string: baseIconURL)!
        }
        weatherImageView.kf.setImage(with: weatherIconURL)
    }
    
    func displayHourlytWeather(model: HourlyWeatherModel) {
        hourlyWeatherModel = model.list
        weatherCollectionView.reloadData()
    }
}

extension ShowWeatherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        hourlyWeatherModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShowWeatherCollectionViewCell.reuseID, for: indexPath) as? ShowWeatherCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(model: hourlyWeatherModel[indexPath.row])
        return cell
    }
}

extension ShowWeatherViewController: UICollectionViewDelegate {
    
}
