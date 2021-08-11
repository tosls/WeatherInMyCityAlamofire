//
//  CurrentUserImage.swift
//  WeatherInMyCityAlamofire
//
//  Created by Антон Бобрышев on 11.08.2021.
//

import Foundation

struct CurrentUserImage {
    
    var results: [Result]
    var urls: String

    init?(CurrentImage: CurrentImage) {
        results = CurrentImage.results
        urls = CurrentImage.results.first!.urls.full
    }
}
