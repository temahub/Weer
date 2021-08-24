//
//  ForecastViewModel.swift
//  Weer
//
//  Created by Artyom Jalilov on 24.08.21.
//

import Foundation
import CoreLocation

class ForecastViewModel: NSObject, ForecastWeatherManagerDelegate, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    var forecastManager = ForecastWeatherManager()
    
    private(set) var forecastSortedModel: [ForecastSortedModel]! {
        didSet{
            self.bindForecastSortedModelToController()
        }
    }
    
    var bindForecastSortedModelToController: (() -> ()) = {}
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        forecastManager.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let location = locations.first {
                locationManager.stopUpdatingLocation()
                let lat = location.coordinate.latitude
                let lon = location.coordinate.longitude
                
                forecastManager.fetchWeather(lat: lat, lon: lon)
            }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func didUpdateForecast(forecast: [ForecastSortedModel]) {
        self.forecastSortedModel = forecast
    }
}
