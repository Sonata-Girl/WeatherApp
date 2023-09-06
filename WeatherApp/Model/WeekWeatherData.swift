//
//  WeekWeatherData.swift
//  WeatherApp
//
//  Created by Sonata Girl on 06.09.2023.
//

import Foundation

struct WeekWeatherData: Codable {
    let list: [WeatherList]
    let cod: String
}

struct WeatherList: Codable {
    let main: Main
    let weather: Weather
    let dateTxt: String
    
    enum CodingKeys: String, CodingKey {
        case main
        case weather
        case dateTxt = "dt_txt"
    }
}

