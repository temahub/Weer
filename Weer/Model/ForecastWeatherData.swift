//
//  ForecastWeatherData.swift
//  Weer
//
//  Created by Artyom Jalilov on 17.08.21.
//

import Foundation

struct ForecastWeatherData: Codable {
    let list: [List]
}

struct List: Codable {
    let dt: Int
    let main: Main
    let weather: [Weather]
}

