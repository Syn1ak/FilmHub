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
    let duration: TimeInterval
    let director: String
    let rating: Double
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.date(from: formatter.string(from: releaseDate))
        return formatter.string(from: releaseDate)
    }
    
    var fortmattedDuration: String {
        return "\(Int(duration/3600)) hour \((Int(duration) % 3600) / 60) min."
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title
        case releaseDate
        case description
        case posterLink = "thumbnail"
        case duration
        case director
        case rating
    }
}

struct MovieGenre: Codable {
    let movie: Movie
    let genre: Genre
}

struct MovieAdditionalInfo: Codable {
    let actors: [Actor]
    let genres: [Genre]
    let reviews: [Review]
    
    var formattedGenres: String {
        var result = ""
        for i in 0..<genres.count {
            result += genres[i].name
            if i < genres.count - 1 {
                result += ", "
            }
        }
        return result
    }
    
    func getFormattedActorsAndMovies() -> String {
        var result = ""
        for i in 0..<actors.count {
            result += "\(actors[i].name) ("
            for j in 0..<actors[i].popularMovies.count {
                result += "\"\(actors[i].popularMovies[j])\""
                if j < actors[i].popularMovies.count - 1 {
                    result += ", "
                }
            }
            result += ")"
            if i < actors.count - 1 {
                result += ", "
            }
        }
        return result
    }
}


