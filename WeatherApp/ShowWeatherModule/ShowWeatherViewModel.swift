//
//  ShowWeatherViewModel.swift
//  WeatherApp
//
//  Created by Андрей Бабкин on 17.06.2024.
//

import Foundation

protocol ShowWeatherViewModelProtocol: AnyObject {
    func getLocation()
    var delegate: ShowWeatherViewModelDelegate? { get set }
}

protocol ShowWeatherViewModelDelegate: AnyObject {
    func displayWeather(model: Welcome)
}

class ShowWeatherViewModel: ShowWeatherViewModelProtocol {
    var query: String
    weak var delegate: ShowWeatherViewModelDelegate?
    let networkManger = NetworkManager()
    func getLocation() {
        networkManger.getWeather(searchWeather: query) { [weak self] weather in
            switch weather {
            case .success(let model):
                self?.delegate?.displayWeather(model: model)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    init(query: String) {
        self.query = query
    }
}
