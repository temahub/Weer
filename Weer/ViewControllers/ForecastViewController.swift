//
//  ForecastViewController.swift
//  Weer
//
//  Created by Artyom Jalilov on 16.08.21.
//

import UIKit
import CoreLocation

class ForecastViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var forecastTableView: UITableView!
    
    let locationManager = CLLocationManager()
    var forecastManager = ForecastWeatherManager()
    
    var forecastModelData = [ForecastModel?]()
    var forecastSortedModel = [ForecastSortedModel?]()

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        forecastManager.delegate = self
        let nib = UINib(nibName: "ForecastTableViewCell", bundle: nil)
        forecastTableView.register(nib, forCellReuseIdentifier: "ForecastTableViewCell")
        forecastTableView.delegate = self
        forecastTableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        forecastSortedModel.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastSortedModel[section]?.forecastModel.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return forecastSortedModel[section]?.day
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = forecastTableView.dequeueReusableCell(withIdentifier: "ForecastTableViewCell",
                                                         for: indexPath) as! ForecastTableViewCell
        
        guard let temp = forecastSortedModel[indexPath.section]?.forecastModel[indexPath.row].temperatureString else {
            return cell
        }
        cell.temperatureLabel.text = temp
        
        guard let time = forecastSortedModel[indexPath.section]?.forecastModel[indexPath.row].time else {
            return cell
        }
        cell.timeLabel.text = time
        
        guard let weatherDescription = forecastSortedModel[indexPath.section]?.forecastModel[indexPath.row].capitalizeWeatherDescription else {
            return cell
        }
        cell.weatherDescriptionLabel.text = weatherDescription
        
        guard let conditionName = forecastSortedModel[indexPath.section]?.forecastModel[indexPath.row].conditionName else {
            return cell
        }
        cell.weatherImage.image = UIImage(systemName: conditionName)
        
        return cell
    }
}

extension ForecastViewController: ForecastWeatherManagerDelegate {
    func didUpdateForecast(forecast: [ForecastSortedModel]) {
        DispatchQueue.main.async {
            self.forecastSortedModel = forecast
            self.title = forecast[0].forecastModel[0].cityName
                        
            self.forecastTableView.reloadData()
        }
    }
}


extension ForecastViewController: CLLocationManagerDelegate{
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
}

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: [Iterator.Element: Bool] = [:]
        return self.filter { seen.updateValue(true, forKey: $0) == nil }
    }
}


