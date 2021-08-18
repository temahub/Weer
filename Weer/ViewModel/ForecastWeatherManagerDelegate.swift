//
//  ForecastWeatherManagerDelegate.swift
//  Weer
//
//  Created by Artyom Jalilov on 17.08.21.
//

import Foundation

protocol ForecastWeatherManagerDelegate {
    func didUpdateForecast(forecast: [ForecastModel])
}
