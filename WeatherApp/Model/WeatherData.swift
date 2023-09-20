//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Sonata Girl on 15.03.2023.
//

import Foundation

// MARK WeatherData
struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}

// MARK WeekWeatherData
struct WeekWeatherData: Codable {
    let list: [WeatherList]
    let cod: String
}

struct WeatherList: Codable {
    let main: Main
    let weather: [Weather]
    let dateTxt: String
    
    enum CodingKeys: String, CodingKey {
        case main
        case weather
        case dateTxt = "dt_txt"
    }
}


