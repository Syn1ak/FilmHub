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
