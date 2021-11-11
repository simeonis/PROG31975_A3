//
//  WeatherHelper.swift
//  Shae_Weather
//
//  Created by Shae Simeoni on 2021-11-10.
//

import Foundation
import CoreLocation
import SwiftUI

class WeatherHelper : ObservableObject {
    @Published var currentWeather = Weather()
    
    private let apiKey = "5920f032140b48cc92d201224211011"
    private let apiUrl = "https://api.weatherapi.com/v1/current.json?key="
    
    func updateWeather(coords : CLLocationCoordinate2D) {
        fetchDataFromApi(api : apiUrl + apiKey + "&q=\(coords.latitude),\(coords.longitude)")
    }
    
    private func fetchDataFromApi(api : String) {
        guard let api = URL(string: api) else {
            return
        }
        
        URLSession.shared.dataTask(with: api) {(data: Data?, response: URLResponse?, error: Error?) in
            if let err = error{
                print(#function, err)
            } else {
                // Received data or response
                DispatchQueue.global().async {
                    do {
                        if let jsonData = data {
                            let decoder = JSONDecoder()
                            
                            //use this if API response is a JSON object
                            let decodedWeather = try decoder.decode(Weather.self, from: jsonData)
                            
                            DispatchQueue.main.async {
                                self.currentWeather = decodedWeather
                            }
                        } else {
                            print(#function, "No JSON data received")
                        }
                    } catch let error{
                        print(#function, error)
                    }
                }
            }
        }.resume()
    }
}
