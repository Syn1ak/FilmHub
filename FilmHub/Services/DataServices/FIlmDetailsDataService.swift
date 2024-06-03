//
//  FIlmDetailsDataService.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 24.05.2024.
//

import Foundation

class FIlmDetailsDataService: ObservableObject {
    let movieFetcher = MovieFetcher()
    let movie: Movie
    @Published var additionalInfo: MovieAdditionalInfo?
    
    
    init(movie: Movie) {
        self.movie = movie
        Task {
            let info = try await movieFetcher.getAdditionalInfo(for: movie.id)
            await MainActor.run {
                self.additionalInfo = info
            }
        }
    }
    
    
}
