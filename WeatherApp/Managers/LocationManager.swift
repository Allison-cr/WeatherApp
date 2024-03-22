//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Alexander Suprun on 20.03.2024.
//

import Foundation
import CoreLocation

final class LocationManager: NSObject, CLLocationManagerDelegate {
   
    private let manager = CLLocationManager()
    
    static let shared = LocationManager()
    
    private var locationFetchCompletion: ((Result<CLLocation, Error>) -> Void)?
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
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
}
