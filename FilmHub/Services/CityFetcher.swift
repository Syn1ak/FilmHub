//
//  CityFetcher.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 21.05.2024.
//

import Foundation

class CityFetcher {
    let networkingService = Networking()
    
    func getAllMovies() async -> [City]?{
        do {
            let cities = try await networkingService.getAllCities()
            return cities
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
