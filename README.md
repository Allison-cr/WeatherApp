# Приложение Погоды


Приветствую! Добро пожаловать в приложение Погоды. Это приложение предоставляет актуальную информацию о погоде для различных мест на планете.

Реалазиция происходит в WeatherViewController 
Для него созданы  
- WeatherView - отображает главную информацию погоды текущей погоды
-   SecondaryView - отображает второстепенную информацию погоды 
-   CustomView -  касотмнная вью для SecondaryView
-   CustomTableViewCell - кастомная ячейка для  UITableView
-   CellHourView - коллекция для отображения погоды на ближайшие часы

## Реализовано 
1. Получение погоды через API для определенных координат
```swift
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
```
2. Получение координат пользователя 

```swift
  public func getCurrentLocation(completion: @escaping (Result<CLLocation, Error>) -> Void) {
        self.locationFetchCompletion = completion
        
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        self.locationFetchCompletion?(.success(location))
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.locationFetchCompletion?(.failure(error))
    }
```

3. Загрузка данных 
```swift
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
```


