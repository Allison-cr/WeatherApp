//
//  CurrentWeatherView.swift
//  WeatherApp
//
//  Created by Alexander Suprun on 20.03.2024.
//

import UIKit

final class WeatherView: UIView {
    
    let temperatureLabel: UILabel = {
           let label = UILabel()
           label.translatesAutoresizingMaskIntoConstraints = false
           label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
           label.textColor = .white
           return label
       }()
       
       let descriptionLabel: UILabel = {
           let label = UILabel()
           label.translatesAutoresizingMaskIntoConstraints = false
           label.font = UIFont.systemFont(ofSize: 16)
           label.textColor = .darkGray
           return label
       }()
        let feels_likeLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = .darkGray
            return label
        }()
        let temp_minLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = .darkGray
            return label
        }()
        let temp_maxLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = .darkGray
            return label
        }()
        let humidityLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = .darkGray
            return label
        }()
        let pressureabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = .darkGray
            return label
        }()
        let dataLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = .darkGray
            return label
        }()
        let cityLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = .darkGray
            return label
        }()
        
        



    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .orange
        translatesAutoresizingMaskIntoConstraints = false
        setupViews()

    }
    
    required init?(coder: NSCoder) {
           super.init(coder: coder)
           setupViews()
       }
    
    private func setupViews() {
            addSubview(temperatureLabel)
            addSubview(descriptionLabel)
            addSubview(feels_likeLabel)
            addSubview(temp_minLabel)
            addSubview(temp_maxLabel)
            addSubview(humidityLabel)
            addSubview(pressureabel)
            addSubview(dataLabel)
            addSubview(cityLabel)

           NSLayoutConstraint.activate([
               temperatureLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
               temperatureLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
               
               descriptionLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 10),
               descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
               
               feels_likeLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
               feels_likeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
               
               temp_minLabel.topAnchor.constraint(equalTo: feels_likeLabel.bottomAnchor, constant: 10),
               temp_minLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
               
               temp_maxLabel.topAnchor.constraint(equalTo: temp_minLabel.bottomAnchor, constant: 10),
               temp_maxLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
               
               humidityLabel.topAnchor.constraint(equalTo: temp_maxLabel.bottomAnchor, constant: 10),
               humidityLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
               
               pressureabel.topAnchor.constraint(equalTo: humidityLabel.bottomAnchor, constant: 10),
               pressureabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
               
               dataLabel.topAnchor.constraint(equalTo: pressureabel.bottomAnchor, constant: 10),
               dataLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
               
               cityLabel.topAnchor.constraint(equalTo: dataLabel.bottomAnchor, constant: 10),
               cityLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            ])
       }
}
