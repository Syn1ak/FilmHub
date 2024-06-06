//
//  AuthSender.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 03.06.2024.
//

import Foundation

class AuthSender {
    let networkingService = Networking()
    
    func getUserByCredentials(email: String, password: String) async -> User? {
        do {
            let user = try await networkingService.getUserByCredentials(email: email, password: password)
            return user
        } catch NetworkingErrors.invalidURL {
            print("Invalid url")
        } catch NetworkingErrors.invalidResponse {
            print("Invalid response")
        } catch NetworkingErrors.invalidData {
            print("Invalid data")
        } catch NetworkingErrors.unauthorized{
            print("Unauthorized access")
        } catch {
            print("Other error")
        }
        return nil
    }
    
    func signUpUser(user: User) async {
        do {
            try await networkingService.postSignUp(user: user)
        } catch NetworkingErrors.invalidURL {
            print("Invalid url")
        } catch NetworkingErrors.invalidResponse {
            print("Invalid response")
        } catch NetworkingErrors.invalidData {
            print("Invalid data")
        } catch NetworkingErrors.unauthorized{
            print("Unauthorized access")
        } catch {
            print("Other error")
        }
    }
}
