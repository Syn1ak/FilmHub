//
//  Film.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 16.05.2024.
//

import Foundation

struct Movie: Codable, Hashable {
    let id: String
    let title: String
    let releaseDate: Date
    let description: String
    let posterLink: URL
    //let duration: TimeInterval
    let director: String
    let rating: Double
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.date(from: formatter.string(from: releaseDate))
        return formatter.string(from: releaseDate)
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title
        case releaseDate
        case description
        case posterLink = "thumbnail"
        //case duration
        case director
        case rating
    }
}

struct MovieGenre: Codable {
    let movie: Movie
    let genre: Genre
}
