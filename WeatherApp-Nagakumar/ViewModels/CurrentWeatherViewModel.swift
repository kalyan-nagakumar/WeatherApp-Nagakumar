
//
//  CurrentWeatherViewModel.swift
//  WeatherApp-Nagakumar
//
//  Created by Kalyan Vajrala on 12/5/23.
//

import Foundation
import Combine
import CoreLocation

// CurrentWeatherViewModel is a class responsible for managing current weather data in the app.
@MainActor
class CurrentWeatherViewModel : NSObject, ObservableObject {
    
    // Service protocol for making API calls.
    private var service : ServiceProtocl
    
    // Published properties for updating the UI.
    @Published var currentDataModle : CurrentWeatherModel?
    @Published var errorMessage : String?
    @Published var futureDataModel : FutureWeatherModule?
    
    // Initializer for CurrentWeatherViewModel.
    init(service: ServiceProtocl)  {
        self.service = service
    }
    
    // Function to make both current and future weather API calls.
    func makeBothCalls(coordinates: CLLocation) async throws {
        do {
            // Fetch current weather data.
            currentDataModle = try await getCurrentWeatherData(coordinates: coordinates)
            
            // Fetch future weather data.
            futureDataModel = try await getFutherWeatherData(coordinates: coordinates)
            
        } catch(let error) {
            print(error.localizedDescription)
            errorMessage = "Failed in calling "
        }
    }
    
    // Function to get current weather data from the API.
    func getCurrentWeatherData(coordinates: CLLocation) async throws -> CurrentWeatherModel {
        let currentWeatherAPI = WeatherAPI.getAPIURL(weatherType: WeatherType.currentWeather, coordinates: coordinates)
        print(currentWeatherAPI)
        
        // Fetch data using the service layer.
        let currentData = try await service.fetchData(url: currentWeatherAPI, model: CurrentWeatherModel.self)
        return currentData
    }
    
    // Function to get future weather data from the API.
    func getFutherWeatherData(coordinates: CLLocation) async throws -> FutureWeatherModule {
        let futureWeatherAPI = WeatherAPI.getAPIURL(weatherType: WeatherType.futherWeather, coordinates: coordinates)
        print(futureWeatherAPI)
        
        // Fetch data using the service layer.
        let currentData = try await service.fetchData(url: futureWeatherAPI, model: FutureWeatherModule.self)
        return currentData
    }
}
