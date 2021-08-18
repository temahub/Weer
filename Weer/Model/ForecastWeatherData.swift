//
//  ForecastWeatherData.swift
//  Weer
//
//  Created by Artyom Jalilov on 17.08.21.
//

import Foundation

struct ForecastWeatherData: Codable {
    let list: [List]
    let city: City
}

struct List: Codable {
    let dt: Int
    let main: Main
    let weather: [Weather]
}

struct City: Codable {
    let name: String
}
