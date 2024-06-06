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
    
    init() {
        Task {
            let tickets = await ticketsFetcher.getAllTickets(for: AuthorizationService.currentUser!.id)
            await MainActor.run {
                self.userTickets = tickets ?? []
            }
        }
    }
    
    func addTicket(sessionDataService: SessionsDataService) {
        Task {
            for selectedSeat in sessionDataService.selectedSeats {
                await ticketsFetcher.addTicket(sessionId: sessionDataService.currentSession!.id,
                                               userId: AuthorizationService.currentUser!.id,
                                               seatRow: selectedSeat.row,
                                               seatNumber: selectedSeat.seat)
            }
            sessionDataService.selectedSeats = []
            sessionDataService.downloadSessions()
        }
    }
}
