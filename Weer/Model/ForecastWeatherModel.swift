//
//  ForecastWeatherModel.swift
//  Weer
//
//  Created by Artyom Jalilov on 17.08.21.
//

import Foundation

struct ForecastModel {
    let cityName: String
    let day: String
    let time: String
    let temperatureString: String
    let capitalizeWeatherDescription: String
    let conditionName: String
}

struct ForecastSortedModel {
    let day: String
    let forecastModel: [ForecastModel]
}

class ForecastWeatherModel {
    
    static func transformListToForecastModel(city: City, list: [List]) -> [ForecastModel] {
        var forecastModel = [ForecastModel]()
        for eachL in list {
            forecastModel.append(ForecastModel(cityName: city.name,
                                               day: day(dt: eachL.dt),
                                               time: time(dt: eachL.dt),
                                               temperatureString: temperatureString(temperature: eachL.main.temp),
                                               capitalizeWeatherDescription: capitalizeWeatherDescription(weatherDescription: eachL.weather[0].description),
                                               conditionName: conditionName(conditionId: eachL.weather[0].id)))
        }
        return forecastModel
    }
    
    static func transformForecastModelToForecastSortedModel(fModel: [ForecastModel]) -> [ForecastSortedModel] {
        
        var forecastSortedModel = [ForecastSortedModel]()
        
        var forecastDaySections = [String?]()
        for fwd in fModel {
            forecastDaySections.append(fwd.day)
        }
        forecastDaySections = forecastDaySections.unique()
        
        for eachDay in forecastDaySections {
            forecastSortedModel.append(ForecastSortedModel(day: eachDay!,
                                                           forecastModel: collectForecastModels(day: eachDay!)))
        }        
        
        func collectForecastModels(day: String) -> [ForecastModel] {
            var fCollectModel = [ForecastModel]()
            for eachFM in fModel {
                if eachFM.day == day {
                    fCollectModel.append(eachFM)
                }
            }
            
            return fCollectModel
        }
        
        return forecastSortedModel
    }
    
    static func day(dt: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(dt))
        let dayOfWeek = DateFormatter().weekdaySymbols[Calendar.current.component(.weekday, from: date) - 1]
        
        return dayOfWeek
    }
    
    static func time(dt: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(dt))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let time = dateFormatter.string(from: date)
        
        return time
    }
    
    static func temperatureString(temperature: Double) -> String{
        return String(format: "%.1f", temperature) + "°"
    }
    
    static func capitalizeWeatherDescription(weatherDescription: String) -> String {
        return weatherDescription.capitalizingFirstLetter()
    }
    
    static func conditionName(conditionId: Int) -> String {
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

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: [Iterator.Element: Bool] = [:]
        return self.filter { seen.updateValue(true, forKey: $0) == nil }
    }
}
