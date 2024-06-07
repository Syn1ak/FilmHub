//
//  SessionFetcher.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 02.06.2024.
//

import Foundation

class SessionFetcher {
    let networkingService = Networking()

    func getSessions(movieId: String, date: Date, cinemaId: String) async -> [Session]?{
        do {
            let sessions = try await networkingService.getSessions(movieId: movieId, date: date, cinemaId: cinemaId)
            return sessions
        } catch NetworkingErrors.invalidURL {
            print("Get sessions: Invalid url")
        } catch NetworkingErrors.invalidResponse {
            print("Get sessions: Invalid response")
        } catch NetworkingErrors.invalidData {
            print("Get sessions: Invalid data")
        } catch {
            print("Get sessions: Other error")
        }
        return nil
    }
}
