//
//  LocationHelper.swift
//  Shae_Weather
//
//  Created by Shae Simeoni on 2021-11-10.
//

import Foundation
import SwiftUI
import CoreLocation
import Contacts
import MapKit

class LocationHelper: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    @Published var currentLocation: CLLocation?
    
    private let locationManager = CLLocationManager()
    private var lastSeenLocation : CLLocation?
    private var weatherHelper : WeatherHelper?
    
    override init() {
        super.init()
        
        if (CLLocationManager.locationServicesEnabled()){
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        }
        
        if (CLLocationManager.locationServicesEnabled() && ( self.authorizationStatus == .authorizedAlways || self.authorizationStatus == .authorizedWhenInUse)){
            self.locationManager.startUpdatingLocation()
        } else {
            self.requestPermission()
        }
    }
    
    func requestPermission() {
        if (CLLocationManager.locationServicesEnabled()){
            self.locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func checkPermission(){
        print(#function, "Checking for permission")
        switch self.locationManager.authorizationStatus {
        case .denied:
            self.requestPermission()
        case .notDetermined:
            self.requestPermission()
        case .restricted:
            self.requestPermission()
        case .authorizedAlways:
            self.locationManager.startUpdatingLocation()
        case .authorizedWhenInUse:
            self.locationManager.startUpdatingLocation()
        default:
            break
        }
    }
    
    func hasPermission() -> Bool {
        return (self.locationManager.authorizationStatus == .authorizedAlways || self.locationManager.authorizationStatus == .authorizedWhenInUse)
    }
    
    func setWeatherHelper(helper : WeatherHelper) {
        self.weatherHelper = helper
    }
    
    func updateWeather() {
        if (self.weatherHelper != nil && self.currentLocation != nil) {
            self.weatherHelper!.updateWeather(coords: self.currentLocation!.coordinate)
        }
    }
    
    deinit {
        locationManager.stopUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function, "Authorization Status : \(manager.authorizationStatus.rawValue)")
        self.authorizationStatus = manager.authorizationStatus
        self.checkPermission()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.lastSeenLocation = locations.first
        print(#function, "last seen location: \(self.lastSeenLocation!)")
        
        if locations.last != nil{
            self.currentLocation = locations.last!
        } else {
            self.currentLocation = locations.first
        }
        
        print(#function, "current location: \(self.currentLocation!)")
        
        self.updateWeather()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function, "error: \(error.localizedDescription)")
    }
}
