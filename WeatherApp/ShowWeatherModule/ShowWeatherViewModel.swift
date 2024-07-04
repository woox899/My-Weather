//
//  ShowWeatherViewModel.swift
//  WeatherApp
//
//  Created by Андрей Бабкин on 17.06.2024.
//

import Foundation

protocol ShowWeatherViewModelProtocol: AnyObject {
    func getCurrentWeather()
    func getHourlyWeather()
    var delegate: ShowWeatherViewModelDelegate? { get set }
}

protocol ShowWeatherViewModelDelegate: AnyObject {
    func displayCurrentWeather(model: Welcome)
    func displayHourlytWeather(model: HourlyWeatherModel)
}

class ShowWeatherViewModel: ShowWeatherViewModelProtocol {
    var query: String
    weak var delegate: ShowWeatherViewModelDelegate?
    let networkManger = NetworkManager()
    func getCurrentWeather() {
        networkManger.getWeather(searchWeather: query) { [weak self] weather in
            switch weather {
            case .success(let model):
                self?.delegate?.displayCurrentWeather(model: model)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getHourlyWeather() {
        networkManger.getHourlyWeather(searchWeather: query) { [weak self] hourlyWeather in
            switch hourlyWeather {
            case .success(let model):
                self?.delegate?.displayHourlytWeather(model: model)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    init(query: String) {
        self.query = query
    }
}
