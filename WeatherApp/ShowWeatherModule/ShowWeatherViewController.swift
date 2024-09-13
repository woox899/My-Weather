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
        weatherImageView.backgroundColor = .red
        return weatherImageView
    }()
    
    private let temperatureLabel: UILabel = {
        let temperatureLabel = UILabel()
        temperatureLabel.textColor = .white
        temperatureLabel.font = .systemFont(ofSize: 80)
        temperatureLabel.backgroundColor = .red
        temperatureLabel.adjustsFontSizeToFitWidth = true
        return temperatureLabel
    }()
    
    private let locationLabelCity: UILabel = {
        let locationLabelCity = UILabel()
        locationLabelCity.textAlignment = .center
        locationLabelCity.textColor = UIColor(red: 225/255, green: 227/255, blue: 233/255, alpha: 1)
        locationLabelCity.font = .systemFont(ofSize: 28)
        locationLabelCity.backgroundColor = .red
        return locationLabelCity
    }()
    
    private let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.textAlignment = .center
        dateLabel.textColor = .white
        dateLabel.font = .systemFont(ofSize: 16)
        return dateLabel
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
        weatherDescriptionLabel.backgroundColor = .red
        return weatherDescriptionLabel
    }()
    
   private lazy var inDetailCurrentWeather: UIButton = {
        let inDetailCurrentWeather = UIButton()
        inDetailCurrentWeather.setTitle("Подробнее", for: .normal)
        inDetailCurrentWeather.backgroundColor = .lightGray
        inDetailCurrentWeather.layer.cornerRadius = 12
       inDetailCurrentWeather.addTarget(self, action: #selector(goToWeatherDetaulsViewController), for: .touchUpInside)
        return inDetailCurrentWeather
    }()
    
    private let briefForecastForTheComingDay: UILabel = {
        let briefForecastForTheComingDay = UILabel()
        briefForecastForTheComingDay.text = "Краткий прогноз на предстоящие сутки"
        briefForecastForTheComingDay.textColor = .white
        briefForecastForTheComingDay.adjustsFontSizeToFitWidth = true
        return briefForecastForTheComingDay
    }()

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
    
    @objc func goToWeatherDetaulsViewController() {
        let viewModel: WeatherDetailsViewModelProtocol = WeatherDetailsViewModel()
        let weatherDetailViewController = WeatherDetailsViewController(viewModel: viewModel, model: model)
        present(weatherDetailViewController, animated: true)
    }

    func setupNavigationItemTitleColor() {
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        navigationItem.title = "Weather App"
    }

    func setupUI() {
        view.backgroundColor = UIColor(red: 125/255, green: 195/255, blue: 251/255, alpha: 1)
        
        view.addSubview(weatherImageView)
        view.addSubview(locationLabelCity)
        view.addSubview(dateLabel)
        view.addSubview(temperatureLabel)
        view.addSubview(degreesCelsius)
        view.addSubview(weatherDescriptionLabel)
        view.addSubview(weatherCollectionView)
        view.addSubview(inDetailCurrentWeather)
        view.addSubview(briefForecastForTheComingDay)
        
        weatherImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(view.frame.width * 0.2)
            make.height.equalTo(weatherImageView.snp.width)
            make.top.equalToSuperview().offset(60)
        }
        
        temperatureLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(weatherImageView.snp.bottom).offset(10)
            make.width.equalTo(view.frame.width * 0.2)
            make.height.equalTo(temperatureLabel.snp.width)
        }
        
        degreesCelsius.snp.makeConstraints { make in
            make.leading.equalTo(temperatureLabel.snp.trailing).offset(2)
            make.top.equalTo(temperatureLabel.snp.top).offset(15)
        }
        
        locationLabelCity.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(temperatureLabel.snp.bottom).offset(5)
            make.width.equalTo(view.frame.width * 0.8)
            make.height.equalTo(50)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(locationLabelCity.snp.bottom).offset(3)
            make.width.equalTo(view.frame.width * 0.8)
        }

        weatherDescriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
            make.width.equalTo(view.frame.width * 0.8)
            make.height.equalTo(50)
        }

        inDetailCurrentWeather.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(weatherDescriptionLabel.snp.bottom).offset(10)
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
        self.model = model
        locationLabelCity.text = model.name
        temperatureLabel.text = "\(String(format: "%.0f", model.main.temp))"

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        let monthString = dateFormatter.string(from: model.dt)
       
        dateLabel.text = "\(monthString)"
        
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
