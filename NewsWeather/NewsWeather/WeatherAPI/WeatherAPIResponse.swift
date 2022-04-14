//
//  WeatherApiResponse.swift
//  NewsWeather
//
//  Created by Victoria Zikiye on 4/10/22.
//

import Foundation

struct WeatherAPIResponse: Decodable{
    
    
    let name : String
    let main: APIMain
    let weather: [APIWeather]
    

}
