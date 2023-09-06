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
    let dateTxt: String = ""
  
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...232: return "cloud.bolt"
        case 300...321: return "cloud.drizzle"
        case 500...531: return "cloud.rain"
        case 600...622: return "cloud.snow"
        case 700...701: return "cloud.fog"
        case 800: return "sun"
        case 800...804: return "cloud.bolt"
        default: return "cloud"
        }
    }
    
    var date: Date? {
        guard dateTxt.isEmpty else {return nil}
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return formatter.date(from: dateTxt) ?? nil
    }
    
}
