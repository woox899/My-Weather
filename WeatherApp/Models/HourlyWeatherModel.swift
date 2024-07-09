// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct HourlyWeatherModel: Codable {
//    let cod: String?
//    let message, cnt: Int?
    let list: [List]
//    let city: City?
}

// MARK: - City
//struct City: Codable {
//    let id: Int?
//    let name: String?
//    let coord: Coord?
//    let country: String?
//    let population, timezone, sunrise, sunset: Int?
//}

// MARK: - Coord
//struct Coord: Codable {
//    let lat, lon: Double?
//}

// MARK: - List
struct List: Codable {
    let dt: Date
    let main: MainClass
    let weather: [HourlyWeather]
//    let clouds: Clouds?
//    let wind: Wind?
//    let visibility: Int?
//    let pop: Double?
//    let sys: Sys?
    let dtTxt: String?
//    let rain: Rain?

    enum CodingKeys: String, CodingKey {
        case dt
        case main
        case weather
//        , clouds, wind, visibility, pop, sys
        case dtTxt = "dt_txt"
//        case rain
    }
}

// MARK: - Clouds
//struct Clouds: Codable {
//    let all: Int?
//}

//MARK: - MainClass
struct MainClass: Codable {
    let temp: Double
//    , feelsLike, tempMin, tempMax: Double
//    let pressure, seaLevel, grndLevel, humidity: Int?
//    let tempKf: Double?
//
//    enum CodingKeys: String, CodingKey {
//        case temp
//        case feelsLike
//        case tempMin
//        case tempMax
//        case pressure
//        case seaLevel
//        case grndLevel
//        case humidity
//        case tempKf
//    }
}

// MARK: - Rain
//struct Rain: Codable {
//    let the3H: Double?
//
//    enum CodingKeys: String, CodingKey {
//        case the3H
//    }
//}

// MARK: - Sys
//struct Sys: Codable {
//    let pod: Pod?
//}

//enum Pod: String, Codable {
//    case d = "d"
//    case n = "n"
//}

// MARK: - Weather
struct HourlyWeather: Codable {
//    let id: Int?
//    let main: MainEnum?
//    let description: String?
    let icon: String
}

//enum MainEnum: String, Codable {
//    case clear = "Clear"
//    case clouds = "Clouds"
//    case rain = "Rain"
//}

// MARK: - Wind
//struct Wind: Codable {
//    let speed: Double?
//    let deg: Int?
//    let gust: Double?
//}
