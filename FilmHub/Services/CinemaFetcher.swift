//
//  CinemaFetcher.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 21.05.2024.
//

import Foundation

class CinemaFetcher {
    let networkingService = Networking()
    
    func getAllCinemas(for cityId: String) async -> [Cinema]?{
        do {
            let cinemas = try await networkingService.getAllCinemas(for: cityId)
            return cinemas
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
