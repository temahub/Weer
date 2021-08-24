//
//  TodayViewModel.swift
//  Weer
//
//  Created by Artyom Jalilov on 24.08.21.
//

import Foundation
import CoreLocation

class TodayViewModel: NSObject, TWeatherManagerDelegate, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    var weatherManager = TWeatherManager()
    
    private(set) var todayWeatherModel: TodayWeatherModel! {
        didSet{
            self.bindTodayWeatherModelToController()
        }
    }
    
    var bindTodayWeatherModelToController: (() -> ()) = {}
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherManager.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let location = locations.first {
                locationManager.stopUpdatingLocation()
                let lat = location.coordinate.latitude
                let lon = location.coordinate.longitude
                
                weatherManager.fetchWeather(lat: lat, lon: lon)
            }
        }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func didUpdateWeather(weather: TodayWeatherModel) {
        self.todayWeatherModel = weather
    }
}


