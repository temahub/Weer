//
//  ViewController.swift
//  Weer
//
//  Created by Artyom Jalilov on 16.08.21.
//

import UIKit

class TodayViewController: UIViewController {

    @IBOutlet weak var TodayWeatherImage: UIImageView!
    
    @IBOutlet weak var CityNameLabel: UILabel!
    @IBOutlet weak var TodayTemperatureLabel: UILabel!
    @IBOutlet weak var TodayWeatherDescriptionLabel: UILabel!
    @IBOutlet weak var TodayHumidityLabel: UILabel!
    @IBOutlet weak var Today1hLabel: UILabel!
    @IBOutlet weak var TodayPressureLabel: UILabel!
    @IBOutlet weak var TodayWindSpeedLabel: UILabel!
    @IBOutlet weak var TodayWindDegLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapShare(_ sender: UIButton) {
    }
    
}

