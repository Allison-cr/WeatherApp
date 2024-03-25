//
//  ViewController.swift
//  WeatherApp
//
//  Created by Alexander Suprun on 20.03.2024.
//

import UIKit

struct WeatherCellData {
    let date: String
    let temperature: String
    let iconImage: UIImage?
}

struct WeatherDayData {
    let date: String
    let temperature:String
}

class WeatherViewController: UIViewController  {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    private let primaryView = WeatherView()
    private let secondaryView = SecondaryWeatherView()
    private let viewModel = CurrentWeatherViewViewModel()
   
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
   
    let tableView = UITableView()
    private var weatherDataArray = [WeatherCellData]()
    private var weatherDayArray = [WeatherDayData]()

    let forecastWeather: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.text = "Погода на следующие 4 дня"
        return label
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        configureCollectionView()
        configureTableView()
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
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "Cell")
                
    }
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(CellHourWeather.self, forCellWithReuseIdentifier: "Cell")
    }
  
    // MARK: Uptade data
    private func updatePrimaryView(with forecastResponseBody: ForecastResponseBody) {
        guard let firstForecast = forecastResponseBody.list.first else { return }
        
        let temperature = Int(firstForecast.main.temp.rounded())
        let description = firstForecast.weather.first?.description ?? ""
        let feelsLike = Int(firstForecast.main.feels_like.rounded())
        let cityName = forecastResponseBody.city.name
        
        primaryView.temperatureLabel.text = "\(temperature)°"
        primaryView.descriptionLabel.text = description
        primaryView.feels_likeLabel.text = "Ощущается как \(feelsLike)°C"
        primaryView.cityLabel.text = cityName
    }

    private func updateSecondaryView(with forecastResponseBody: ForecastResponseBody) {
        guard let firstForecast = forecastResponseBody.list.first else { return }
        
        secondaryView.tempmaxView.message1 = "Максимальная температура"
        secondaryView.tempmaxView.message2 = "\(Int(firstForecast.main.temp_max.rounded()))°"
        secondaryView.tempmaxView.image = UIImage(systemName: "thermometer.medium")
        
        secondaryView.tempminView.message1 = "Минимальная температура"
        secondaryView.tempminView.message2 = "\(Int(firstForecast.main.temp_min.rounded()))°"
        secondaryView.tempminView.image = UIImage(systemName: "thermometer.low")
        
        secondaryView.pressureView.message1 = "Давление"
        secondaryView.pressureView.message2 = "\(firstForecast.main.temp_max) hPa"
        secondaryView.pressureView.image = UIImage(systemName: "heat.waves")
        
        secondaryView.humidityView.message1 = "Влажность"
        secondaryView.humidityView.message2 = "\(Int((firstForecast.main.humidity).rounded())) %"
        secondaryView.humidityView.image = UIImage(systemName: "humidity")
        
        secondaryView.popView.message1 = "Вероятность осадков"
        secondaryView.popView.message2 = "\(Int(firstForecast.pop.rounded())) %"
        secondaryView.popView.image = UIImage(systemName: "sun.rain")
        
        secondaryView.visibilityView.message1 = "Видимость"
        let visibilityMeters = firstForecast.visibility 
        let visibilityKilometers = Double(visibilityMeters) / 1000.0
        secondaryView.visibilityView.message2 = "\(String(format: "%.1f", visibilityKilometers)) km"
        secondaryView.visibilityView.image = UIImage(systemName: "moon.haze.fill")
        
        secondaryView.windView.message1 = "Скорость ветра"
        secondaryView.windView.message2 = "\(firstForecast.wind.speed) m"
        secondaryView.windView.image = UIImage(systemName: "wind.circle")
        
        let dateString = firstForecast.dt_txt
        if !dateString.isEmpty {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ru_RU")
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            if let date = dateFormatter.date(from: dateString) {
                dateFormatter.dateFormat = "EEEE, dd MMMM"
                var dayOfWeek = dateFormatter.string(from: date)
                dayOfWeek = dayOfWeek.prefix(1).capitalized + dayOfWeek.dropFirst()
                secondaryView.dataLabel.text = "\(dayOfWeek)"
            }
        }
    }

    private func updateWeatherDataArrays(with forecastResponseBody: ForecastResponseBody) {
        for forecastItem in forecastResponseBody.list {
            guard !forecastItem.dt_txt.isEmpty else {
                continue
            }
            
            let dateString = forecastItem.dt_txt
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            if let date = dateFormatter.date(from: dateString) {
                let timedayFormatter = DateFormatter()
                timedayFormatter.locale = Locale(identifier: "ru_RU")
                timedayFormatter.dateFormat = "HH:mm"
                let dayOfWeek = timedayFormatter.string(from: date)
                let temperature = "\(Int(forecastItem.main.temp.rounded()))°"
                let iconImage = UIImage(named: forecastItem.weather.first?.icon ?? "")
                let weatherData = WeatherCellData(date: dayOfWeek, temperature: temperature, iconImage: iconImage)
                self.weatherDataArray.append(weatherData)
                
                if Calendar.current.component(.hour, from: date) == 12 {
                    let timeFormatter = DateFormatter()
                    timeFormatter.locale = Locale(identifier: "ru_RU")
                    timeFormatter.dateFormat = "EEEE"
                    let time = timeFormatter.string(from: date)
                    let capitalizedTime = time.capitalized
                    let temperature = "\(Int(forecastItem.main.temp.rounded()))°"
                    let weatherData = WeatherDayData(date: capitalizedTime, temperature: temperature)
                    self.weatherDayArray.append(weatherData)
                }
            }
        }
    }

    private func updateUI(with forecastResponseBody: ForecastResponseBody) {
        DispatchQueue.main.async {
            self.updatePrimaryView(with: forecastResponseBody)
            self.updateSecondaryView(with: forecastResponseBody)
            self.updateWeatherDataArrays(with: forecastResponseBody)
            
            self.collectionView.reloadData()
            self.tableView.reloadData()
            
            self.updateScrollViewContentSize()
        }
    }

    private func updateScrollViewContentSize() {
        let collectionViewHeight = self.collectionView.contentSize.height
        let tableViewHeight = self.tableView.contentSize.height
        let primaryViewHeight = self.primaryView.frame.height
        let secondaryViewHeight = self.secondaryView.frame.height
        let forecastWeatherHeight = self.forecastWeather.frame.height

        let totalHeight = primaryViewHeight + secondaryViewHeight + collectionViewHeight + tableViewHeight + forecastWeatherHeight + 50
        self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: totalHeight)
    }
}

