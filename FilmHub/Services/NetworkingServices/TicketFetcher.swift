//
//  TicketFetcher.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 03.06.2024.
//

import Foundation

class TicketFetcher {
    let networkingService = Networking()
    
    func getAllTickets(for userId: String) async -> [Ticket]?{
        do {
            let tickets = try await networkingService.getUserTickers(for: userId)
            return tickets
        } catch NetworkingErrors.invalidURL {
            print("Get user tickets: Invalid url")
        } catch NetworkingErrors.invalidResponse {
            print("Get user tickets: Invalid response")
        } catch NetworkingErrors.invalidData {
            print("Get user tickets: Invalid data")
        } catch {
            print("Get user tickets: Other error")
        }
        return nil
    }
    
    func addTicket(sessionId: String, userId: String, seatRow: Int, seatNumber: Int) async {
        do {
            try await networkingService.postAddTicket(sessionId: sessionId,
                                                      userId: userId,
                                                      seatRow: seatRow,
                                                      seatNumber: seatNumber)
        } catch NetworkingErrors.invalidURL {
            print("Add ticket: Invalid url")
        } catch NetworkingErrors.invalidResponse {
            print("Add ticket: Invalid response")
        } catch {
            print("Add ticket: Other error")
        }
    }
}
