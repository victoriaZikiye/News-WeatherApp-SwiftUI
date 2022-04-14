//
//  WeatherTabView.swift
//  NewsWeather
//
//  Created by Victoria Zikiye on 4/10/22.
//

import SwiftUI

struct WeatherTabView: View{
    
    @ObservedObject var viewModel: WeatherViewModel
    var body: some View{
        VStack {
            Text(viewModel.cityName)
                .font(.largeTitle)
                .padding()
            Text(viewModel.temperature)
                .font(.system(size:70))
                .bold()
            Text(viewModel.weatherIcon)
                .font(.largeTitle)
                .padding()
            Text(viewModel.weatherDescription)
        }.onAppear(perform: viewModel.refresh)
    }
}


struct WeatherTabView_Previews: PreviewProvider{
    static var previews: some View {
        WeatherTabView(viewModel: WeatherViewModel(weatherService: WeatherService()))
    }
}

