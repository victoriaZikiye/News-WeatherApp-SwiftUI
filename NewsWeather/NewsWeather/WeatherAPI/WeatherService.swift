//
//  WeatherService.swift
//  NewsWeather
//
//  Created by Victoria Zikiye on 4/10/22.
//

import CoreLocation
import Foundation

public final class WeatherService: NSObject {
    private let locationManager = CLLocationManager()
    private let api_key = "897c2e50871f2dcc4696b9ad45a715e7"
    
    private var completionHandler: ((Weather) -> Void)?
    
    public override init() {
        super.init()
        locationManager.delegate = self
    }
    
    public func loadWeatherData(_ completionHandler: @escaping((Weather) -> Void)) {
        self.completionHandler = completionHandler
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    private func makeDataRequest(forCoordinates coordinates: CLLocationCoordinate2D){
        guard  let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(api_key)&units=metric"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else{ return }
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url){ data, response, error in
            guard error == nil, let data = data else {return}
            if let response = try? JSONDecoder().decode(WeatherAPIResponse.self, from: data){
                self.completionHandler?(Weather(response: response))
            }
        }.resume()
    }
}


extension WeatherService: CLLocationManagerDelegate{
    public func locationManager(
        _  manager: CLLocationManager, didUpdateLocations locations: [CLLocation]
    ){
        guard let location = locations.first else {return}
        makeDataRequest(forCoordinates: location.coordinate)
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error){
        print("An error occured:\(error.localizedDescription)")
    }
}
 

struct APIMain: Decodable {
    let temp: Double
}

struct APIWeather: Decodable {
    let description: String
    let iconName: String
    
    enum CodingKeys: String, CodingKey {
        case  description
        case iconName = "main"
    }
}


