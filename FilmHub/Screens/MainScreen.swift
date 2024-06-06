//
//  MainScreen.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 16.05.2024.
//

import SwiftUI

struct MainView: View {
    @ObservedObject private var authService = AuthorizationService()
    private var ticketService = TicketsDataService()
    
    var body: some View {
        VStack {
            if authService.isAuthorized {
                TabView {
                    FilmListView(inProduction: true, ticketsService: ticketService)
                        .tabItem {
                            Image(systemName: "movieclapper")
                        }
                        .tint(.gray)
                    FilmListView(inProduction: false, ticketsService: ticketService)
                        .tabItem {
                            Image(systemName: "play.rectangle")
                        }
                    TicketListView(ticketsDataService: ticketService)
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


