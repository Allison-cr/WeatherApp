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
        label.font = UIFont.systemFont(ofSize: 64, weight: .bold)
        label.textColor = .white
        return label
    }()
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 28)
        label.textColor = .white
        return label
    }()
    let feels_likeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    let cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textColor = .white
        return label
    }()
      
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
           super.init(coder: coder)
           setupLayout()
       }
    
    override func layoutSubviews() {
           super.layoutSubviews()
           applyBottomCornerRadius()
       }
}

private extension WeatherView {
    func setupLayout() {
        setupBackgroundImage()
        setupViews()
    }
    func setupBackgroundImage() {
          let backgroundImage = UIImageView(image: UIImage(named: "backgound_light"))
          backgroundImage.translatesAutoresizingMaskIntoConstraints = false
          backgroundImage.contentMode = .scaleAspectFill
          insertSubview(backgroundImage, at: 0)
          NSLayoutConstraint.activate([
              backgroundImage.topAnchor.constraint(equalTo: topAnchor),
              backgroundImage.leadingAnchor.constraint(equalTo: leadingAnchor),
              backgroundImage.trailingAnchor.constraint(equalTo: trailingAnchor),
              backgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor)
          ])
          applyBottomCornerRadius()
      }
     func applyBottomCornerRadius() {
         let cornerRadius: CGFloat = 35
         let maskPath = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: [.bottomLeft, .bottomRight],
                                     cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
         let shapeLayer = CAShapeLayer()
         shapeLayer.path = maskPath.cgPath
         layer.mask = shapeLayer
     }
    func setupViews() {
         addSubview(cityLabel)
         addSubview(temperatureLabel)
         addSubview(descriptionLabel)
         addSubview(feels_likeLabel)
        
         NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            cityLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            temperatureLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 20),
            temperatureLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            descriptionLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 10),
            descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            feels_likeLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            feels_likeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}

