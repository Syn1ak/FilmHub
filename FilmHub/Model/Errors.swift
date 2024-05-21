//
//  Errors.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 21.05.2024.
//

import Foundation

enum NetworkingErrors : Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
