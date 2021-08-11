//
//  Networkmanager.swift
//  WeatherInMyCityAlamofire
//
//  Created by Антон Бобрышев on 11.08.2021.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    //MARK: Fetch User Weather
    
    func fetchCurrentWeather(latitude: Double, long: Double, with complition: @escaping (CurrentUserWeather) -> Void) {
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(long)&appid=\(apiAccessKeyForWeather)&units=metric"
        
        AF.request(urlString)
            .validate()
            .responseDecodable(of: CurrentWeather.self) { response in
                
                switch response.result {
                case .success(let value):
                    guard let jsonWeatherResult = CurrentUserWeather(CurrentWeather: value) else {return}
                    DispatchQueue.main.async {
                            complition(jsonWeatherResult)
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }

    //MARK: Fetch User Image

    func fetchCurrentImage(with complition: @escaping (CurrentUserImage) -> Void) {
        
        let locationName = ["London", "Moscow", "Prague", "Berlin", "Tokyo", "Pekin", "Paris"]
                let index = Int.random(in: 0..<locationName.count)
                let picture = locationName[index]
        
        let urlString = "https://api.unsplash.com/search/photos?page=1&per_page=1&query=\(picture)&client_id=3yNajiW5PRfO9IVeay-2unXNA226l5Bw-WOBB0FwtHg"
        
        AF.request(urlString)
            .validate()
            .responseDecodable(of: CurrentImage.self) { response in
                
                switch response.result {
                case .success(let value):
                    guard let jsonImageResult = CurrentUserImage(CurrentImage: value) else {return}
                    DispatchQueue.main.async {
                            complition(jsonImageResult)
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
}

