//
//  Film.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 16.05.2024.
//

import Foundation

typealias Filters = (actor: String?, genre: String?, date: Date?)

struct Film: Codable, Hashable {
    let id: Int
    let title: String
    let releaseDate: Date
    let language: String
    let duration: TimeInterval
    let poster: String
    let director: String?
    let rating: Double
}
