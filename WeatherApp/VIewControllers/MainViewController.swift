//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Sonata Girl on 12.03.2023.
//

import UIKit
import CoreLocation

final class MainViewController: UIViewController {
    
    private var weatherManager = WeatherManager()
    private lazy var locationManager = CLLocationManager()
    
    private lazy var mainView = WeatherMainView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() // запрос разрешения?
        locationManager.requestLocation() // запрос геолокации
       
        weatherManager.delegate = self
        mainView.setupDelegateForTextField(self)
    }
}

extension MainViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        mainView.textFieldEndEditing()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = textField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        mainView.textFieldSetText("")
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
}

extension MainViewController: WeatherManagerDelegate {
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.mainView.setDegreesLabel(weather.temperatureString)
            self.mainView.setWeatherImageView(weather.conditionName)
            self.mainView.setCityLabel(weather.cityName)
        }
    }

    func didUpdateWeekWeather(_ weatherModelsForPresent: WeatherModelsForPresent) {
        DispatchQueue.main.async {
            self.mainView.setBottomViewWeek(weekWeatherList: weatherModelsForPresent.weekWeatherList, threeDayWeatherList: weatherModelsForPresent.threeDayWeatherList)
        }
    }
}

// MARK: - CClocationManagerDelegate
extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

extension MainViewController {
    
    @objc
    func searchButtonPressed(_ sender: UIButton) {
         mainView.textFieldEndEditing()
     }
    
    @objc
    func locationButtonTapped(_ sender: UIButton) {
        mainView.textFieldSetText("")
        locationManager.requestLocation()
    }
}
