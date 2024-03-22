//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Alexander Suprun on 20.03.2024.
//
import Foundation
import CoreLocation

class WeatherManager {
    
    let apiKey = "eb95d4a8d31110b1d091182c02e558ec"
    
    func getCurrentForecast(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping (Result<ForecastResponseBody, Error>) -> Void) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric") else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(NSError(domain: "Invalid Response", code: -2, userInfo: nil)))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: -3, userInfo: nil)))
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(ForecastResponseBody.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
