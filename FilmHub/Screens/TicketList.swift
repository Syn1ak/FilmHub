//
//  TicketList.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 16.05.2024.
//

import SwiftUI

struct TicketListView: View {
    
    var body: some View {
        VStack{
            ScreenTitleHeader(text: "My tickets")
            ScrollView {
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
}

