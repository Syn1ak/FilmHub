//
//  SessionsDataService.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 02.06.2024.
//

import Foundation

class SessionsDataService: ObservableObject {
    let sessionFetcher = SessionFetcher()
    let cinemaId: String
    let movieId: String
    @Published var allSessions: [Session] = []
    @Published var currentSession: Session?
    @Published var selectedDate: Date = Date() {
        didSet {
            downloadSessions()
            selectedSeats = []
        }
    }
    @Published var selectedTime: Date?
    @Published var selectedSeats = [(row: Int, seat: Int)]()
    
    init(movieId: String, cinemaId: String) {
        self.movieId = movieId
        self.cinemaId = cinemaId
        downloadSessions()
    }
    
    func downloadSessions() {
        Task {
            let sessions = await sessionFetcher.getSessions(movieId: movieId, date: selectedDate, cinemaId: self.cinemaId)
            await MainActor.run {
                self.allSessions = sessions ?? []
                if allSessions.count > 0 {
                    self.currentSession = self.allSessions[0]
                    self.selectedTime = self.currentSession!.startTime
                }
                else {
                    currentSession = nil
                }
            }
        }
    }
}
