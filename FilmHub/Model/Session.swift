//
//  Session.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 20.05.2024.
//

import Foundation

struct Session: Codable {
    let id: String
    let movie: Movie
    let hall: Hall
    let seats: [[Bool]]
    let startTime: Date
    let endTime: Date
    let price: Double
    
    var formattedStartTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: startTime)
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case movie
        case hall
        case seats
        case startTime = "start_time"
        case endTime = "end_time"
        case price
    }
    
}
