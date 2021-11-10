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
        text = ""
        icon = ""
        code = 0
    }
}

struct Weather: Codable {
    var temp_c : Float
//    var feelslike_c : Float
//    var wind_kph : Float
//    var wind_dir : String
//    var humidity : Int
//    var uv : Float
//    var vis_km : Float
//    var condition : Condition

    enum CodingKeys: String, CodingKey {
        case location = "location"
        case current = "current"
    }
    
    enum NestedCodingKeys: String, CodingKey {
        case temp_c = "temp_c"
//        case feelslike_c = "feels_like_c"
//        case wind_kph = "wind_kph"
//        case wind_dir = "wind_dir"
//        case humidity = "humidity"
//        case uv = "uv"
//        case vis_km = "vis_km"
//        case condition = "condition"
    }

    init() {
        temp_c = 0.0
//        feelslike_c = 0.0
//        wind_kph = 0.0
//        wind_dir = ""
//        humidity = 0
//        uv = 0.0
//        vis_km = 0.0
//        condition = Condition()
    }

    func encode(to encoder: Encoder) throws {
        // Nothing to encode
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let locationContainer = try container.nestedContainer(keyedBy: NestedCodingKeys.self, forKey: .location)
        let currentContainer = try container.nestedContainer(keyedBy: NestedCodingKeys.self, forKey: .current)
        
        self.temp_c = try currentContainer.decodeIfPresent(Float.self, forKey: .temp_c) ?? 0.0
    }
}
