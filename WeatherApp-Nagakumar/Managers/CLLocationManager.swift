//
//  CLLocationManager.swift
//  NagaKumar-WeatherApp-SwiftUI
//
//  Created by Kalyan Vajrala on 11/30/23.
//

import Foundation
import CoreLocation

class LocationManager:NSObject,ObservableObject,CLLocationManagerDelegate {
    
    let locationManagers = CLLocationManager()
    @Published var location: CLLocationCoordinate2D?
    @Published var isLodaing : Bool = true
   
    
    override init() {
        super.init()
      
        locationManagers.delegate = self
    }
    
     func checkLMAuthorizationSatus() {
      
        switch locationManagers.authorizationStatus {
        case .notDetermined:
            requestPermission()
        case .authorizedAlways, .authorizedWhenInUse :
            location = locationManagers.location?.coordinate
        case .denied :
            print("show alert")
        default :
            break
        }
    }
    
    
    func requestPermission() {
        locationManagers.requestAlwaysAuthorization()
        
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            isLodaing = false
            location = locationManagers.location?.coordinate
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        location = locations.first?.coordinate
        print(locations)
       
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        isLodaing = true
        print("Error getting Location",error)
    }
    
    
}
