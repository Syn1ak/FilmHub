//
//  ScreenHeader.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 16.05.2024.
//

import SwiftUI

struct ScreenTitleHeader: View {
    let text: String
    
    init(text: String) {
        self.text = text
    }
    
    var body: some View {
        VStack (alignment: .center){
            Text(text)
                .foregroundStyle(.white)
                .font(.title2)
                .bold()
                .padding(.bottom, 5)
        }
        .ignoresSafeArea()
        .frame(width: Const.screenWidth, height: 35)
        .background(Color("BackgroundColor"))
    }
}
