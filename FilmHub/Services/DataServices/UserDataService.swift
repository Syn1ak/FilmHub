//
//  UserDataService.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 06.06.2024.
//

import Foundation

class UserDataService: ObservableObject {
    private let userNetworking = UserNetworking()
    @Published var user = AuthorizationService.currentUser!
    
    func editUser(user: User) {
        Task {
            if let user = await userNetworking.editUser(user: user) {
                self.user = user
                AuthorizationService.currentUser = user
            }
        }
    }
}
