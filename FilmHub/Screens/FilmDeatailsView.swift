//
//  FilmDeatailsView.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 16.05.2024.
//

import SwiftUI

struct FilmDeatailsView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

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
            AdditionalInfo(text: "Release date: \(film.releaseDate)")
            
            Spacer()
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading){
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "arrow.left")
                        .foregroundStyle(Color("BackgroundColor"))
                })
            }
            
            ToolbarItem(placement: .topBarLeading){
                Text(film.title)
                    .font(.title2)
                    .bold()
            }
            
            ToolbarItem(placement: .topBarTrailing){
                Button(action: {
                    
                }, label: {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundStyle(Color("BackgroundColor"))
                })
            }
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
            .padding(.leading, 20)
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
            .padding(.leading, 20)
            .padding(.top, 1)
    }
}
