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
    
    private var forecastViewModel: ForecastViewModel!
    var forecastSortedModel = [ForecastSortedModel?]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "ForecastTableViewCell", bundle: nil)
        forecastTableView.register(nib, forCellReuseIdentifier: "ForecastTableViewCell")
        forecastTableView.delegate = self
        forecastTableView.dataSource = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Reload", style: .done, target: self, action: #selector(didTapSave))
        
        callForecastViewModelForUIUpdate()
    }
    
    @objc func didTapSave() {
        callForecastViewModelForUIUpdate()
    }
    
    func callForecastViewModelForUIUpdate() {
        if !Reachability.isConnectedToNetwork() {
            self.alert(title: "Internet unreachable", message: "Please ensure you have internet connection")
            return
        }
        let loader = self.loader()
        self.forecastViewModel = ForecastViewModel()
        self.forecastViewModel.bindForecastSortedModelToController = {
            DispatchQueue.main.async {
                self.forecastSortedModel = self.forecastViewModel.forecastSortedModel
                self.title = self.forecastSortedModel[0]?.forecastModel[0].cityName
                self.forecastTableView.reloadData()
                
                self.stopLoader(loader: loader)
            }
        }
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

