//
//  TicketView.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 16.05.2024.
//

import SwiftUI

struct TicketView: View {
    //let ticket: Ticket
    
//    init(ticket: Ticket) {
//        self.ticket = ticket
//    }
    
    var body: some View {
        HStack {
            Color.red
                .frame(width: Const.screenWidth/3.5, height: 150)
                .padding(.all, 10)
            VStack (alignment: .leading){
                HStack {
                    AdditionalTitle(text: "2D")
                    Spacer()
                    AdditionalTitle(text: "#864394")
                        .padding(.trailing, 10)
                }
                HStack {
                    Text("Я, Побєда і Берлін")
                        .font(.title3)
                        .bold()
                }
                HStack(spacing: 10) {
                    VStack(alignment: .leading) {
                        AdditionalTitle(text: "Дата")
                        AdditionalInfo(text: "3 листопада 2023")
                    }
                    VStack(alignment: .leading) {
                        AdditionalTitle(text: "Час")
                        AdditionalInfo(text: "19:00")
                    }
                    VStack(alignment: .leading) {
                        AdditionalTitle(text: "Зал")
                        AdditionalInfo(text: "3")
                    }
                }
                .padding(.top, 2)
                Spacer()
            }
            .padding(.top, 30)
        }
        .frame(width: Const.screenWidth * 0.9, height: 200)
        .background(RoundedRectangle(cornerRadius: 10)
            .foregroundStyle(.white)
            .shadow(color: Color.black.opacity(0.5), radius: 5))
        
        
    }
}



