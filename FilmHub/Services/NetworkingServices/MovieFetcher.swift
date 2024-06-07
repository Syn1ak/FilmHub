//
//  MovieFetcher.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 21.05.2024.
//

import Foundation

class MovieFetcher {
    let networkingService = Networking()
    
    func getMovies(filters: [String : String]) async -> [Movie]?{
        do {
            let movies = try await networkingService.getMovies(filters: filters)
            return movies
        } catch NetworkingErrors.invalidURL {
            print("Get movies with filters: Invalid url")
        } catch NetworkingErrors.invalidResponse {
            print("Get movies with filters: Invalid response")
        } catch NetworkingErrors.invalidData {
            print("Get movies with filters: Invalid data")
        } catch {
            print("Get movies with filters: Other error")
        }
        return nil
    }
    
    func getFutureMovies() async -> [Movie]? {
        do {
            let futureMovies = try await networkingService.getFutureMovies()
            return futureMovies
        } catch NetworkingErrors.invalidURL {
            print("Get future movies: Invalid url")
        } catch NetworkingErrors.invalidResponse {
            print("Get future movies: Invalid response")
        } catch NetworkingErrors.invalidData {
            print("Get future movies: Invalid data")
        } catch {
            print("Get future movies: Other error")
        }
        return nil
    }
    
    func getAdditionalInfo(for movieId: String) async -> MovieAdditionalInfo? {
        do {
            let info = try await networkingService.getMovieFullInfo(for: movieId)
            return info
        } catch NetworkingErrors.invalidURL {
            print("Get movie full info: Invalid url")
        } catch NetworkingErrors.invalidResponse {
            print("Get movie full info: Invalid response")
        } catch NetworkingErrors.invalidData {
            print("Get movie full info: Invalid data")
        } catch {
            print("Get movie full info: Other error")
        }
        return nil
    }
    
    func addReview(movieId: String, userId: String, comment: String, rating: Int) async {
        do {
            try await networkingService.postAddReview(movieId: movieId,
                                                      userId: userId,
                                                      comment: comment,
                                                      rating: rating)
        } catch NetworkingErrors.invalidURL {
            print("Add review: Invalid url")
        } catch NetworkingErrors.invalidResponse {
            print("Add review: Invalid response")
        } catch {
            print("Add review: Other error")
        }
    }
    
}
