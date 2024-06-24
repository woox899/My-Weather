// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let location: Location?
    let current: Current?
}

// MARK: - Current
struct Current: Codable {
    let lastUpdatedEpoch: Int?
    let lastUpdated: String?
    let tempC: Double?
    let tempF, isDay: Int?
    let condition: Condition?
    let windMph, windKph: Double?
    let windDegree: Int?
    let windDir: String?
    let pressureMB: Int?
    let pressureIn: Double?
    let precipMm, precipIn, humidity, cloud: Int?
    let feelslikeC, feelslikeF, windchillC: Double?
    let windchillF: Int?
    let heatindexC, heatindexF: Double?
    let dewpointC: Int?
    let dewpointF: Double?
    let visKM, visMiles, uv, gustMph: Int?
    let gustKph: Double?

    enum CodingKeys: String, CodingKey {
        case lastUpdatedEpoch
        case lastUpdated
        case tempC
        case tempF
        case isDay
        case condition
        case windMph
        case windKph
        case windDegree
        case windDir
        case pressureMB
        case pressureIn
        case precipMm
        case precipIn
        case humidity, cloud
        case feelslikeC
        case feelslikeF
        case windchillC
        case windchillF
        case heatindexC
        case heatindexF
        case dewpointC
        case dewpointF
        case visKM
        case visMiles
        case uv
        case gustMph
        case gustKph
    }
}

// MARK: - Condition
struct Condition: Codable {
    let text, icon: String?
    let code: Int?
}

// MARK: - Location
struct Location: Codable {
    let name, region, country: String?
    let lat, lon: Double?
    let tzID: String?
    let localtimeEpoch: Int?
    let localtime: String?

    enum CodingKeys: String, CodingKey {
        case name, region, country, lat, lon
        case tzID
        case localtimeEpoch
        case localtime
    }
}

