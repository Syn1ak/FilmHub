//
//  SessionFetcher.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 02.06.2024.
//

import Foundation

class SessionFetcher {
    let networkingService = Networking()

    func getSessions(for movieId: String) async -> [Session]?{
        do {
            let sessions = try await networkingService.getAllSessions(movieId: movieId)
            return sessions
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
