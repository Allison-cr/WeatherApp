//
//  ViewController.swift
//  WeatherApp
//
//  Created by Alexander Suprun on 20.03.2024.
//
import UIKit

class WeatherViewController: UIViewController {
    
    private let primaryView = WeatherView()
    private let viewModel = CurrentWeatherViewViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()

        viewModel.getLocationAndFetchWeather { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let forecastResponseBody):
                self.updateUI(with: forecastResponseBody)
            case .failure(let error):
                print("Ошибка: \(error)")
            }
        }
    }
    
    private func updateUI(with forecastResponseBody: ForecastResponseBody) {
        DispatchQueue.main.async {
            self.primaryView.temperatureLabel.text = "Температура \(forecastResponseBody.list.first?.main.temp ?? 0)°C"
            self.primaryView.descriptionLabel.text = forecastResponseBody.list.first?.weather.first?.description ?? ""
            self.primaryView.feels_likeLabel.text  = "Ощущается как \(forecastResponseBody.list.first?.main.feels_like ?? 0)°C"
            self.primaryView.temp_minLabel.text  = "Минимальная температура \(forecastResponseBody.list.first?.main.temp_min ?? 0)°C"
            self.primaryView.temp_maxLabel.text  = "Максимальная температура \(forecastResponseBody.list.first?.main.temp_max ?? 0)°C"
            self.primaryView.humidityLabel.text  = "Влажность \(forecastResponseBody.list.first?.main.humidity ?? 0) %"
            self.primaryView.pressureabel.text  = "Давление \(forecastResponseBody.list.first?.main.temp_max ?? 0) hPa"
            self.primaryView.cityLabel.text  =  forecastResponseBody.city.name
            
            if let dateString = forecastResponseBody.list.first?.dt_txt {
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: "ru_RU")
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                if let date = dateFormatter.date(from: dateString) {
                    dateFormatter.dateFormat = "dd EEEE"
                    let dayOfWeek = dateFormatter.string(from: date)
                    self.primaryView.dataLabel.text = "День недели: \(dayOfWeek)"
                }
            } 
        }
    }
    
    private func setUpView() {
            view.addSubview(primaryView)
            NSLayoutConstraint.activate([
                primaryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                primaryView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
                primaryView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
                primaryView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            ])
        }

}
