//
//  ViewController.swift
//  WeatherInMyCityAlamofire
//
//  Created by Антон Бобрышев on 11.08.2021.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var ImageViewForCity: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    
    var userLocation = CLLocationManager()
    var userCoordinates: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ImageViewForCity.layer.cornerRadius = 10

        setupUserLocation()
        fetchCurrentImage()
    }
    
    private func fetchCurrentImage() {
        
        NetworkManager.shared.fetchCurrentImage(with: { jsonImageResult in
            let imageURL = URL(string: jsonImageResult.urls)
            if let data = try? Data(contentsOf: imageURL!) {
                let currentImage = UIImage(data: data)
                self.ImageViewForCity.image = currentImage
            }
        }
        )}
    
    private func fetchCurrentUserWeather(latitude: Double, longitude: Double) {
        
        NetworkManager.shared.fetchCurrentWeather(latitude: latitude, long: longitude) { [self] jsonWeatherResult in
            self.cityNameLabel.text = jsonWeatherResult.location
            self.tempLabel.text = "\(jsonWeatherResult.tempString)ºC"
            self.weatherImage.image = UIImage(systemName: jsonWeatherResult.systemIconNameString)
        }
    }
}

// MARK: Location Manager

extension WeatherViewController: CLLocationManagerDelegate {
    
    func setupUserLocation() {
        userLocation.delegate = self
        userLocation.requestWhenInUseAuthorization()
        userLocation.startUpdatingLocation()
     }
     
     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty, userCoordinates == nil {
            userCoordinates = locations.last
            userLocation.startUpdatingLocation()
            
            requestWeatherForLocation()
         }
     }
     
     func requestWeatherForLocation() {
        guard let userCoordinates = userCoordinates else {return}
        let longitude = userCoordinates.coordinate.longitude
        let latitude = userCoordinates.coordinate.latitude
        
        fetchCurrentUserWeather(latitude: latitude, longitude: longitude)
     }
}

