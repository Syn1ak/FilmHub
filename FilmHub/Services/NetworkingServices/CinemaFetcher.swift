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
            print("Get all cinemas by city: Invalid url")
        } catch NetworkingErrors.invalidResponse {
            print("Get all cinemas by city: Invalid response")
        } catch NetworkingErrors.invalidData {
            print("Get all cinemas by city: Invalid data")
        } catch {
            print("Get all cinemas by city: Other error")
        }
        return nil
    }
}
