//
//  Ticket.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 16.05.2024.
//

import Foundation

struct Ticket {
    let id: String
    let session: Session
    let user: User
    let seatRow: Int
    let seatNumber: Int
    let purchaseDate: Date
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case session
        case user
        case seatRow = "seat_row"
        case seatNumber = "seat_number"
        case purchaseDate = "purchase_date"
    }
}
