//
//  NewsWeatherApp.swift
//  NewsWeather
//
//  Created by Victoria Zikiye on 4/10/22.
//



import SwiftUI

@main
struct NewsWeatherApp: App {
    @StateObject var articleBookmarkVM = ArticleBookmarkViewModel.shared

    var body: some Scene {
        
        WindowGroup {
                ContentView()
                .environmentObject(articleBookmarkVM)
        }
    }
}
