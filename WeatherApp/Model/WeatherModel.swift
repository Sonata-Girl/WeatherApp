//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Sonata Girl on 15.03.2023.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    var cityName: String = ""
    let temperature: Double
    var dateTxt: String = ""

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
        case 800: return "sun.max"
        case 800...804: return "cloud.bolt"
        default: return "cloud"
        }
    }
    
    var date: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.date(from: dateTxt)
    }
        
    var dayNumber: Int {
        guard let date = date else { return 0 }
        return Calendar.current.component(.day, from: date)
    }
    
    var monthString: String {
        guard let date = date else { return "" }

        if #available(iOS 15.0, *) {
            let monthName = date.formatted(Date.FormatStyle().month(.abbreviated).locale(Locale(identifier: "en_US")))
                                
            return monthName
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US")
            dateFormatter.dateFormat = "MMM"
            return dateFormatter.string(from: date)
        }
    }
    
    var hourNumber: Int {
        guard let date = date else { return 0 }
        return Calendar.current.component(.hour, from: date)
    }
    
}

extension WeatherModel {
    init(id: Int, temp: Double, dateTxt: String) {
        self.conditionId = id
        self.temperature = temp
        self.dateTxt = dateTxt
    }
    
    init(id: Int, cityName: String, temp: Double) {
        self.conditionId = id
        self.cityName = cityName
        self.temperature = temp
    }
    
}

struct WeatherModelsForPresent {
    let weatherManager: WeatherManager
    let weekWeatherList: WeatherModels
    let threeDayWeatherList: WeatherModels
    
    init(_ weatherManager: WeatherManager, weekWeatherList: WeatherModels, threeDayWeatherList: WeatherModels) {
        self.weatherManager = weatherManager
        self.weekWeatherList = weekWeatherList
        self.threeDayWeatherList = threeDayWeatherList
    }
}

// MARK typealias
typealias WeatherModels = [WeatherModel]

extension WeatherModels {
    static func getArray(from weekWeatherList: WeekWeatherData) -> [WeatherModel]? {
        return weekWeatherList.list.compactMap{ WeatherModel(id: $0.weather[0].id, temp: $0.main.temp, dateTxt: $0.dateTxt) }
    }
}
