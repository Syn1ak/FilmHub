//
//  MainScreen.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 16.05.2024.
//

import SwiftUI

struct MainView: View {
    @State var isTabViewPresent: Bool = true
    
    var body: some View {
        TabView {
            FilmListView(inProduction: true, userRole: .client)
                .tabItem {
                    Image(systemName: "movieclapper")
                }
            FilmListView(inProduction: false, userRole: .client)
                .tabItem {
                    Image(systemName: "play.rectangle")
                }
            TicketListView()
                .tabItem {
                    Image(systemName: "ticket")
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "person.crop.circle.fill")
                        
                }
        }
        .tint(Color("BackgroundColor"))
        
    }
}


