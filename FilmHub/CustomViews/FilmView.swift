//
//  FilmView.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 16.05.2024.
//

import SwiftUI
import SDWebImageSwiftUI


struct FilmView: View {
    let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    var body: some View {
        ZStack {
            FilmPosterView(posterLink: movie.posterLink)
                .scaledToFill()
                .frame(width: Const.screenWidth * 0.9)
            Text(movie.title)
                .foregroundStyle(.white)
                .font(.title)
                .bold()
        }
    }
}
