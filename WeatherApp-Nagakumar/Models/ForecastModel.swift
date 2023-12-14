////
////  ForecastModel.swift
////  WeatherApp-Nagakumar
////
////  Created by Kalyan Vajrala on 12/7/23.
////
//
//import Foundation
//
//// MARK: - FutureWeatherModule
//struct FutureWeatherModule: Codable {
//    var cod: String?
//    var message, cnt: Int?
//    var list: [List]?
//    var city: Citys?
//}
//
//// MARK: - City
//struct Citys: Codable {
//    var id: Int?
//    var name: String?
//    var coord: Coords?
//    var country: String?
//    var population, timezone, sunrise, sunset: Int?
//}
//
//// MARK: - Coord
//struct Coords: Codable {
//    var lat, lon: Double?
//}
//
//// MARK: - List
//struct List: Codable {
//    var dt: Int?
//    var main: MainClasss?
//    var weather: [Weathers]?
//    var clouds: Cloudss?
//    var wind: Winds?
//    var visibility: Int?
//    var pop: Double?
//    var rain: Rain?
//    var sys: Syss?
//    var dtTxt: String?
//
//    enum CodingKeys: String, CodingKey {
//        case dt, main, weather, clouds, wind, visibility, pop, rain, sys
//        case dtTxt = "dt_txt"
//    }
//}
//
//// MARK: - Clouds
//struct Cloudss: Codable {
//    var all: Int?
//}
//
//// MARK: - MainClass
//struct MainClasss: Codable {
//    var temp, feelsLike, tempMin, tempMax: Double?
//    var pressure, seaLevel, grndLevel, humidity: Int?
//    var tempKf: Double?
//
//    enum CodingKeys: String, CodingKey {
//        case temp
//        case feelsLike = "feels_like"
//        case tempMin = "temp_min"
//        case tempMax = "temp_max"
//        case pressure
//        case seaLevel = "sea_level"
//        case grndLevel = "grnd_level"
//        case humidity
//        case tempKf = "temp_kf"
//    }
//}
//
//// MARK: - Rain
//struct Rain: Codable {
//    var the3H: Double?
//
//    enum CodingKeys: String, CodingKey {
//        case the3H = "3h"
//    }
//}
//
//// MARK: - Sys
//struct Syss: Codable {
//    var pod: Pod?
//}
//
//enum Pod: String, Codable {
//    case d = "d"
//    case n = "n"
//}
//
//// MARK: - Weather
//struct Weathers: Codable {
//    var id: Int?
//    var main: ma?
//    var description: Description?
//    var icon: String?
//
//    var getImageWithString: String {
//        switch main {
//        case "Clear":
//            return "sun.max.fill"
//        case "Clouds":
//            return "cloud.fill"
//        case "Rain":
//            return "cloud.rain.fill"
//        case "Snow":
//            return "snowflake"
//        case "Drizzle":
//            return "cloud.drizzle.fill"
//        default:
//            return "questionmark.circle"
//        }
//    }
//}
//
//enum Description: String, Codable {
//    case brokenClouds = "broken clouds"
//    case clearSky = "clear sky"
//    case fewClouds = "few clouds"
//    case lightRain = "light rain"
//    case overcastClouds = "overcast clouds"
//    case scatteredClouds = "scattered clouds"
//
//}
//
//enum MainEnum: String, Codable {
//    case clear = "Clear"
//    case clouds = "Clouds"
//    case rain = "Rain"
//}
//
//// MARK: - Wind
//struct Winds: Codable {
//    var speed: Double?
//    var deg: Int?
//    var gust: Double?
//}
//
//
//
//
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let futureWeatherModule = try? JSONDecoder().decode(FutureWeatherModule.self, from: jsonData)

import Foundation

// MARK: - FutureWeatherModule
struct FutureWeatherModule: Codable {
    var cod: String?
    var message, cnt: Int?
    var list: [List]?
    var city: Citys?
}

// MARK: - City
struct Citys: Codable {
    var id: Int?
    var name: String?
    var coord: Coords?
    var country: String?
    var population, timezone, sunrise, sunset: Int?
}

// MARK: - Coord
struct Coords: Codable {
    var lat, lon: Double?
}

// MARK: - List
struct List: Codable {
    var dt: Int?
    var main: MainClass?
    var weather: [Weathers]?
    var clouds: Cloudss?
    var wind: Winds?
    var visibility: Int?
    var pop: Double?
    var sys: Syss?
    var dtTxt: String?
    var rain: Rain?

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, sys
        case dtTxt = "dt_txt"
        case rain
    }
}

// MARK: - Clouds
struct Cloudss: Codable {
    var all: Int?
}

// MARK: - MainClass
struct MainClass: Codable {
    var temp, feelsLike, tempMin, tempMax: Double?
    var pressure, seaLevel, grndLevel, humidity: Int?
    var tempKf: Double?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

// MARK: - Rain
struct Rain: Codable {
    var the3H: Double?

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

// MARK: - Sys
struct Syss: Codable {
    var pod: Pod?
}

enum Pod: String, Codable {
    case d = "d"
    case n = "n"
}

// MARK: - Weather
struct Weathers: Codable {
    var id: Int?
    var main: MainEnum?
    var description: Description?
    var icon: Icon?
    
    
    var getImageWithString: String {
        switch main?.rawValue {
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





enum Description: String, Codable {
    case brokenClouds = "broken clouds"
    case fewClouds = "few clouds"
    case lightRain = "light rain"
    case moderateRain = "moderate rain"
    case overcastClouds = "overcast clouds"
    case scatteredClouds = "scattered clouds"
}

enum Icon: String, Codable {
    case the02N = "02n"
    case the03N = "03n"
    case the04D = "04d"
    case the04N = "04n"
    case the10D = "10d"
    case the10N = "10n"
}

enum MainEnum: String, Codable {
    case clouds = "Clouds"
    case rain = "Rain"
}

// MARK: - Wind
struct Winds: Codable {
    var speed: Double?
    var deg: Int?
    var gust: Double?
}
