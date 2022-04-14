//
//  Model.swift
//  NewsWeather
//
//  Created by Victoria Zikiye on 4/10/22.
//


import Foundation

public struct Weather{
    let city: String
    let temperature: String
    let description: String
    let iconName: String
    
    init(response: WeatherAPIResponse) {
        city = response.name
        temperature = "\(Int(response.main.temp))"
        description = response.weather.first?.iconName ?? ""
        iconName = response.weather.first?.iconName ?? ""
    }
}

