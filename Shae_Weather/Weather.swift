//
//  Weather.swift
//  Shae_Weather
//
//  Created by Shae Simeoni on 2021-11-10.
//

import Foundation

struct Condition {
    var text : String
    var icon : String
    var code : Int

    init() {
        text = "TBD"
        icon = ""
        code = 0
    }
    
    init(text : String, icon : String, code : Int) {
        self.text = text
        self.icon = icon
        self.code = code
    }
}

struct Weather: Codable {
    // Location
    var city : String
    var country : String
    
    // Weather
    var temp_c : Float
    var feelslike_c : Float
    var wind_kph : Float
    var wind_dir : String
    var humidity : Int
    var uv : Float
    var vis_km : Float
    var condition : Condition

    enum CodingKeys: String, CodingKey {
        case location = "location"
        case current = "current"
    }
    
    enum NestedCodingKeys: String, CodingKey {
        case city = "name"
        case country = "country"
        case temperature = "temp_c"
        case feelsLike = "feelslike_c"
        case windSpeed = "wind_kph"
        case windDirection = "wind_dir"
        case humidity = "humidity"
        case uv = "uv"
        case visibility = "vis_km"
        case condition = "condition"
    }
    
    enum NestedNestedCodingKeys: String, CodingKey {
        case text = "text"
        case icon = "icon"
        case code = "code"
    }

    init() {
        city = "TBD"
        country = "TBD"
        temp_c = 0.0
        feelslike_c = 0.0
        wind_kph = 0.0
        wind_dir = ""
        humidity = 0
        uv = 0.0
        vis_km = 0.0
        condition = Condition()
    }

    func encode(to encoder: Encoder) throws {
        // Nothing to encode
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Location Information
        let locationContainer = try container.nestedContainer(keyedBy: NestedCodingKeys.self, forKey: .location)
        self.city = try locationContainer.decodeIfPresent(String.self, forKey: .city) ?? "Unknown"
        self.country = try locationContainer.decodeIfPresent(String.self, forKey: .country) ?? "Unknown"
        
        // Weather Information
        let currentContainer = try container.nestedContainer(keyedBy: NestedCodingKeys.self, forKey: .current)
        self.temp_c = try currentContainer.decodeIfPresent(Float.self, forKey: .temperature) ?? 0.0
        self.feelslike_c = try currentContainer.decodeIfPresent(Float.self, forKey: .feelsLike) ?? 0.0
        self.wind_kph = try currentContainer.decodeIfPresent(Float.self, forKey: .windSpeed) ?? 0.0
        self.wind_dir = try currentContainer.decodeIfPresent(String.self, forKey: .windDirection) ?? "Unknown"
        self.humidity = try currentContainer.decodeIfPresent(Int.self, forKey: .humidity) ?? 0
        self.uv = try currentContainer.decodeIfPresent(Float.self, forKey: .uv) ?? 0.0
        self.vis_km = try currentContainer.decodeIfPresent(Float.self, forKey: .visibility) ?? 0.0
        
        // Weather Condition
        let conditionContainer = try currentContainer.nestedContainer(keyedBy: NestedNestedCodingKeys.self, forKey: .condition)
        let text = try conditionContainer.decodeIfPresent(String.self, forKey: .text)
        let icon = try conditionContainer.decodeIfPresent(String.self, forKey: .icon)
        let code = try conditionContainer.decodeIfPresent(Int.self, forKey: .code)
        
        if (text == nil || icon == nil || code == nil) {
            self.condition = Condition()
        } else {
            self.condition = Condition(text: text!, icon: icon!, code: code!)
        }
    }
}
