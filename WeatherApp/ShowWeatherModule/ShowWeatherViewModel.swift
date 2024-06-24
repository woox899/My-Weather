//
//  ShowWeatherViewModel.swift
//  WeatherApp
//
//  Created by Андрей Бабкин on 17.06.2024.
//

import Foundation

protocol ShowWeatherViewModelProtocol: AnyObject {
    func enterText(text: String)
}

class ShowWeatherViewModel: ShowWeatherViewModelProtocol {
    func enterText(text: String) {
        enterLocation = text
    }
    
    let networkManger = NetworkManager()
    var enterLocation: String = String()
    func getLocation() {
        networkManger.getWeather(query: enterLocation) { locaton in
//            switch locaton {
//            case .success(let success):
//                <#code#>
//            case .failure(let failure):
//                <#code#>
//            }
        }
    }
}
