//
//  SessionsView.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 20.05.2024.
//

import SwiftUI

struct SessionsView: View {
    
    let movie: Movie
    @State private var activeDate = Date()
//    @State private var selectedTime = 
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    var body: some View {
        VStack {
            HallView()
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
                Text("560")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.yellow)
            }
            Spacer()
            Button(action: {
                
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
                ForEach(0...5, id: \.self) { index in
                    Button(action: {
                    }, label: {
                        Text("10:30")
                            .foregroundStyle(.white)
                            .font(.title3)
                            .bold()
                            .frame(width: 90, height: 44)
                            .background(Color("SeatColor"))
                            .clipShape(RoundedRectangle(cornerRadius: 5))
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
                       selection: $activeDate,
                       displayedComponents: [.date])
            .datePickerStyle(CompactDatePickerStyle())
            .colorInvert()
            .colorMultiply(Color.white)
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
    }
}

