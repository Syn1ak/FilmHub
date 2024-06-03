//
//  TicketView.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 16.05.2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct TicketView: View {
    let ticket: Ticket
    
    init(ticket: Ticket) {
        self.ticket = ticket
    }
    
    var body: some View {
        HStack {
            WebImage(url: ticket.session.movie.posterLink)
                .resizable()
                .scaledToFit()
                .frame(width: Const.screenWidth/3.5, height: 150)
                .padding(.all, 10)
            VStack (alignment: .leading){
                HStack {
                    Spacer()
                    AdditionalTitle(title: ticket.id)
                        .padding(.trailing, 10)
                }
                HStack {
                    Text(ticket.session.movie.title)
                        .font(.title3)
                        .bold()
                }
                HStack(spacing: 10) {
                    VStack(alignment: .leading) {
                        AdditionalTitle(title: "Дата")
                        AdditionalInfo(text: ticket.formattedDate)
                    }
                    VStack(alignment: .leading) {
                        AdditionalTitle(title: "Час")
                        AdditionalInfo(text: ticket.formattedTime)
                    }
                }
                .padding(.top, 2)
                Spacer()
            }
            .padding(.top, 30)
        }
        .frame(width: Const.screenWidth * 0.95, height: 200)
        .background(RoundedRectangle(cornerRadius: 10)
            .foregroundStyle(.white)
            .shadow(color: Color.black.opacity(0.5), radius: 5))
    }
}



