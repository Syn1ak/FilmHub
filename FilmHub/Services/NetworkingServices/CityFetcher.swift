//
//  CityFetcher.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 21.05.2024.
//

import Foundation

class CityFetcher {
    let networkingService = Networking()
    
    func getAllCities() async -> [City]?{
        do {
            let cities = try await networkingService.getAllCities()
            return cities
        } catch NetworkingErrors.invalidURL {
            print("Get all cities: Invalid url")
        } catch NetworkingErrors.invalidResponse {
            print("Get all cities: Invalid response")
        } catch NetworkingErrors.invalidData {
            print("Get all cities: Invalid data")
        } catch {
            print("Get all cities: Other error")
        }
        return nil
    }
}
