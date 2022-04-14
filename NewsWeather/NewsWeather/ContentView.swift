//
//  ContentView.swift
//  NewsWeather
//
//  Created by Victoria Zikiye on 4/10/22.
//


import SwiftUI

struct ContentView: View {
    
    
    
    var body: some View {
        TabView{
            NewsTabView()
                .tabItem {
                    Label("News",systemImage: "newspaper")
                }
            
            SearchTabView()
                .tabItem {
                    Label("Search",systemImage: "magnifyingglass")
                }
            
            BookmarkTabView()
                .tabItem {
                    Label("Saved",systemImage: "bookmark")
                }
            let weatherService = WeatherService()
            let viewModel = WeatherViewModel(weatherService: weatherService)
            WeatherTabView(viewModel: viewModel)
                .tabItem{
                    Label("Weather", systemImage: "cloud")
                }

            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
