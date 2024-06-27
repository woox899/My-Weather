// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let location: Location
    let current: Current
}

// MARK: - Current
struct Current: Codable {
    let tempC: Double
//    let tempF: Int?
//    let isDay: Int?
    let condition: Condition?
//    let windMph: Double?
//    let windKph: Double?
//    let windDegree: Int?
//    let windDir: String?
//    let pressureMB: Int?
//    let pressureIn: Double?
//    let precipMm: Int?
//    let precipIn: Int?
//    let humidity: Int?
//    let cloud: Int?
//    let feelslikeC: Double?
//    let feelslikeF: Double?
//    let windchillC: Double?
//    let windchillF: Int?
//    let heatindexC: Double?
//    let heatindexF: Double?
//    let dewpointC: Int?
//    let dewpointF: Double?
//    let visKM: Int?
//    let visMiles: Int?
//    let uv: Int?
//    let gustMph: Int?
//    let gustKph: Double?
    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case condition
    }
}

// MARK: - Condition
struct Condition: Codable {
    let text: String?
    let icon: String?
    let code: Int?
}

// MARK: - Location
struct Location: Codable {
    let name: String
    let region: String
//    let country: String?
//    let lat: Double?
//    let lon: Double?
//    let tzID: String?
//    let localtimeEpoch: Int?
//    let localtime: String?
}

