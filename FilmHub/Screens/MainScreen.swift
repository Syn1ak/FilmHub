//
//  MainScreen.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 16.05.2024.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            
            FilmListView(inProduction: true, userRole: .client)
                .tabItem {
                    Image(systemName: "movieclapper")
                        .resizable()
                        .foregroundStyle(.red)
                        .frame(width: 50, height: 90)
                }
            FilmListView(inProduction: false, userRole: .client)
                .tabItem {
                    Image(systemName: "play.rectangle")
                        .foregroundStyle(.gray)
                }
            TicketListView()
                .tabItem {
                    Image(systemName: "ticket")
                        .foregroundStyle(.gray)
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "person.crop.circle.fill")
                        .foregroundStyle(.gray)
                }
        }
        .tint(Color("BackgroundColor"))
    }
}


