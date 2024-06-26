//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Андрей Бабкин on 17.06.2024.
//

import Foundation
import Alamofire

class NetworkManager {
    func getWeather(searchWeather: String, complition: @escaping(Result<Welcome, Error>) -> Void) {
        guard let url = URL(string: "https://api.weatherapi.com/v1/current.json") else { return }
        let params = [
            "key" : "8a7d5dc0770349b99cd84254242204",
            "q" : searchWeather]
        
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

