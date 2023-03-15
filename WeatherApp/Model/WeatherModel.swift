//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Sonata Girl on 15.03.2023.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        switch conditionId {
        case 200..<300: return "cloud.bolt"
        case 300..<400: return "cloud.drizzle"
        case 500..<600: return "cloud.rain"
        case 600..<700: return "cloud.snow"
        case 700..<800: return "cloud.fog"
        case 800: return "sun"
        case 800...804: return "cloud"
        default: return "none"
        }
    }
}
