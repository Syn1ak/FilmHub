//
//  City.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 20.05.2024.
//

import Foundation

struct City: Codable {
    let id: String
    let name: String
    
    enum CodingKeys: String, CodingKey{
        case id = "_id"
        case name
    }
}
