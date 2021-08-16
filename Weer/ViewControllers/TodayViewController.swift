//
//  ViewController.swift
//  Weer
//
//  Created by Artyom Jalilov on 16.08.21.
//

import UIKit
import CoreLocation

class TodayViewController: UIViewController {

    @IBOutlet weak var todayWeatherImage: UIImageView!
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var todayTemperatureLabel: UILabel!
    @IBOutlet weak var todayWeatherDescriptionLabel: UILabel!
    @IBOutlet weak var todayHumidityLabel: UILabel!
    @IBOutlet weak var today1hLabel: UILabel!
    @IBOutlet weak var todayPressureLabel: UILabel!
    @IBOutlet weak var todayWindSpeedLabel: UILabel!
    @IBOutlet weak var todayWindDegLabel: UILabel!
    
    let locationManager = CLLocationManager()
    var weatherManager = TWeatherManager()
    
    var weatherAsString: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherManager.delegate = self
    }

    @IBAction func didTapShare(_ sender: UIButton) {
        if let object = weatherAsString, weatherAsString != nil {
          let objectsToShare = [object]
          let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
          self.present(activityVC, animated: true, completion: nil)
        }
    }
}

extension TodayViewController: TWeatherManagerDelegate{
    func didUpdateWeather(weather: TodayWeatherModel) {
        DispatchQueue.main.async {
            self.todayTemperatureLabel.text = weather.temperatureString
            self.cityNameLabel.text = weather.fullCityCountryName
            self.todayWeatherImage.image = UIImage(systemName: weather.conditionName)
            self.todayWeatherDescriptionLabel.text = weather.capitalizeWeatherDescription
            self.todayHumidityLabel.text = weather.humidityString
            self.today1hLabel.text = weather._1hString
            self.todayPressureLabel.text = weather.pressureString
            self.todayWindSpeedLabel.text = weather.windSpeedString
            self.todayWindDegLabel.text = weather.windDegString
            self.weatherAsString = weather.toString()
        }
    }
}

extension TodayViewController: CLLocationManagerDelegate{
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
}

