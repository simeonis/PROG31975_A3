//
//  ContentView.swift
//  Shae_Weather
//
//  Created by Shae Simeoni on 2021-11-10.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var locationHelper : LocationHelper
    @EnvironmentObject var weatherHelper : WeatherHelper
    
    func updateWeather() -> Void {
        if (self.locationHelper.currentLocation != nil) {
            self.weatherHelper.updateWeather(coords: self.locationHelper.currentLocation!.coordinate)
        }
    }
    
    var body: some View {
        VStack {
            if (self.locationHelper.hasPermission()) {
                if (self.locationHelper.currentLocation != nil) {
                    // Weather Overview
                    VStack {
                        HStack {
                            Text(String(self.weatherHelper.currentWeather.temp_c) + "°C")
                                .font(.system(size: 64))
                            
                            Image(uiImage: self.weatherHelper.currentWeather.condition.icon.load())
                                .resizable()
                                .frame(width: 64, height: 64)
                                .aspectRatio(contentMode: .fit)
                            
                            Spacer()
                        }
                        
                        Text("\(self.weatherHelper.currentWeather.city)")
                            .font(.system(size: 28)).bold().foregroundColor(Color.blue)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("\(self.weatherHelper.currentWeather.country)")
                            .font(.system(size: 12)).foregroundColor(Color.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(16)
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
                    
                    // Weather Overview Extra
                    VStack(alignment: .leading) {
                        Text("\(self.weatherHelper.currentWeather.condition.text)").bold().padding(EdgeInsets(top: 8, leading: 8, bottom: 0, trailing: 8))
                        Text("Feels Like: " + String(self.weatherHelper.currentWeather.feelslike_c) + "°C")
                            .padding(EdgeInsets(top: 0, leading: 8, bottom: 8, trailing: 8))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // Weather Details
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "wind")
                                .frame(width: 16, height: 16)
                            Text("WIND").padding(.horizontal, 8)
                            Spacer()
                            Text("\(self.weatherHelper.currentWeather.wind_dir) " + String(self.weatherHelper.currentWeather.wind_kph) + " KM/H")
                        }.padding(8)
                        HStack {
                            Image(systemName: "drop")
                                .frame(width: 16, height: 16)
                            Text("HUMIDITY").padding(.horizontal, 8)
                            Spacer()
                            Text("\(self.weatherHelper.currentWeather.humidity) %")
                        }.padding(8)
                        HStack {
                            Image(systemName: "sun.max")
                                .frame(width: 16, height: 16)
                            Text("UV").padding(.horizontal, 8)
                            Spacer()
                            Text(String(self.weatherHelper.currentWeather.uv))
                        }.padding(8)
                        HStack {
                            Image(systemName: "eye")
                                .frame(width: 16, height: 16)
                            Text("VISIBILITY").padding(.horizontal, 8)
                            Spacer()
                            Text(String(self.weatherHelper.currentWeather.vis_km) + " KM")
                        }.padding(8)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.white)
                    .cornerRadius(10)
                    
                    // TEMPORARY
                    Button(action: updateWeather) {
                        Text("Update Weather")
                    }
                    
                    Spacer()
                } else {
                    Text("Obtaining user location...")
                }
            } else {
                Text("Location permission denied. Please check your settings.")
            }
        }
        .padding(16)
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
