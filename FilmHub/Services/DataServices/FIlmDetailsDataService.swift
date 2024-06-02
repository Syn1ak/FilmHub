//
//  FIlmDetailsDataService.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 24.05.2024.
//

import Foundation

class FIlmDetailsDataService: ObservableObject {
    let movie: Movie
    @Published private var additionalInfo: MovieAdditionalInfo
    
    init(movie: Movie, additionalInfo: MovieAdditionalInfo) {
        self.movie = movie
        self.additionalInfo = additionalInfo
    }
    
}
