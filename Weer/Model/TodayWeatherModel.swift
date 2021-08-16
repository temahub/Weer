//
//  WeatherModel.swift
//  Weer
//
//  Created by Artyom Jalilov on 16.08.21.
//

import Foundation

struct TodayWeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let humidity: Int
    let weatherDescription: String
    let oneh: Double
    let pressure: Int
    let windSpeed: Double
    let windDeg: Double
    
    
    
    var temperatureString: String{
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        if conditionId >= 200 && conditionId < 300 {
            return "cloud.bolt.rain"
        }else if conditionId >= 300 && conditionId < 500 {
            return "cloud.drizzle"
        }else if conditionId >= 500 && conditionId < 600 {
            return "cloud.rain"
        }else if conditionId >= 600 && conditionId < 700 {
            return "cloud.snow"
        }else if conditionId >= 700 && conditionId < 800 {
            return "sun.haze"
        }else if conditionId == 800 {
            return "sun.max"
        }else {
            return "cloud"
        }
    }
}
