//
//  SigningUpView.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 06.06.2024.
//

import SwiftUI

class SigningUpViewModel: ObservableObject {
    @Published var phoneNumber: String = ""
    @Published var emailAdress: String = ""
    @Published var name: String = ""
    @Published var surname: String = ""
    @Published var age: String = ""
    @Published var password: String = ""
    @Published var dataError: Bool = false
    
    func getUser() -> User? {
        guard let age = Int(age) else {
            dataError = true
            return nil
        }
        return User(id: "",
             firstName: name,
             lastName: surname,
             password: password,
             email: emailAdress,
             age: age,
             phone: phoneNumber)
    }
}

struct SigningUpView: View {
    @Binding var isSignUp: Bool
    @ObservedObject var signingUpViewModel = SigningUpViewModel()
    @ObservedObject var authService = AuthorizationService()
    var body: some View {
        VStack(alignment: .leading, spacing: 7){
            AdditionalInfo(text: "Phone number")
                .padding(.top, 10)
            CustomTextField(textValue: $signingUpViewModel.phoneNumber, placeholder: "")
                .frame(height: 40)
                .padding(.leading, 10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("BackgroundColor"), lineWidth: 2)
                }
            AdditionalInfo(text: "Name")
                .padding(.top, 10)
            CustomTextField(textValue: $signingUpViewModel.name, placeholder: "")
                .frame(height: 40)
                .padding(.leading, 10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("BackgroundColor"), lineWidth: 2)
                }
            AdditionalInfo(text: "Surname")
                .padding(.top, 10)
            CustomTextField(textValue: $signingUpViewModel.surname, placeholder: "")
                .frame(height: 40)
                .padding(.leading, 10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("BackgroundColor"), lineWidth: 2)
                }
            AdditionalInfo(text: "Age")
                .padding(.top, 10)
            CustomTextField(textValue: $signingUpViewModel.age, placeholder: "")
                .frame(height: 40)
                .padding(.leading, 10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("BackgroundColor"), lineWidth: 2)
                }
            AdditionalInfo(text: "Email address")
                .padding(.top, 10)
            CustomTextField(textValue: $signingUpViewModel.emailAdress, placeholder: "")
                .frame(height: 40)
                .padding(.leading, 10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("BackgroundColor"), lineWidth: 2)
                }
            AdditionalInfo(text: "Password")
                .padding(.top, 10)
            CustomSecureField(textValue: $signingUpViewModel.password, placeholder: "")
                .frame(height: 40)
                .padding(.leading, 10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("BackgroundColor"), lineWidth: 2)
                }
            CustomButton(buttonTitlte: "Sign Up",
                         buttonAction: {
                if let user = signingUpViewModel.getUser() {
                    authService.signUp(user: user)
                }
            },
                         buttonWidth: 150,
                         buttonHeight: 50)
            .padding(.top, 50)
        }
    }
}
