//
//  ContentView.swift
//  Shae_Weather
//
//  Created by Shae Simeoni on 2021-11-10.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var locationHelper : LocationHelper
    
    var body: some View {
        VStack {
            if (self.locationHelper.hasPermission()) {
                if (self.locationHelper.currentLocation != nil) {
                    Text("Lat: \(self.locationHelper.currentLocation!.coordinate.latitude)")
                    Text("Long: \(self.locationHelper.currentLocation!.coordinate.longitude)")
                } else {
                    Text("Obtaining user location...")
                }
            } else {
                Text("Location permission denied. Please check your settings.")
            }
        }
        .onAppear(){
            self.locationHelper.checkPermission()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
