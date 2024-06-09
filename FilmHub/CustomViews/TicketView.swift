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
                .frame(width: Const.screenWidth/3, height: 180)
                .padding(.all, 10)
            VStack (alignment: .leading, spacing: 10){
                HStack {
                    Text(ticket.session.movie.title)
                        .font(.title3)
                        .bold()
                }
                HStack(spacing: 10) {
                    VStack(alignment: .leading) {
                        AdditionalTitle(title: "Date")
                        AdditionalInfo(text: ticket.formattedDate)
                    }
                    VStack(alignment: .leading) {
                        AdditionalTitle(title: "Time")
                        AdditionalInfo(text: ticket.session.formattedStartTime)
                    }
                }
                .padding(.top, 2)
                HStack(spacing: 10) {
                    VStack(alignment: .leading) {
                        AdditionalTitle(title: "Row")
                        AdditionalInfo(text: "\(ticket.seatRow)")
                    }
                    VStack(alignment: .leading) {
                        AdditionalTitle(title: "Seat")
                        AdditionalInfo(text: "\(ticket.seatNumber + 1)")
                    }
                }
                VStack(alignment: .leading) {
                    AdditionalTitle(title: "Hall")
                    AdditionalInfo(text: ticket.session.hall.name)
                }
                Spacer()
            }
            .padding(.top, 10)
            Spacer()
        }
        .frame(width: Const.screenWidth * 0.95, height: 200)
        .background(RoundedRectangle(cornerRadius: 10)
        .foregroundStyle(.white)
        .shadow(color: Color.black.opacity(0.5), radius: 5))
    }
}



