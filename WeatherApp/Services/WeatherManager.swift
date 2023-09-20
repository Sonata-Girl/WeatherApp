//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Sonata Girl on 14.03.2023.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didUpdateWeekWeather(_ weatherModelsForPresent: WeatherModelsForPresent)
    func didFailWithError(error: Error)
}

fileprivate enum ApiType {
    case login, getCurrentWeather, getWeekWeather
    
    static var baseURL: String{
       return "https://api.openweathermap.org/data/2.5/"
    }
    
    private var headers: [String: String] {
        switch self {
        case .login :
            return ["authToken": "12345"]
        default:
            return[:]
        }
    }
    
    private var path: String {
        switch self {
        case .login: return "login"
        case .getCurrentWeather: return "weather"
        case .getWeekWeather: return "forecast"
        }
    }
    
    private var mainParameters: String {
        switch self {
        case .login: return ""
        default:
            return "?appid=02dbb7cef286a93870a795ee1dc43d39&units=metric"
        }
    }
    
    var urlString: String {
        return "https://api.openweathermap.org/data/2.5/" + path + mainParameters
    }
}

class WeatherManager {
    static let shared = WeatherManager()
    private let api = ApiType.self
    private let decoder = JSONDecoder()
    private let baseURL = ApiType.baseURL
    var delegate: WeatherManagerDelegate?
   
    func fetchWeather(cityName: String) {
        var  urlString = "\(api.getCurrentWeather.urlString)&q=\(cityName)"
        currentWeatherRequest(urlString: urlString)
        urlString = "\(api.getWeekWeather.urlString)&q=\(cityName)"
        weekWeatherRequest(urlString: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        var urlString = "\(api.getCurrentWeather.urlString)&lat=\(latitude)&lon=\(longitude)"
        currentWeatherRequest(urlString: urlString)
        urlString = "\(api.getWeekWeather.urlString)&lat=\(latitude)&lon=\(longitude)"
        weekWeatherRequest(urlString: urlString)
    }
    
    func currentWeatherRequest(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    print(error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSONOneDayWeather(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSONOneDayWeather(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let temp = decodedData.main.temp
            
            let weather = WeatherModel(id: id, cityName: name, temp: temp)
            return weather
        } catch {
            print(error)
            return nil
        }
    }
    
    func weekWeatherRequest(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    print(error!)
                    return
                }
                if let safeData = data {
                    print(String(data: safeData, encoding: .utf8)!)
                    if let weatherModels = self.parseJSONWeekWeather(safeData) {
                        let weatherModelsForPresent = WeatherModelsForPresent(self,
                                                                              weekWeatherList: weatherModels.weekList,
                                                                              threeDayWeatherList: weatherModels.threeDaysList)
                        self.delegate?.didUpdateWeekWeather(weatherModelsForPresent)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSONWeekWeather(_ weekWeatherData: Data) -> (weekList: WeatherModels, threeDaysList: WeatherModels)? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(WeekWeatherData.self, from: weekWeatherData)
    
            guard var weatherList = WeatherModels.getArray(from: decodedData) else { return nil }

            let today = Date()
            let threeDaysArray = weatherList.filter{($0.date?.timeIntervalSince(today) ?? 0)/60/60/24 <= 3}
            let filterThreeDays = threeDaysArray.filter{ $0.hourNumber == 12}
            
            weatherList = weatherList.filter{$0.hourNumber == 12}
            let weatherlists = (weekList: weatherList, threeDaysList: filterThreeDays)

            return weatherlists
        
        } catch {
            print(error)
            return nil
        }
    }
}

