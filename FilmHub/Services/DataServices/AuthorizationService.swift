//
//  AuthorizationService.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 03.06.2024.
//

import SwiftUI

class AuthorizationService: ObservableObject {
    let authSender = UserNetworking()
    static var currentUser: User? = nil
    @Published var isAuthorized = false
    @Published var error = ""
    
    
    func login(email: String, password: String) {
        Task {
            let user = await authSender.getUserByCredentials(email: email, password: password)
            await MainActor.run {
                if user != nil {
                    isAuthorized = true
                    AuthorizationService.currentUser = user
                } else {
                    error = "Email or password is incorrect" 
                }
            }
        }
    }
    
    func signUp(user: User) {
        Task {
            await authSender.signUpUser(user: user)
        }
    }
}
