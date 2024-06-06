//
//  TicketsDataService.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 03.06.2024.
//

import Foundation

class TicketsDataService: ObservableObject {
    private let ticketsFetcher = TicketFetcher()
    @Published var userTickets: [Ticket] = []

    func addTicket(sessionDataService: SessionsDataService) {
        Task {
            for selectedSeat in sessionDataService.selectedSeats {
                await ticketsFetcher.addTicket(sessionId: sessionDataService.currentSession!.id,
                                               userId: AuthorizationService.currentUser!.id,
                                               seatRow: selectedSeat.row,
                                               seatNumber: selectedSeat.seat)
            }
            await MainActor.run {
                sessionDataService.selectedSeats = []
                sessionDataService.downloadSessions()
            }
            downloadTickets()
        }
    }
    
    func downloadTickets() {
        Task {
            let tickets = await ticketsFetcher.getAllTickets(for: AuthorizationService.currentUser!.id)
            await MainActor.run {
                self.userTickets = tickets ?? []
            }
        }
    }
}
