//
//  Networking.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 21.05.2024.
//

import Foundation

struct MyData: Codable {
    let date: Date
}

class Networking {
    
    private func createUrl(for endpoint: String, params: [URLQueryItem]) -> URL? {
        guard let startPath = URL(string: "http://localhost:7000/api/\(endpoint)")
        else { return nil }
        return startPath.appending(queryItems: params)
    }
    
    func getMovies(filters: [String : String]) async throws -> [Movie]? {
        
        let params = [URLQueryItem(name: "city", value: filters["city"]),
                      URLQueryItem(name: "cinema", value: filters["cinema"]),
                      /*URLQueryItem(name: "genres", value: genres?.map{ $0.id }.joined(separator: ",")),*/
                      URLQueryItem(name: "date", value: filters["date"]),
                      URLQueryItem(name: "actor", value: filters["actor"]),
                      URLQueryItem(name: "query", value: filters["query"])
                      ]
        guard let reqUrl = createUrl(for: "movies", params: params)
        else { throw NetworkingErrors.invalidURL }
        print(reqUrl)
        let (data, response) = try await URLSession.shared.data(from: reqUrl)
        if let response = response as? HTTPURLResponse, response.statusCode != 200 {
            throw NetworkingErrors.invalidResponse
        }
        do {
            let decoder = JSONDecoder()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            let movies = try decoder.decode([Movie].self, from: data)
            return movies
        } catch {
            throw NetworkingErrors.invalidData
        }
    }
    
    func getAllCities() async throws -> [City]? {
        guard let reqUrl = createUrl(for: "cities", params: [])
        else { throw NetworkingErrors.invalidURL }
        print(reqUrl)
        let (data, response) = try await URLSession.shared.data(from: reqUrl)
        if let response = response as? HTTPURLResponse, response.statusCode != 200 {
            throw NetworkingErrors.invalidResponse
        }
        do {
            let movies = try JSONDecoder().decode([City].self, from: data)
            return movies
        } catch {
            throw NetworkingErrors.invalidData
        }
    }
    
    func getAllCinemas(for cityID: String) async throws -> [Cinema]? {
        guard let reqUrl = createUrl(for: "cinemas", params: [URLQueryItem(name: "city_id", value: cityID)])
        else { throw NetworkingErrors.invalidURL }
        print(reqUrl)
        let (data, response) = try await URLSession.shared.data(from: reqUrl)
        if let response = response as? HTTPURLResponse, response.statusCode != 200 {
            throw NetworkingErrors.invalidResponse
        }
        do {
            let cinemas = try JSONDecoder().decode([Cinema].self, from: data)
            return cinemas
        } catch {
            throw NetworkingErrors.invalidData
        }
    }
    
    func getAllGenres() async throws -> [Genre]? {
        guard let reqUrl = createUrl(for: "genres", params: [])
        else { throw NetworkingErrors.invalidURL }
        print(reqUrl)
        let (data, response) = try await URLSession.shared.data(from: reqUrl)
        if let response = response as? HTTPURLResponse, response.statusCode != 200 {
            throw NetworkingErrors.invalidResponse
        }
        do {
            let genres = try JSONDecoder().decode([Genre].self, from: data)
            return genres
        } catch {
            throw NetworkingErrors.invalidData
        }
    }
    
    func getFutureMovies() async throws -> [Movie]? {
        guard let reqUrl = createUrl(for: "movies/future_movie", params: [])
        else { throw NetworkingErrors.invalidURL }
        print(reqUrl)
        let (data, response) = try await URLSession.shared.data(from: reqUrl)
        if let response = response as? HTTPURLResponse, response.statusCode != 200 {
            throw NetworkingErrors.invalidResponse
        }
        do {
            let decoder = JSONDecoder()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            let movies = try decoder.decode([Movie].self, from: data)
            return movies
        } catch {
            throw NetworkingErrors.invalidData
        }
    }
    
    func getMovieReviews(for movieId: String) async throws -> [Review]? {
        guard let reqUrl = createUrl(for: "movie", params: [URLQueryItem(name: "movie_id", value: movieId)])
        else { throw NetworkingErrors.invalidURL }
        print(reqUrl)
        let (data, response) = try await URLSession.shared.data(from: reqUrl)
        if let response = response as? HTTPURLResponse, response.statusCode != 200 {
            throw NetworkingErrors.invalidResponse
        }
        do {
            let reviews = try JSONDecoder().decode([Review].self, from: data)
            return reviews
        } catch {
            throw NetworkingErrors.invalidData
        }
    }
    
}


 
