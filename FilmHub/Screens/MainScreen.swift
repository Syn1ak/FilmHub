//
//  MainScreen.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 16.05.2024.
//

import SwiftUI

struct MainView: View {
    @State var isAuthorized = false
    
    var body: some View {
        VStack {
            if isAuthorized {
                TabView {
                    FilmListView(inProduction: true, userRole: .client)
                        .tabItem {
                            Image(systemName: "movieclapper")
                        }
                        .tint(.gray)
                    FilmListView(inProduction: false, userRole: .client)
                        .tabItem {
                            Image(systemName: "play.rectangle")
                        }
                    TicketListView()
                        .tabItem {
                            Image(systemName: "ticket")
                        }
                    ProfileView(isAuthorized: $isAuthorized)
                        .tabItem {
                            Image(systemName: "person.crop.circle.fill")
                            
                        }
                }
                .tint(Color("BackgroundColor"))
            } else {
                VStack {
                    if !isAuthorized {
                        AuthorizationView(isAuthorized: $isAuthorized)
                            .transition(.opacity)
                    } else {
                        MainView()
                    }
                }
            }
        }
        .animation(.easeInOut, value: isAuthorized)
    }
}


