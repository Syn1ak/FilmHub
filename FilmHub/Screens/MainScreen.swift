//
//  MainScreen.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 16.05.2024.
//

import SwiftUI

struct MainView: View {
    @ObservedObject private var authService = AuthorizationService()
    
    var body: some View {
        VStack {
            if authService.isAuthorized {
                TabView {
                    FilmListView(inProduction: true)
                        .tabItem {
                            Image(systemName: "movieclapper")
                        }
                        .tint(.gray)
                    FilmListView(inProduction: false)
                        .tabItem {
                            Image(systemName: "play.rectangle")
                        }
                    TicketListView()
                        .tabItem {
                            Image(systemName: "ticket")
                        }
                    ProfileView(isAuthorized: $authService.isAuthorized)
                        .tabItem {
                            Image(systemName: "person.crop.circle.fill")

                        }
                }
                .tint(Color("BackgroundColor"))
            } else {
                VStack {
                    if !authService.isAuthorized {
                        AuthorizationView(authService: authService)
                            .transition(.opacity)
                    } else {
                        MainView()
                    }
                }
            }
        }
        .animation(.easeInOut, value: authService.isAuthorized)
    }
}


