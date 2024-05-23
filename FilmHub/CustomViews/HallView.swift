//
//  SessionView.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 20.05.2024.
//

import SwiftUI

struct HallView: View {
    
    var body: some View {
        Text("Screen")
            .foregroundStyle(.gray)
            .padding(.top, 50)
        ScreenArc()
            .stroke(Color.gray, lineWidth: 2)
            .padding(.top, 25)
        VStack {
            ForEach(0...9, id: \.self){ index1 in
                HStack {
                    ForEach(0...9, id: \.self){ index2 in
                        Button(action: {
                            
                        }, label: {

                            ZStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(index2 % 2 == 0 ? Color.blue : Color.gray, lineWidth: 2)
                                    .background(Color("SeatColor").opacity(index2 % 2 == 0  ? 1 : 0))
                                    
                                    .padding(.trailing, index2 == 4 ? 30 : 0)
                                if(index2 % 2 == 1){
                                    Image(systemName: "xmark")
                                        .foregroundStyle(.gray)
                                }
                            }
                            .frame(width: 25, height: 25)
                        })
                    }
                }
            }
        }
        .padding(.horizontal, 30)
        .offset(y: -40)
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