private extension WeatherViewController {
    func setupLayout() {
        configureScrollView()
        configurePrimaryView()
        configureCollectionViewLayout()
        configureSecondaryView()
        configureForecastLabel()
        configureTableViewLayour()
    }
    func configureForecastLabel() {
        scrollView.addSubview(forecastWeather)
        NSLayoutConstraint.activate([
               forecastWeather.topAnchor.constraint(equalTo: secondaryView.bottomAnchor,constant: 50),
               forecastWeather.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
               forecastWeather.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
               forecastWeather.heightAnchor.constraint(equalToConstant: 50)
           ])
    }
    func configurePrimaryView() {
        scrollView.addSubview(primaryView)
        primaryView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            primaryView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            primaryView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            primaryView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            primaryView.heightAnchor.constraint(equalToConstant: 250),
            primaryView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    func configureScrollView() {
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
    }
    private func configureSecondaryView() {
        scrollView.addSubview(secondaryView)
        secondaryView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondaryView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
            secondaryView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            secondaryView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            secondaryView.heightAnchor.constraint(equalToConstant: 400),
            secondaryView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    private func configureCollectionViewLayout() {
        scrollView.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: primaryView.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            collectionView.heightAnchor.constraint(greaterThanOrEqualToConstant: 120),
            collectionView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    private func configureTableViewLayour() {
        scrollView.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = false
        tableView.allowsSelection = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: forecastWeather.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200),
        ])
    }
}

extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherDataArray.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = 80
        let height: CGFloat = 120
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell",for: indexPath) as? CellHourWeather
            else {
                fatalError("Unable to dequeue Cell")
            }
    let data = weatherDataArray[indexPath.item]
    cell.configure(with: data)
    return cell
    }
}

extension WeatherViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherDayArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        let weather = weatherDayArray[indexPath.row]
        cell.dateLabel.text = "\(weather.date)"
        cell.temperatureLabel.text = "\(weather.temperature)С "
        cell.dateLabel.textColor = UIColor.black
        cell.temperatureLabel.textColor = UIColor.black
        cell.backgroundColor = UIColor.white
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
