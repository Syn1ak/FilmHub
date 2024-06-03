//
//  TicketList.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 16.05.2024.
//

import SwiftUI

struct TicketListView: View {
    let ticketsDataService = TicketsDataService()
    
    var body: some View {
        VStack {
            ScreenTitleHeader(text: "My tickets")
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach(ticketsDataService.userTickets, id: \.id) { ticket in
                        TicketView(ticket: ticket)
                    }
                }
                .padding(.top, 20)
            }.ignoresSafeArea(.all)
        }
    }
}

