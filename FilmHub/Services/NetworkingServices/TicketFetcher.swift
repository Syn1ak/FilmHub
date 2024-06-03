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
    
    func addTicket(sessionId: String, userId: String, seatRow: Int, seatNumber: Int) async {
        do {
            try await networkingService.postAddTicket(sessionId: sessionId,
                                                      userId: userId,
                                                      seatRow: seatRow,
                                                      seatNumber: seatNumber)
        } catch NetworkingErrors.invalidURL {
            print("Invalid url")
        } catch NetworkingErrors.invalidResponse {
            print("Invalid response")
        } catch {
            print("Other error")
        }
    }
}
