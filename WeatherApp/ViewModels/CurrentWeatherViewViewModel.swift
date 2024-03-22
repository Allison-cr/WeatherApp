//
//  CurrentWeatherViewViewModel.swift
//  WeatherApp
//
//  Created by Alexander Suprun on 21.03.2024.
//

import Foundation
import UIKit
import CoreLocation

class CurrentWeatherViewViewModel {
    
    let weatherManager = WeatherManager()
    let locationManager = LocationManager.shared
    
    // MARK: Get location
    func getLocationAndFetchWeather(completion: @escaping (Result<ForecastResponseBody, Error>) -> Void) {
        locationManager.getCurrentLocation { result in
            switch result {
            case .success(let location):
                self.fetchWeatherForecast(for: location, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: Get weather
    private func fetchWeatherForecast(for location: CLLocation, completion: @escaping (Result<ForecastResponseBody, Error>) -> Void) {
        self.weatherManager.getCurrentForecast(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude) { result in
            switch result {
            case .success(let forecastResponseBody):
                completion(.success(forecastResponseBody))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
