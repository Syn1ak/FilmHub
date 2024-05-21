//
//  Hall.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 20.05.2024.
//

import Foundation

struct Hall: Codable {
    let id: String
    let cinema: Cinema
    let numberOfSeats: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case cinema
        case numberOfSeats = "number_of_seats"
    }
}
