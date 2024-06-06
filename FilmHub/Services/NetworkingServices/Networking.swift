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
                      URLQueryItem(name: "genres", value: filters["genres"]),
                      URLQueryItem(name: "date", value: filters["date"]),
                      URLQueryItem(name: "actor", value: filters["actor"]),
                      URLQueryItem(name: "query", value: filters["query"])
                      ]
        guard let reqUrl = createUrl(for: "movies", params: params)
        else { throw NetworkingErrors.invalidURL }
        print(reqUrl)
        let (data, response) = try await URLSession.shared.data(from: reqUrl)
        if let response = response as? HTTPURLResponse, response.statusCode >= 400  {
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
    
    func getAllCities() async throws -> [City] {
        guard let reqUrl = createUrl(for: "cities", params: [])
        else { throw NetworkingErrors.invalidURL }
        print(reqUrl)
        let (data, response) = try await URLSession.shared.data(from: reqUrl)
        if let response = response as? HTTPURLResponse, response.statusCode >= 400  {
            throw NetworkingErrors.invalidResponse
        }
        do {
            let movies = try JSONDecoder().decode([City].self, from: data)
            return movies
        } catch {
            throw NetworkingErrors.invalidData
        }
    }
    
    func getAllCinemas(for cityID: String) async throws -> [Cinema] {
        guard let reqUrl = createUrl(for: "cinemas", params: [URLQueryItem(name: "city_id", value: cityID)])
        else { throw NetworkingErrors.invalidURL }
        print(reqUrl)
        let (data, response) = try await URLSession.shared.data(from: reqUrl)
        if let response = response as? HTTPURLResponse, response.statusCode > 400  {
            throw NetworkingErrors.invalidResponse
        }
        do {
            let cinemas = try JSONDecoder().decode([Cinema].self, from: data)
            return cinemas
        } catch {
            throw NetworkingErrors.invalidData
        }
    }
    
    func getAllGenres() async throws -> [Genre] {
        guard let reqUrl = createUrl(for: "genres", params: [])
        else { throw NetworkingErrors.invalidURL }
        print(reqUrl)
        let (data, response) = try await URLSession.shared.data(from: reqUrl)
        if let response = response as? HTTPURLResponse, response.statusCode >= 400  {
            throw NetworkingErrors.invalidResponse
        }
        do {
            let genres = try JSONDecoder().decode([Genre].self, from: data)
            return genres
        } catch {
            throw NetworkingErrors.invalidData
        }
    }
    
    func getFutureMovies() async throws -> [Movie] {
        guard let reqUrl = createUrl(for: "movies/future_movie", params: [])
        else { throw NetworkingErrors.invalidURL }
        print(reqUrl)
        let (data, response) = try await URLSession.shared.data(from: reqUrl)
        if let response = response as? HTTPURLResponse, response.statusCode >= 400  {
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
    
    
    func getMovieFullInfo(for movieId: String) async throws -> MovieAdditionalInfo {
        guard let reqUrl = createUrl(for: "movies/movie", params: [URLQueryItem(name: "movie_id", value: movieId)])
        else { throw NetworkingErrors.invalidURL }
        print(reqUrl)
        let (data, response) = try await URLSession.shared.data(from: reqUrl)
        if let response = response as? HTTPURLResponse, response.statusCode >= 400  {
            throw NetworkingErrors.invalidResponse
        }
        do {
            let decoder = JSONDecoder()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            let movieInfo = try decoder.decode(MovieAdditionalInfo.self, from: data)
            return movieInfo
        } catch {
            throw NetworkingErrors.invalidData
        }
    }
    
    func getSessions(movieId: String, date: Date, cinemaId: String) async throws -> [Session] {
        guard let reqUrl = createUrl(for: "sessions/getSessionByMovieAndDate", params: [URLQueryItem(name: "movie_id", value: movieId),
                                                                                        URLQueryItem(name: "date", value: date.description),
                                                                                        URLQueryItem(name: "cinema_id", value: cinemaId)])
        else { throw NetworkingErrors.invalidURL }
        print(reqUrl)
        let (data, response) = try await URLSession.shared.data(from: reqUrl)
        if let response = response as? HTTPURLResponse, response.statusCode >= 400  {
            throw NetworkingErrors.invalidResponse
        }
        do {
            let decoder = JSONDecoder()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            let sessions = try decoder.decode([Session].self, from: data)
            return sessions
        } catch {
            throw NetworkingErrors.invalidData
        }
    }
    
    
    func getUserByCredentials(email: String, password: String) async throws -> User {
        guard let reqUrl = createUrl(for: "auth/login", params: [])
        else { throw NetworkingErrors.invalidURL }
        var request = URLRequest(url: reqUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameters: [String : Any] = [
            "email": email,
            "password": password
        ]
        request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        let (data, response) = try await URLSession.shared.data(for: request)
        if let response = response as? HTTPURLResponse, response.statusCode == 401 {
            throw NetworkingErrors.unauthorized
        }
        do {
            let user = try JSONDecoder().decode(User.self, from: data)
            return user
        } catch {
            throw NetworkingErrors.invalidData
        }
    }
    
    func getUserTickers(for userId: String) async throws -> [Ticket] {
        guard let reqUrl = createUrl(for: "user/tickets", params: [URLQueryItem(name: "user_id", value: userId)])
        else { throw NetworkingErrors.invalidURL }
        print(reqUrl)
        let (data, response) = try await URLSession.shared.data(from: reqUrl)
        if let response = response as? HTTPURLResponse, response.statusCode >= 400  {
            throw NetworkingErrors.invalidResponse
        }
        do {
            let decoder = JSONDecoder()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            let tickets = try decoder.decode([Ticket].self, from: data)
            return tickets
        } catch {
            throw NetworkingErrors.invalidData
        }
    }
    
    func postAddTicket(sessionId: String, userId: String, seatRow: Int, seatNumber: Int) async throws {
        guard let reqUrl = createUrl(for: "user/add_ticket", params: [])
        else { throw NetworkingErrors.invalidURL }
        var request = URLRequest(url: reqUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameters: [String : Any] = [
            "session_id": sessionId,
            "user_id": userId,
            "seat_row": seatRow,
            "seat_number": seatNumber
        ]
        request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        let (_, response) = try await URLSession.shared.data(for: request)
        if let response = response as? HTTPURLResponse, response.statusCode >= 400  {
            throw NetworkingErrors.invalidResponse
        }
    }
    
    func postAddReview(movieId: String, userId: String, comment: String, rating: Int) async throws {
        guard let reqUrl = createUrl(for: "movies/movie/add_review", params: [])
        else { throw NetworkingErrors.invalidURL }
        var request = URLRequest(url: reqUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameters: [String : Any] = [
            "movie_id": movieId,
            "user_id": userId,
            "comment": comment,
            "rating": rating
        ]
        request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        let (_, response) = try await URLSession.shared.data(for: request)
        if let response = response as? HTTPURLResponse, response.statusCode >= 400  {
            throw NetworkingErrors.invalidResponse
        }
    }
    
    func postSignUp(user: User) async throws {
        guard let reqUrl = createUrl(for: "auth/sign_up", params: [])
        else { throw NetworkingErrors.invalidURL }
        var request = URLRequest(url: reqUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameters: [String : Any] = [
            "first_name": user.firstName,
            "last_name": user.lastName,
            "phone": user.phone,
            "password": user.password,
            "email": user.email,
            "age": user.age
        ]
        request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        let (_, response) = try await URLSession.shared.data(for: request)
        if let response = response as? HTTPURLResponse, response.statusCode >= 400 {
            throw NetworkingErrors.invalidResponse
        }
    }
    
    func editUser(user: User) async throws -> User {
        guard let reqUrl = createUrl(for: "user", params: [])
        else { throw NetworkingErrors.invalidURL }
        var request = URLRequest(url: reqUrl)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameters: [String : Any] = [
            "_id": user.id,
            "first_name": user.firstName,
            "last_name": user.lastName,
            "email": user.email,
            "age": user.age,
            "phone": user.phone
        ]
        request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        let (data, response) = try await URLSession.shared.data(for: request)
        if let response = response as? HTTPURLResponse, response.statusCode >= 400  {
            throw NetworkingErrors.invalidResponse
        }
        do {
            let user = try JSONDecoder().decode(User.self, from: data)
            return user
        } catch {
            throw NetworkingErrors.invalidData
        }
    }
}


 
