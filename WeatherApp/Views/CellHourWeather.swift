//
//  CellHourWeather.swift
//  WeatherApp
//
//  Created by Alexander Suprun on 25.03.2024.
//

import Foundation
import UIKit

class CellHourWeather: UICollectionViewCell {
    static let reuseIdentifier = "Cell"
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let iconImageView: UIImageView = {
         let imageView = UIImageView()
         imageView.translatesAutoresizingMaskIntoConstraints = false
         return imageView
     }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 8
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(temperatureLabel)
        contentView.addSubview(iconImageView)
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            dateLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            iconImageView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor),
            iconImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 48),
            iconImageView.heightAnchor.constraint(equalToConstant: 48),
            
            temperatureLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor),
            temperatureLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
    }
    
    func configure(with data: WeatherCellData) {
        dateLabel.text = data.date
        temperatureLabel.text = data.temperature
        iconImageView.image = data.iconImage
    }
}
