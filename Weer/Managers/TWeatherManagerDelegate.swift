//
//  TWeatherManagerDelegate.swift
//  Weer
//
//  Created by Artyom Jalilov on 16.08.21.
//

import Foundation

protocol TWeatherManagerDelegate {
    func didUpdateWeather(weather: TodayWeatherModel)
}
