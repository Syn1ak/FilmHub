//
//  City.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 20.05.2024.
//

import Foundation

struct City: Hashable, Codable, CustomStringConvertible {
    var description: String {
        return name
    }
    
    let id: String
    let name: String
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
    
    enum CodingKeys: String, CodingKey{
        case id = "_id"
        case name
    }
}
