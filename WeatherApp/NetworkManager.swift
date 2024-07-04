//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Андрей Бабкин on 17.06.2024.
//

import Foundation
import Alamofire
import CoreLocation

class NetworkManager {
    func getWeather(searchWeather: String, complition: @escaping(Result<Welcome, Error>) -> Void) -> Void {
        CLGeocoder().geocodeAddressString("\(searchWeather)") { (placemarks, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            if let lat = placemarks?.first?.location?.coordinate.latitude,
               let lon = placemarks?.first?.location?.coordinate.longitude {
                
                guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather") else { return }
                let params = [
                    "appid" : "e44149cc5411443818aaf08afc6afc83",
                    "lat" : "\(lat)",
                    "lon" : "\(lon)",
                    "units" : "metric",
                    "lang" : "ru"
                ]
                
                AF.request(url, method: .get, parameters: params).response { response in
                    if let error = response.error {
                        complition(.failure(error))
                    } else {
                        if let data = response.data {
                            guard let responseData = try? JSONDecoder().decode(Welcome.self, from: data) else { return }
                            complition(.success(responseData))
                        }
                    }
                }
            }
        }
    }
    
    func getHourlyWeather(searchWeather: String, complition: @escaping(Result<HourlyWeatherModel, Error>) -> Void) -> Void {
        CLGeocoder().geocodeAddressString("\(searchWeather)") { (placemarks, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            if let lat = placemarks?.first?.location?.coordinate.latitude,
               let lon = placemarks?.first?.location?.coordinate.longitude {
                
                guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast") else { return }
                let params = [
                    "appid" : "e44149cc5411443818aaf08afc6afc83",
                    "lat" : "\(lat)",
                    "lon" : "\(lon)",
                    "units" : "metric",
                    "lang" : "ru",
                    "cnt" : "9"
                ]
                AF.request(url, method: .get, parameters: params).response { response in
                    if let error = response.error {
                        complition(.failure(error))
                    } else {
                        if let data = response.data {
                            guard let responseData = try? JSONDecoder().decode(HourlyWeatherModel.self, from: data) else { return }
                            complition(.success(responseData))
                            print(responseData)
                        }
                    }
                }
            }
        }
    }
}
