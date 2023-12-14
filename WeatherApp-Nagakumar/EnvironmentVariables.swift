//
//  EnvironmentVariables.swift
//  WeatherApp-Nagakumar
//
//  Created by Kalyan Vajrala on 12/5/23.
//

import Foundation
import CoreLocation

enum Enivornment {
    
   static var baseAPI : String {
        return "https://api.openweathermap.org/data/2.5/"
    }
    static var apiToken : String {
        return "f61afa918b939278c962ee11adccb66f"
    }
}

enum WeatherType:NSMutableString {
   
    case currentWeather = "weather?"
    case futherWeather = "forecast?"
    
    
}

enum WeatherAPI {

    static func getAPIURL( weatherType: WeatherType,coordinates:CLLocation) -> String {
        var endpoint: NSMutableString

        switch weatherType {
        case .currentWeather:
            endpoint = WeatherType.currentWeather.rawValue
        case .futherWeather:
            endpoint = WeatherType.futherWeather.rawValue
        }
        
        endpoint.append("lat=\(coordinates.coordinate.latitude)&lon=\(coordinates.coordinate.longitude)")
        endpoint.append("&appid=\(Enivornment.apiToken)&units=metric")
        print(endpoint)
        
        return "\(Enivornment.baseAPI)\(endpoint)"
    }
}


enum NetworkErros:String, Error {
    case badUrl
    case failedCall
    case badResponse
    case noData
    case decodingError
    
    var description : String {
        switch self {
        case .badUrl:  return "Bad Urllllllllll"
       
        case .failedCall:
            return "Bad Url"
        case .badResponse:
            return "Bad Response"
        case .noData:
            return "Bad Url"
        case .decodingError:
            return "Bad Url"
        }
    }
}
extension Double {
    func formattedString() -> String {
        return String(format: "%.2f", self)
    }
}



extension String {
    func extractDay() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        if let date = dateFormatter.date(from: self) {
            let dayFormatter = DateFormatter()
            dayFormatter.dateFormat = "HH"
            let dayString = dayFormatter.string(from: date)
            return dayString
        } else {
            print("Error: Unable to parse the date.")
            return nil
        }
    }


}


