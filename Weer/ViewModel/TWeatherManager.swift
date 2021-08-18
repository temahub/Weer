//
//  TWeatherManager.swift
//  Weer
//
//  Created by Artyom Jalilov on 16.08.21.
//

import Foundation

struct TWeatherManager{
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&units=metric&appid=8c148010a5b996c78005a9dd3bac88a0"
    
    var delegate: TWeatherManagerDelegate?
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func fetchWeather(lat: Double, lon: Double) {
        let urlString = "\(weatherURL)&lat=\(lat)&lon=\(lon)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String){
        if let url = URL(string: urlString){
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    print(error!)
                    return
                }
                if let safeData = data{
                    if let weather = self.parseJson(weatherData: safeData){
                        delegate?.didUpdateWeather(weather: weather)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJson(weatherData: Data) -> TodayWeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let weather = TodayWeatherModel(conditionId: decodedData.weather[0].id,
                                            cityName: decodedData.name,
                                            countryName: decodedData.sys.country,
                                            temperature: decodedData.main.temp,
                                            humidity: decodedData.main.humidity,
                                            weatherDescription: decodedData.weather[0].description,
                                            _1h: decodedData.rain?._1h ?? 0.0,
                                            pressure: decodedData.main.pressure,
                                            windSpeed: decodedData.wind.speed,
                                            windDeg: decodedData.wind.deg)
            
            return weather
        } catch{
            print(error)
            return nil
        }
    }
}

