//
//  TicketList.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 16.05.2024.
//

import SwiftUI

struct TicketListView: View {
    
    var body: some View {
        ScrollView {
            ScreenTitleHeader(text: "My tickets")
            LazyVStack(spacing: 20) {
                TicketView()
                TicketView()
                TicketView()
                TicketView()
                TicketView()
                TicketView()
            }
            .padding(.top, 20)
        }.ignoresSafeArea(.all)
        
    }
}

