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
    let countryName: String
    let temperature: Double
    let humidity: Int
    let weatherDescription: String
    //let oneh: Double
    let pressure: Int
    let windSpeed: Double
    let windDeg: Double
    
    var fullCityCountryName: String {
        return cityName + ", " + countryName
    }
    
    var temperatureString: String{
        return String(format: "%.1f", temperature) + "°C"
    }
    
    var capitalizeWeatherDescription: String {
        return weatherDescription.capitalizingFirstLetter()
    }
    
    var humidityString: String {
        return String(humidity) + "%"
    }
    
//    var onehString: String {
//        return String(oneh) + " mm"
//    }
    
    var pressureString: String {
        return String(pressure) + " hPa"
    }
    
    var windSpeedString: String {
        return String(windSpeed) + " km/h"
    }
    
    var windDegString: String {
        return windDeg.direction.toString()
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


enum Direction: String, CaseIterable {
    case n, nne, ne, ene, e, ese, se, sse, s, ssw, sw, wsw, w, wnw, nw, nnw
}

extension Direction: CustomStringConvertible  {
    init<D: BinaryFloatingPoint>(_ direction: D) {
        self =  Self.allCases[Int((direction.angle+11.25).truncatingRemainder(dividingBy: 360)/22.5)]
    }
    var description: String { rawValue.uppercased() }
    
    func toString() -> String {
        return description
    }
}

extension BinaryFloatingPoint {
    var angle: Self {
        (truncatingRemainder(dividingBy: 360) + 360)
            .truncatingRemainder(dividingBy: 360)
    }
    var direction: Direction { .init(self) }
}

extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}


