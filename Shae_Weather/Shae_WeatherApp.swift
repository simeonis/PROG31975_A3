//
//  Shae_WeatherApp.swift
//  Shae_Weather
//
//  Created by Shae Simeoni on 2021-11-10.
//

import SwiftUI
import CoreLocation

@main
struct Shae_WeatherApp: App {
    let locationHelper = LocationHelper()
    let weatherHelper = WeatherHelper()
    
    init() {
        self.locationHelper.setWeatherHelper(helper: weatherHelper)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(locationHelper)
                .environmentObject(weatherHelper)
        }
    }
}
