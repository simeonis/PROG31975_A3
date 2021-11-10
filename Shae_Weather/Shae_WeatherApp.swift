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
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(locationHelper)
        }
    }
}
