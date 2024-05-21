//
//  Review.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 20.05.2024.
//

import Foundation

struct Review: Codable {
    let id: String
    let user: User
    let movie: Movie
    let rating: Int
    let comment: String
    let reviewDate: Date
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case user
        case movie
        case rating
        case comment
        case reviewDate
    }
}