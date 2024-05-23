//
//  FilmHubApp.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 13.05.2024.
//

import SwiftUI

@main
struct FilmHubApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .onAppear{
                    let tabBarAppearance = UITabBarAppearance()
                    tabBarAppearance.backgroundColor = UIColor(named: "TabbarColor")
                    UITabBar.appearance().standardAppearance = tabBarAppearance
                }
        }
    }
}
