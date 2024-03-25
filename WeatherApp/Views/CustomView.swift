//
//  testView.swift
//  WeatherApp
//
//  Created by Alexander Suprun on 24.03.2024.
//

import Foundation
import UIKit

class CustomView: UIView {
    
    private let title : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    } ()
    
    private let message : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        return label
    } ()
    
    private let imageView: UIImageView = {
         let imageView = UIImageView()
         imageView.translatesAutoresizingMaskIntoConstraints = false
         imageView.contentMode = .scaleAspectFit
         return imageView
     }()
    
    var message1: String = "" {
        didSet {
            title.text = message1
        }
    }
    
    var message2: String = "" {
        didSet {
            message.text = message2
        }
    }
    
    var image: UIImage? {
          didSet {
              imageView.image = image
          }
      }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addSubview(title)
        addSubview(message)

        title.translatesAutoresizingMaskIntoConstraints = false
        message.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 32),
            imageView.heightAnchor.constraint(equalToConstant: 32),
            
            title.topAnchor.constraint(equalTo: topAnchor),
            title.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            
            message.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            message.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5),
        ])
    }
    
    convenience init(message1: String?, message2: String?, image: UIImage? = nil) {
        self.init(frame: .zero)
        self.message1 = message1 ?? ""
        self.message2 = message2 ?? ""
        self.image = image
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
