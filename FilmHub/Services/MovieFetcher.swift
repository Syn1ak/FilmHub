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
            print("Invalid url")
        } catch NetworkingErrors.invalidResponse {
            print("Invalid response")
        } catch NetworkingErrors.invalidData {
            print("Invalid data")
        } catch {
            print("Other error")
        }
        return nil
    }
}
