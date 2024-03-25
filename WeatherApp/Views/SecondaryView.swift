//
//  SecondaryView.swift
//  WeatherApp
//
//  Created by Alexander Suprun on 23.03.2024.
//
import Foundation
import UIKit
final class SecondaryWeatherView: UIView {
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 60
        return stackView
    }()
    let dataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    let pressureView = CustomView()
    let tempminView = CustomView()
    let tempmaxView = CustomView()
    let humidityView = CustomView()
    let windView = CustomView()
    let popView = CustomView()
    let visibilityView = CustomView()
    
    
    func setupViews() {
        addSubview(dataLabel)
        addSubview(stackView)
        stackView.addArrangedSubview(pressureView)
        stackView.addArrangedSubview(humidityView)
        stackView.addArrangedSubview(windView)
        stackView.addArrangedSubview(popView)
        stackView.addArrangedSubview(visibilityView)
        stackView.addArrangedSubview(tempminView)
        stackView.addArrangedSubview(tempmaxView)
        
        NSLayoutConstraint.activate([
            dataLabel.topAnchor.constraint(equalTo: topAnchor),
            dataLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),

            stackView.topAnchor.constraint(equalTo: dataLabel.bottomAnchor,constant: 20),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
        ])
    }
}
