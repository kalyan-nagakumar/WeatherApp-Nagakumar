//
//  WeatherApp_NagakumarApp.swift
//  WeatherApp-Nagakumar
//
//  Created by Kalyan Vajrala on 12/5/23.
//

import SwiftUI

@main
struct WeatherApp_NagakumarApp: App {
     let serviceImpl = ServiceLayerImpl()
    var body: some Scene {
        WindowGroup {
            ContentView(currentVMP: CurrentWeatherViewModel(service: serviceImpl))
        }
    }
}
