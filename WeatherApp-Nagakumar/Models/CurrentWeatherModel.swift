//  Created by Kalyan Vajrala on 12/5/23.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let currentWeatherModel = try? JSONDecoder().decode(CurrentWeatherModel.self, from: jsonData)

import Foundation

// MARK: - CurrentWeatherModel
struct CurrentWeatherModel: Codable {
    var coord: Coord?
    var weather: [Weather]?
    var base: String?
    var main: Main?
    var visibility: Int?
    var wind: Wind?
    var clouds: Clouds?
    var dt: Int?
    var sys: Sys?
    var timezone, id: Int?
    var name: String?
    var cod: Int?
}

// MARK: - Clouds
struct Clouds: Codable {
    var all: Int?
}

// MARK: - Coord
struct Coord: Codable {
    var lon, lat: Double?
}

// MARK: - Main
struct Main: Codable {
    var temp, feelsLike, tempMin, tempMax: Double?
    var pressure, humidity: Int?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// MARK: - Sys
struct Sys: Codable {
    var type, id: Int?
    var country: String?
    var sunrise, sunset: Int?
}

// MARK: - Weather
struct Weather: Codable {
    var id: Int?
    var main, description, icon: String?
    
    var getImageWithString: String {
        switch main {
        case "Clear":
            return "sun.max.fill"
        case "Clouds":
            return "cloud.fill"
        case "Rain":
            return "cloud.rain.fill"
        case "Snow":
            return "snowflake"
        case "Drizzle":
            return "cloud.drizzle.fill"
        default:
            return "questionmark.circle"
        }
    }
    
}

// MARK: - Wind
struct Wind: Codable {
    var speed: Double?
    var deg: Int?
}
