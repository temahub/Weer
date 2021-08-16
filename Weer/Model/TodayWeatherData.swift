//
//  TodayWeatherData.swift
//  Weer
//
//  Created by Artyom Jalilov on 16.08.21.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let wind: Wind
    //let rain: Rain
    let sys: Sys
}

struct Main: Codable {
    let temp: Double
    let pressure: Int
    let humidity: Int
}

struct Wind: Codable {
    let speed: Double
    let deg: Double
}

struct Rain: Codable {
    var Oneh: Double
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Sys: Codable {
    let country: String
}
