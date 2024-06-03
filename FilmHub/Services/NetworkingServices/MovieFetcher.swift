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
    
    func getMovies(for movieId: String) async -> MovieAdditionalInfo?{
        do {
            let movieInfo = try await networkingService.getMovieFullInfo(for: movieId)
            return movieInfo
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
    
    func getFutureMovies() async -> [Movie]? {
        do {
            let futureMovies = try await networkingService.getFutureMovies()
            return futureMovies
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
    
    func getAdditionalInfo(for movieId: String) async throws -> MovieAdditionalInfo? {
        do {
            let info = try await networkingService.getMovieFullInfo(for: movieId)
            return info
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
