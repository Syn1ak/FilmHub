//
//  SessionView.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 20.05.2024.
//

import SwiftUI

struct HallView: View {
    var seats: [[Bool]]
    @Binding private var selectedSeats: [(row: Int, seat: Int)]
    
    init(seats: [[Bool]]?, selectedSeats: Binding<[(row: Int, seat: Int)]>) {
        self.seats = seats ?? [[]]
        self._selectedSeats = selectedSeats
    }
    var body: some View {
        Text("Screen")
            .foregroundStyle(.gray)
            .padding(.top, 50)
        ScreenArc()
            .stroke(Color.gray, lineWidth: 2)
            .padding(.top, 25)
        VStack {
            ForEach(0..<seats.count, id: \.self){ row in
                HStack {
                    ForEach(0..<seats[row].count/2, id: \.self){ seat in
                        createSeatView(row: row, seat: seat)
                    }
                    Spacer()
                    ForEach(seats[row].count/2..<seats[row].count, id: \.self){ seat in
                        createSeatView(row: row, seat: seat)
                    }
                    
                }
            }
        }
        .padding(.horizontal, 50)
        .offset(y: -40)
    }
    
    @ViewBuilder
    private func createSeatView(row: Int, seat: Int) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .stroke(seats[row][seat] ? Color.gray : Color.blue, lineWidth: 2)
                .background(
                    Color("SeatColor").opacity(
                        selectedSeats.contains(where: { $0.row == row && $0.seat == seat}) ? 1 : 0
                    )
                )
                .onTapGesture {
                    if !seats[row][seat] {
                        if selectedSeats.contains(where: { $0.row == row && $0.seat == seat}) {
                            selectedSeats.removeAll(where: { $0.row == row && $0.seat == seat})
                        } else {
                            selectedSeats.append((row: row, seat: seat))
                        }
                    }
                }
            if seats[row][seat] {
                Image(systemName: "xmark")
                    .foregroundStyle(.gray)
            }
        }
        .frame(width: 20, height: 20)
        .clipShape(RoundedRectangle(cornerRadius: 5))
    }
}


struct ScreenArc: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: CGPoint(x: Const.screenWidth/2,
                                    y: Const.screenHeight/2 + 100),
                    radius: Const.screenWidth * 1.5,
                    startAngle: .degrees(180),
                    endAngle: .degrees(0), clockwise: false)
        return path
    }
}
