//
//  User.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 16.05.2024.
//

import Foundation

struct User: Codable {
    let id: String
    let firstName: String
    let lastName: String
    let password: String
    let email: String
    let age: Int
    let phone: String
    
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case password
        case email
        case age
        case phone
    }
}
