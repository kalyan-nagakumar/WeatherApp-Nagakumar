//
//  CurrentWeatherViewModel.swift
//  WeatherApp-Nagakumar
//
//  Created by Kalyan Vajrala on 12/5/23.
//

import Foundation
import Combine
import CoreLocation


@MainActor
class CurrentWeatherViewModel : NSObject,ObservableObject{
    
    
    private var service : ServiceProtocl
    @Published var currentDataModle : CurrentWeatherModel?
    @Published var errorMessage : String?
    @Published var futureDataModel :FutureWeatherModule?
    
    
    init(service: ServiceProtocl)  {
        self.service = service
    }
    
    
    
    
    
    func makeBothCalls(coordinates:CLLocation) async throws {
        
        do {
            currentDataModle = try await getCurrentWeatherData(coordinates: coordinates)
            
            futureDataModel =  try await getFutherWeatherData(coordinates: coordinates)
            
        }catch(let error) {
            print(error.localizedDescription)
            errorMessage = "Failed in calling "
        }
    }
    
    
    func getCurrentWeatherData(coordinates:CLLocation) async  throws -> CurrentWeatherModel  {
        
        //        do {
        let currentWeatherAPI = WeatherAPI.getAPIURL(weatherType: WeatherType.currentWeather, coordinates: coordinates)
        print(currentWeatherAPI)
        let currentData = try await service.fetchData(url: currentWeatherAPI, model: CurrentWeatherModel.self)
        return currentData
        //           currentDataModle = currentData
        //        }catch(let error) {
        //            print(error.localizedDescription)
        //            errorMessage = "Failed in calling "
        //        }
        
    }
    
    func getFutherWeatherData(coordinates:CLLocation) async throws -> FutureWeatherModule {
        //        do {
        let futureWeatherAPI = WeatherAPI.getAPIURL(weatherType: WeatherType.futherWeather, coordinates: coordinates)
        print(futureWeatherAPI)
        let currentData = try await service.fetchData(url: futureWeatherAPI, model: FutureWeatherModule.self)
        return currentData
        //           currentDataModle = currentData
        //        }catch(let error) {
        //            print(error.localizedDescription)
        //            errorMessage = "Failed in calling "
        //        }
    }
    
    
    
    
}
