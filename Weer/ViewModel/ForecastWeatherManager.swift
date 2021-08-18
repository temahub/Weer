//
//  ForecastWeatherManager.swift
//  Weer
//
//  Created by Artyom Jalilov on 17.08.21.
//

import Foundation

struct ForecastWeatherManager{
    let weatherURL = "https://api.openweathermap.org/data/2.5/forecast?&units=metric&appid=8c148010a5b996c78005a9dd3bac88a0"
    
    var delegate: ForecastWeatherManagerDelegate?
    
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
                    if let forecast = self.parseJson(weatherData: safeData){
                        delegate?.didUpdateForecast(forecast: forecast)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJson(weatherData: Data) -> [ForecastSortedModel]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ForecastWeatherData.self, from: weatherData)
            let forecast = ForecastWeatherModel.transformListToForecastModel(city: decodedData.city, list: decodedData.list)
            let sortedForecast = ForecastWeatherModel.transformForecastModelToForecastSortedModel(fModel: forecast)
            
            return sortedForecast
        } catch{
            print(error)
            return nil
        }
    }
}
