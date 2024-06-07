//
//  AuthSender.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 03.06.2024.
//

import Foundation

class UserNetworking {
    let networkingService = Networking()
    
    func getUserByCredentials(email: String, password: String) async -> User? {
        do {
            let user = try await networkingService.getUserByCredentials(email: email, password: password)
            return user
        } catch NetworkingErrors.invalidURL {
            print("Get user by credentials: Invalid url")
        } catch NetworkingErrors.invalidResponse {
            print("Get user by credentials: Invalid response")
        } catch NetworkingErrors.invalidData {
            print("Get user by credentials: Invalid data")
        } catch NetworkingErrors.unauthorized{
            print("Get user by credentials: Unauthorized access")
        } catch {
            print("Get user by credentials: Other error")
        }
        return nil
    }
    
    func signUpUser(user: User) async {
        do {
            try await networkingService.postSignUp(user: user)
        } catch NetworkingErrors.invalidURL {
            print("Sign up user: Invalid url")
        } catch NetworkingErrors.invalidResponse {
            print("Sign up user: Invalid response")
        } catch NetworkingErrors.invalidData {
            print("Sign up user: Invalid data")
        } catch NetworkingErrors.unauthorized{
            print("Sign up user: Unauthorized access")
        } catch {
            print("Sign up user: Other error")
        }
    }
    
    func editUser(user: User) async -> User? {
        do {
            let user = try await networkingService.editUser(user: user)
            return user
        } catch NetworkingErrors.invalidURL {
            print("Edit user: Invalid url")
        } catch NetworkingErrors.invalidResponse {
            print("Edit user: Invalid response")
        } catch NetworkingErrors.invalidData {
            print("Edit user: Invalid data")
        } catch NetworkingErrors.unauthorized{
            print("Edit user: Unauthorized access")
        } catch {
            print("Edit user: Other error")
        }
        return nil
    }
}
