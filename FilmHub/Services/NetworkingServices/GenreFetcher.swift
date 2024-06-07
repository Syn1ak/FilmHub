//
//  GenreFetcher.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 21.05.2024.
//

import Foundation

class GenreFetcher {
    
    let networkingService = Networking()
    
    func getAllGenres() async -> [Genre]?{
        do {
            let genres = try await networkingService.getAllGenres()
            return genres
        } catch NetworkingErrors.invalidURL {
            print("Get all genres: Invalid url")
        } catch NetworkingErrors.invalidResponse {
            print("Get all genres: Invalid response")
        } catch NetworkingErrors.invalidData {
            print("Get all genres: Invalid data")
        } catch {
            print("Get all genres: Other error")
        }
        return nil
    }
}
