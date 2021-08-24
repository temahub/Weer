//
//  ViewController.swift
//  Weer
//
//  Created by Artyom Jalilov on 16.08.21.
//

import UIKit
import CoreLocation
import SnapKit

class TodayViewController: UIViewController {

    @IBOutlet weak var todayWeatherImage: UIImageView!
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var separatorTempAndDescr: UILabel!
    @IBOutlet weak var todayTemperatureLabel: UILabel!
    @IBOutlet weak var todayWeatherDescriptionLabel: UILabel!
    @IBOutlet weak var separatorBeforWeatherIns: UILabel!
    @IBOutlet weak var today1hImage: UIImageView!
    @IBOutlet weak var todayHumidityImage: UIImageView!
    @IBOutlet weak var todayPressureImage: UIImageView!
    @IBOutlet weak var todayHumidityLabel: UILabel!
    @IBOutlet weak var today1hLabel: UILabel!
    @IBOutlet weak var todayPressureLabel: UILabel!
    
    @IBOutlet weak var todayWindSpeedImage: UIImageView!
    @IBOutlet weak var todayWindDegImage: UIImageView!
    
    @IBOutlet weak var todayWindSpeedLabel: UILabel!
    @IBOutlet weak var todayWindDegLabel: UILabel!
    @IBOutlet weak var separatorBeforShareButton: UILabel!
    @IBOutlet weak var todayShareButton: UIButton!
    
    private var todayViewModel: TodayViewModel!
    
    var weatherAsString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Today"
        setupView()
        callTodayViewModelForUIUpdate()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Reload", style: .done, target: self, action: #selector(didTapSave))
      }
    
    @objc func didTapSave() {
        callTodayViewModelForUIUpdate()
    }

    @IBAction func didTapShare(_ sender: UIButton) {
        if let object = weatherAsString, weatherAsString != nil {
          let objectsToShare = [object]
          let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
          self.present(activityVC, animated: true, completion: nil)
        }
    }
    
    func callTodayViewModelForUIUpdate() {
        self.todayViewModel = TodayViewModel()
        self.todayViewModel.bindTodayWeatherModelToController = {
            DispatchQueue.main.async {
                self.todayTemperatureLabel.text = self.todayViewModel.todayWeatherModel.temperatureString
                self.cityNameLabel.text = self.todayViewModel.todayWeatherModel.fullCityCountryName
                self.todayWeatherImage.image = UIImage(systemName: self.todayViewModel.todayWeatherModel.conditionName)
                self.todayWeatherDescriptionLabel.text = self.todayViewModel.todayWeatherModel.capitalizeWeatherDescription
                self.todayHumidityLabel.text = self.todayViewModel.todayWeatherModel.humidityString
                self.today1hLabel.text = self.todayViewModel.todayWeatherModel._1hString
                self.todayPressureLabel.text = self.todayViewModel.todayWeatherModel.pressureString
                self.todayWindSpeedLabel.text = self.todayViewModel.todayWeatherModel.windSpeedString
                self.todayWindDegLabel.text = self.todayViewModel.todayWeatherModel.windDegString
                self.weatherAsString = self.todayViewModel.todayWeatherModel.toString()
            }
        }
    }
}

extension TodayViewController{
    func setupView() -> Void {
        self.view.addSubview(todayWeatherImage)
        todayWeatherImage.translatesAutoresizingMaskIntoConstraints = false
        todayWeatherImage.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(80)
            make.centerX.equalTo(self.view)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).inset(40)
        }
        
        self.view.addSubview(cityNameLabel)
        cityNameLabel.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.view)
            make.top.equalTo(todayWeatherImage.snp.bottom).offset(15)
        }
        
        self.view.addSubview(separatorTempAndDescr)
        separatorTempAndDescr.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.view)
            make.top.equalTo(cityNameLabel).offset(70)
        }
        
        self.view.addSubview(todayWeatherDescriptionLabel)
        todayWeatherDescriptionLabel.snp.makeConstraints { (make) -> Void in
            make.height.lessThanOrEqualTo(30)
            make.centerY.equalTo(separatorTempAndDescr)
            make.left.equalTo(separatorTempAndDescr).offset(20)
        }
        
        self.view.addSubview(todayTemperatureLabel)
        todayTemperatureLabel.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(separatorTempAndDescr)
            make.right.greaterThanOrEqualTo(separatorTempAndDescr).inset(20)
            make.left.greaterThanOrEqualTo(view.safeAreaLayoutGuide.snp.leftMargin).inset(20)
        }
        
        self.view.addSubview(separatorBeforWeatherIns)
        separatorBeforWeatherIns.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(todayShareButton).inset(250)
        }
        
        self.view.addSubview(today1hImage)
        today1hImage.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.view)
            make.top.equalTo(separatorBeforWeatherIns).offset(40)
        }
        
        self.view.addSubview(todayHumidityImage)
        todayHumidityImage.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(today1hImage)
            make.right.equalTo(today1hImage.snp.left).offset(-80)
        }
        
        self.view.addSubview(todayPressureImage)
        todayPressureImage.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(today1hImage)
            make.left.equalTo(today1hImage.snp.right).offset(80)
        }
        
        self.view.addSubview(today1hLabel)
        today1hLabel.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.view)
            make.top.equalTo(today1hImage.snp.bottom).offset(5)
        }
        
        self.view.addSubview(todayHumidityLabel)
        todayHumidityLabel.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(today1hLabel)
            make.centerX.equalTo(todayHumidityImage)
            make.top.equalTo(todayHumidityImage.snp.bottom).offset(5)
        }
        
        self.view.addSubview(todayPressureLabel)
        todayPressureLabel.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(today1hLabel)
            make.centerX.equalTo(todayPressureImage)
            make.top.equalTo(todayPressureImage.snp.bottom).offset(5)
        }
        
        self.view.addSubview(todayWindSpeedImage)
        todayWindSpeedImage.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.view).offset(-70)
            make.top.equalTo(today1hLabel.snp.bottom).offset(30)
        }
        
        self.view.addSubview(todayWindDegImage)
        todayWindDegImage.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(todayWindSpeedImage)
            make.centerX.equalTo(self.view).offset(70)
        }
        
        self.view.addSubview(todayWindSpeedLabel)
        todayWindSpeedLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(todayWindSpeedImage.snp.bottom).offset(5)
            make.centerX.equalTo(todayWindSpeedImage)
        }
        
        self.view.addSubview(todayWindDegLabel)
        todayWindDegLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(todayWindDegImage.snp.bottom).offset(5)
            make.centerX.equalTo(todayWindDegImage)
        }
        
        self.view.addSubview(separatorBeforShareButton)
        separatorBeforShareButton.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.view)
            make.top.equalTo(todayWindDegLabel).offset(25)
        }
        
        self.view.addSubview(todayShareButton)
        todayShareButton.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin).inset(40)
        }
    }
}

