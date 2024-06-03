//
//  SessionsView.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 20.05.2024.
//

import SwiftUI

struct SessionsView: View {
    @Environment(\.presentationMode) var presentationMode
    let movie: Movie
    @ObservedObject private var sessionDataService: SessionsDataService
    @ObservedObject private var ticketService = TicketsDataService()
    
    init(movie: Movie) {
        self.movie = movie
        self.sessionDataService = SessionsDataService(movieId: movie.id)
    }
    
    var body: some View {
        VStack {
            HallView(seats: sessionDataService.currentSession?.seats, selectedSeats: $sessionDataService.selectedSeats)
            createFooter()
                .offset(y: -40)
        }
        .background(Color("SessionBakgroundColor"))
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(movie.title)
                .font(.title2)
                .bold()
                .foregroundColor(.white)
            }
        }
    }
    
    @ViewBuilder
    private func createFooter() -> some View {
        creteDateChoosingView()
        createTimeList()
        HStack() {
            VStack(alignment: .leading) {
                Text("Price:")
                    .foregroundStyle(.white)
                Text(sessionDataService.currentSession == nil ? "0₴" : "\(Int(sessionDataService.currentSession!.price) * sessionDataService.selectedSeats.count)₴")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.yellow)
            }
            Spacer()
            Button(action: {
                if sessionDataService.selectedSeats.count > 0 {
                    ticketService.addTicket(sessionDataService: sessionDataService)
                    presentationMode.wrappedValue.dismiss()
                }
            }, label: {
                Text("Buy ticket")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.white)
                    .frame(width: Const.screenWidth/3 * 2, height: 40)
                    .background(Color("SeatColor"))
                    .clipShape(RoundedRectangle(cornerRadius: 5))
            })
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
    }
    
    private func createTimeList() -> some View {
        ScrollView(.horizontal) {
            HStack (spacing: 20){
                ForEach(sessionDataService.allSessions, id: \.id) { session in
                    Button(action: {
                        sessionDataService.selectedTime = session.startTime
                    }, label: {
                        Text(session.formattedStartTime)
                            .foregroundStyle(.white)
                            .font(.title3)
                            .bold()
                            .frame(width: 90, height: 44)
                            .background(session.startTime == sessionDataService.selectedTime ? Color("SeatColor") : Color.clear)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.blue, lineWidth: 1)
                            }
                    })
                }
            }
        }
        .padding(.horizontal, 20)
    }
    
    @ViewBuilder
    private func creteDateChoosingView() -> some View {
        HStack {
            Text("Date:")
                .foregroundStyle(.white)
                .font(.title3)
                .bold()
            Spacer()
            DatePicker("",
                       selection: $sessionDataService.selectedDate,
                       displayedComponents: [.date])
            .datePickerStyle(CompactDatePickerStyle())
            .colorInvert()
            .colorMultiply(Color.white)
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
    }
}

