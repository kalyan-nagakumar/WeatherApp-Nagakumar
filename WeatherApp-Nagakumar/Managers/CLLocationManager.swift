//
//  CLLocationManager.swift
//  NagaKumar-WeatherApp-SwiftUI
//
//  Created by Kalyan Vajrala on 11/30/23.
//

import Foundation
import CoreLocation

// LocationManager class manages location-related functionality in the app.
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    // CLLocationManager instance for handling location updates.
    let locationManagers = CLLocationManager()
    
    // Published properties for updating the UI based on location updates.
    @Published var location: CLLocationCoordinate2D?
    @Published var isLodaing: Bool = true
    
    // LocationManager initializer.
    override init() {
        super.init()
        locationManagers.delegate = self
    }
    
    // Check and handle the location manager authorization status.
    func checkLMAuthorizationSatus() {
        switch locationManagers.authorizationStatus {
        case .notDetermined:
            // Request location permission if not determined.
            requestPermission()
        case .authorizedAlways, .authorizedWhenInUse :
            // Update location when authorized.
            location = locationManagers.location?.coordinate
        case .denied :
            print("Show alert to inform the user about denied location access.")
        default :
            break
        }
    }
    
    // Request location permission.
    func requestPermission() {
        locationManagers.requestAlwaysAuthorization()
    }
    
    // Delegate method called when the location authorization status changes.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            // Update location and stop loading when authorized.
            isLodaing = false
            location = locationManagers.location?.coordinate
        }
    }
    
    // Delegate method called when location updates are received.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Update the location based on the received coordinates.
        location = locations.first?.coordinate
        print(locations)
    }
    
    // Delegate method called when there is an error getting the location.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Set loading to true and log the error.
        isLodaing = true
        print("Error getting Location", error)
    }
}
