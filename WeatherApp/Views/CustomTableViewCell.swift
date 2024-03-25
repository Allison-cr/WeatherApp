//
//  CustomTableViewCell.swift
//  WeatherApp
//
//  Created by Alexander Suprun on 25.03.2024.
//
import Foundation
import UIKit

class CustomTableViewCell: UITableViewCell {
    let dateLabel = UILabel()
    let temperatureLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        dateLabel.textAlignment = .left
        contentView.addSubview(dateLabel)
        
        temperatureLabel.textAlignment = .right
        contentView.addSubview(temperatureLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        temperatureLabel.frame = CGRect(x: contentView.frame.width - 130, y: 0, width: 100, height: contentView.frame.height)
        dateLabel.frame = CGRect(x: 30, y: 0, width: contentView.frame.width - 100, height: contentView.frame.height)
    }
}
