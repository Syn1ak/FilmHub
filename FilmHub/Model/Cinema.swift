//
//  Cinema.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 20.05.2024.
//

import Foundation

struct Cinema: Hashable, Codable, CustomStringConvertible {
    var description: String {
        return name
    }
    
    let id: String
    let name: String
    let address: String
    
    init(id: String, name: String, address: String) {
        self.id = id
        self.name = name
        self.address = address
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case address
    }
}
