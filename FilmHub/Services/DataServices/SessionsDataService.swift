//
//  SessionsDataService.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 02.06.2024.
//

import Foundation

class SessionsDataService: ObservableObject {
    let sessionFetcher = SessionFetcher()
    @Published var allSessions: [Session] = []
    @Published var currentSession: Session?
    @Published var selectedDate = Date()
    @Published var selectedTime: Date?
    @Published var selectedSeats = [(row: Int, seat: Int)]()
    
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
