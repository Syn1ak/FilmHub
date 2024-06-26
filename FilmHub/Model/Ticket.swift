//
//  Ticket.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 16.05.2024.
//

import Foundation

struct Ticket: Decodable {
    let id: String
    let session: Session
    let user: User
    let seatRow: Int
    let seatNumber: Int
    let purchaseDate: Date
    
    var formattedDate: String {
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "d MMMM yyyy"
        outputDateFormatter.locale = Locale(identifier: "en_US_POSIX")
        outputDateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return outputDateFormatter.string(from: session.startTime)
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case session
        case user
        case seatRow = "seat_row"
        case seatNumber = "seat_number"
        case purchaseDate = "purchase_date"
    }
}
