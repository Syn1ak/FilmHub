//
//  FilmDeatailsView.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 16.05.2024.
//

import SwiftUI

struct FilmDeatailsView: View {

    let movie: Movie
    
    init(film: Movie) {
        self.movie = film
    }
    
    var body: some View {
        ScrollView {
            Color.blue
                .frame(height: 200)
                .overlay { createPlayButton() }
            VStack (alignment: .leading){
                createFilmTitle(title: movie.title)
                AdditionalTitle(title: "\(movie.duration) s | Пригоди, екшн")
                AdditionalInfo(text: "Анді Дюфрейн, успішний банкір, несправедливо засуджений до довічного ув'язнення за вбивство своєї дружини та її коханця. Потрапивши до суворої в'язниці Шоушенк, він зіштовхується з жорстокістю тюремного життя, але знаходить друзів і надію. Завдяки своїм навичкам та незламній вірі в справедливість, Анді змінює життя багатьох ув'язнених, готуючи шлях до своєї неймовірної втечі.")
                    .padding(.top, 15)
                AdditionalTitle(title: "Release date")
                    .padding(.top, 15)
                AdditionalInfo(text: movie.releaseDate.description)
                AdditionalTitle(title: "Director")
                    .padding(.top, 15)
                AdditionalInfo(text: movie.director)
            }
            .padding(.leading, 20)
        }
        .navigationTitle("Details")
        .padding(.bottom, 30)
        NavigationLink(destination: SessionsView(movie: movie),
                       label: {
            Text("Sessions")
                .font(.title3)
                .bold()
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 35)
                .background(Color("BackgroundColor"))
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .padding(.horizontal, 30)
                .padding(.bottom, 20)
                
        })
    }
    
    @ViewBuilder
    private func createPlayButton() -> some View {
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
    
    @ViewBuilder
    private func createFilmTitle(title: String) -> some View {
        Text(title)
            .font(.title)
            .bold()
            .padding(.top, 30)
            .padding(.bottom, 7)
    }
}

struct AdditionalTitle: View {
    let title: String
    
    init(title: String) {
        self.title = title
    }
    
    var body: some View {
        Text(title)
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

