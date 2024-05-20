//
//  User.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 16.05.2024.
//

import Foundation

enum UserRole: String, Codable {
    case client = "Client"
    case manager = "Manager"
}

struct User: Codable {
    let firstName: String
    let lastName: String
    let password: String
    let email: String
    let role: UserRole
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case password
        case email
        case role
    }
}
