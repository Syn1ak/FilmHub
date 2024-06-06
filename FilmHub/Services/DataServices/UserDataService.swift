//
//  UserDataService.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 06.06.2024.
//

import Foundation

class UserDataService: ObservableObject {
    
    init(movieId: String) {
        Task {
            let sessions = await sessionFetcher.getSessions(for: movieId)
            await MainActor.run {
                self.allSessions = sessions ?? []
                if allSessions.count > 0 {
                    self.currentSession = self.allSessions[0]
                    self.selectedTime = self.currentSession!.startTime
                }
            }
        }
    }
}
