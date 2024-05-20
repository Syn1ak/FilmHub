//
//  Cinema.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 20.05.2024.
//

import Foundation

struct Cinema: Codable {
    let id: String
    let name: String
    let address: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case address
    }
}
