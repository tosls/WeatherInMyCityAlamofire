//
//  Networkmanager.swift
//  WeatherInMyCityAlamofire
//
//  Created by Антон Бобрышев on 11.08.2021.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    //MARK: Fetch User Weather
    
    func fetchCurrentWeather(latitude: Double, long: Double, with complition: @escaping (CurrentUserWeather) -> Void) {
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(long)&appid=\(apiAccessKeyForWeather)&units=metric"
        
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Somthing went wrong in jsonWeatherResult \(error)")
                return
            }
            guard let data = data else {return}
        
          do {
            let jsonWeather = try JSONDecoder().decode(CurrentWeather.self, from: data)
            guard let jsonWeatherResult = CurrentUserWeather(CurrentWeather: jsonWeather) else {return}
            print("TEST")
            DispatchQueue.main.async {
               complition(jsonWeatherResult)
            }
        } catch {
            print("Somthing went wrong in jsonWeather")
        }
        }.resume()
    }
    
    //MARK: Fetch User Image

    func fetchCurrentImage(with complition: @escaping (CurrentUserImage) -> Void) {
        
        let randomPicture = ["cat", "beach", "sun", "rice", "montain", "river", "fish"]
        let index = Int.random(in: 0..<randomPicture.count)
        let picture = randomPicture[index]
        
        let urlString = "https://api.unsplash.com/search/photos?page=1&per_page=1&query=\(picture)&client_id=3yNajiW5PRfO9IVeay-2unXNA226l5Bw-WOBB0FwtHg"
        
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Somthing went wrong in jsonImageResult \(error)")
                return
                }
            guard let data = data else {return}
            
            do {
                let jsonResult = try JSONDecoder().decode(CurrentImage.self, from: data)
                guard let jsonImageResult = CurrentUserImage(CurrentImage: jsonResult) else {return}
                DispatchQueue.main.async {
                    complition(jsonImageResult)
                }
            } catch {
                print("Somthing went wrong in jsonImageResult")
            }
        }.resume()
    }
}

