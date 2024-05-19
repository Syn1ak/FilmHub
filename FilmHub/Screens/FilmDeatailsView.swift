//
//  FilmDeatailsView.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 16.05.2024.
//

import SwiftUI

struct FilmDeatailsView: View {

    let film: Film
    
    init(film: Film) {
        self.film = film
    }
    
    var body: some View {
        VStack (alignment: .leading){
            Color.blue
                .frame(height: 200)
                .overlay{
                    PlayButton()
                }
            FilmTitle(title: film.title)
            AdditionalTitle(text: "\(film.duration) s | Пригоди, екшн")
                .padding(.leading, 20)
            AdditionalInfo(text: "Release date: \(film.releaseDate)")
                .padding(.leading, 20)
                .padding(.top, 1)
            Spacer()
        }

    }
}

struct PlayButton: View {
    
    var body: some View {
        Button(action: {
            
        }, label: {
            ZStack{
                Circle()
                    .foregroundStyle(.red)
                Image(systemName: "play.fill")
                    .foregroundColor(.white)
                    .frame(width: 50, height: 50)
            }
            .frame(width: 50, height: 50)
        })
    }
    
}

struct FilmTitle: View {
    let title: String
    
    init(title: String) {
        self.title = title
    }
    
    var body: some View {
        Text(title)
            .font(.title)
            .bold()
            .padding(.horizontal, 20)
            .padding(.top, 30)
            .padding(.bottom, 7)
    }
}

struct AdditionalTitle: View {
    let text: String
    
    init(text: String) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .font(.system(size: 14))
            .foregroundStyle(.gray)
            
    }
}

struct AdditionalInfo: View {
    let text: String
    
    init(text: String) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .font(.system(size: 16))
            .bold()
    }
}
