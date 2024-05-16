//
//  FilmView.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 16.05.2024.
//

import SwiftUI


struct FilmView: View {
    let film: Film
    
    init(film: Film) {
        self.film = film
    }
    
    var body: some View{
        RoundedRectangle(cornerRadius: 10)
            .foregroundStyle(.white)
            .frame(width: Const.screenWidth * 0.95, height: 200)
            .shadow(color: Color.black.opacity(0.5), radius: 5)
    }
}
