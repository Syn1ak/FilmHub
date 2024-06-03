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
    let movieId: String
    let rating: Int
    let comment: String
    let reviewDate: Date
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case user
        case movieId = "movie"
        case rating
        case comment
        case reviewDate = "review_date"
    }
    
    var formatedReviewDate: String {
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "d MMMM yyyy HH:mm"
        outputDateFormatter.locale = Locale(identifier: "en_US_POSIX")
        outputDateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return outputDateFormatter.string(from: reviewDate)
    }
    
}
