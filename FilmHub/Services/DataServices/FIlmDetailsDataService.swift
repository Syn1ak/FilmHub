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
        downloadInfo()
    }
    
    private func downloadInfo() {
        Task {
            let info = await movieFetcher.getAdditionalInfo(for: movie.id)
            await MainActor.run {
                self.additionalInfo = info
            }
        }
    }
    
    func addReview(comment: String, rating: Int) {
        Task {
            await movieFetcher.addReview(movieId: movie.id,
                                             userId: AuthorizationService.currentUser!.id,
                                             comment: comment,
                                             rating: rating)
            downloadInfo()
        }
    }
    
    
}
