//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Sonata Girl on 14.03.2023.
//

import Foundation

struct WeatherManager {
    
    let url = "https://api.openweathermap.org/data/2.5/weather?appid=02dbb7cef286a93870a795ee1dc43d39&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(url)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
//        1. Create a URL
        if let url = URL(string: urlString) {
            //        2. Create a URLSession
            let session = URLSession(configuration: .default)
            //        3. Give the session a Task
            let task = session.dataTask(with: url, completionHandler: handle(data: response: error:))
            //        4. Start the task
            task.resume()
        }
    }
    
    func handle(data: Data?, response: URLResponse?, error: Error?) {
        if error != nil {
            print(error!)
            return
        }
        
        if let safeData = data {
            let dataString = String(data: safeData, encoding: .utf8)
            print(dataString)
        }
    }
}
