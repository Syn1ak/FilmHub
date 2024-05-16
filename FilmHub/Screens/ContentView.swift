//
//  ContentView.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 16.05.2024.
//

import SwiftUI


struct ContentView: View {
    @State var isAuthorized = false
  
    var body: some View {
        VStack {
            if !isAuthorized {
                AuthorizationView(isAuthorized: $isAuthorized)
                    .transition(.opacity)
            } else {
                MainView()
            }
        }
        .animation(.easeInOut, value: isAuthorized)
    }
}
