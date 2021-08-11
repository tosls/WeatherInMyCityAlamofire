//
//  CurrentUserWeather.swift
//  WeatherInMyCityAlamofire
//
//  Created by Антон Бобрышев on 11.08.2021.
//

import Foundation

struct CurrentUserWeather {
    
    let location: String
    let temp: Double
    var tempString: String {
        return String(format: "%.0f", temp)
    }
    let conditionCode: Int
    
    var systemIconNameString: String {
        switch conditionCode {
        case 200...232:
            return "cloud.heavyrain"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud"
        default:
            return "moon"
        }
    }
    
    init?(CurrentWeather: CurrentWeather) {
        location = CurrentWeather.name
        temp = CurrentWeather.main.temp
        conditionCode = CurrentWeather.weather.first!.id
    }
}

