//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Alexander Suprun on 21.03.2024.
//

import Foundation

struct ForecastResponseBody: Decodable {
    var list: [ForecastItemResponse]
    var city: CityResponse
    
    struct ForecastItemResponse: Decodable {
        var main: MainResponse
        var weather: [WeatherResponse]
        var wind: WindResponse
        var visibility: Double
        var pop: Double
        var dt_txt: String
        
        struct MainResponse: Decodable {
            var temp: Double
            var feels_like: Double
            var temp_min: Double
            var temp_max: Double
            var pressure: Double
            var humidity: Double
        }
        
        struct WeatherResponse: Decodable {
            var id: Double
            var main: String
            var description: String
            var icon: String
        }
        
        struct WindResponse: Decodable {
            var speed: Double
            var deg: Double
            var gust: Double 
        }
    }
    
    struct CityResponse: Decodable {
        var name: String
    }
}
