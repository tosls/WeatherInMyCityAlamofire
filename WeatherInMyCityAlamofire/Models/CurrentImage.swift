//
//  CurrentImage.swift
//  WeatherInMyCityAlamofire
//
//  Created by Антон Бобрышев on 11.08.2021.
//

struct CurrentImage: Decodable {
    let results: [Result]
}

struct Result: Decodable {
    let urls: URLS
}

struct URLS: Decodable {
    let full: String
}
