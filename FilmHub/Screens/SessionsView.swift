//
//  SessionsView.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 20.05.2024.
//

import SwiftUI

struct SessionsView: View {
    
    let movie: Movie
    @State private var
        activeDate = Date()
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    var body: some View {
        Color.blue
            .frame(height: Const.screenHeight/3)
        createDatesList()
        HStack {
            Text("City center")
                .font(.title3)
                .bold()
            Spacer()
            Text("fdlsnfdksgf")
                .font(.system(size: 12))
                .foregroundStyle(.gray)
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        Divider()
            .padding(.horizontal, 20)
        ScrollView(.horizontal) {
            HStack (spacing: 30){
                NavigationLink(destination: { SessionView() },
                               label: {
                    Text("10:30")
                        .font(.title2)
                        .bold()
                        .frame(height: 44)
                })
                NavigationLink(destination: { SessionView() },
                               label: {
                    Text("10:30")
                        .font(.title2)
                        .bold()
                        .frame(height: 44)
                })
                NavigationLink(destination: { SessionView() },
                               label: {
                    Text("10:30")
                        .font(.title2)
                        .bold()
                        .frame(height: 44)
                })
                NavigationLink(destination: { SessionView() },
                               label: {
                    Text("10:30")
                        .font(.title2)
                        .bold()
                        .frame(height: 44)
                })
                NavigationLink(destination: { SessionView() },
                               label: {
                    Text("10:30")
                        .font(.title2)
                        .bold()
                        .frame(height: 44)
                })
                
            }
        }
        .padding(.horizontal, 30)
        .navigationTitle("Sessions")
        Spacer()
    }
    
    private let currentDates: [Date] = {
        var dates = [Date]()
        let calendar = Calendar.current
        let now = Date()
        dates.append(now)
        for i in 1...7 {
            if let date = calendar.date(byAdding: .day, value: i, to: now) {
                dates.append(date)
            }
        }
        return dates
    }()
    
    private let dateFormatter: DateFormatter = {
           let formatter = DateFormatter()
           formatter.dateFormat = "d"
           return formatter
       }()

    private let dayOfWeekShortFormatter: DateFormatter = {
           let formatter = DateFormatter()
           formatter.dateFormat = "E"
           return formatter
    }()
    
    
    @ViewBuilder
    private func createDatesList() -> some View {
        ScrollView(.horizontal) {
            HStack(spacing: 10){
                ForEach(currentDates, id: \.self){ date in
                    Button(action: {
                        activeDate = date
                    }, label: {
                        VStack {
                            Text("\(dayOfWeekShortFormatter.string(from: date))")
                                .font(.system(size: 14))
                                .bold()
                                .foregroundStyle(Color("TabbarColor"))
                            Text("\(dateFormatter.string(from: date))")
                                .font(.title2)
                                .foregroundStyle(activeDate == date ? .white : .black)
                                .bold()
                        }
                        .frame(width: 50, height: 50)
                        .background(activeDate == date ? .red : .white)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                    })
                }
            }
            .padding(.vertical, 10)
        }
        .padding(.horizontal, 20)
    }
  
    
  
}

