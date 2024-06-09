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
    @Published var dataError: DataValidationError?
    
    func getUser() -> User? {
        validate()
        if dataError == nil {
            return User(id: "",
                        firstName: name,
                        lastName: surname,
                        password: password,
                        email: emailAdress,
                        age: Int(age)!,
                        phone: phoneNumber)
        } else {
            return nil
        }
    }
    
    func validate(){
        if phoneNumber.count >= 4 {
            if phoneNumber[phoneNumber.startIndex...phoneNumber.index(phoneNumber.startIndex, offsetBy: 3)] != "+380" {
                dataError = .phone
                return
            }
        } else {
            dataError = .phone
            return
        }
        if name.count == 0 {
            dataError = .name
            return
        }
        if surname.count == 0 {
            dataError = .surname
            return
        }
        if let age = Int(age) {
            if age > 100 || age < 3 {
                dataError = .age
                return
            }
        } else {
            dataError = .age
            return
        }
        if !emailAdress.contains("@") {
            dataError = .email
            return
        }
        if password.count < 7 {
            dataError = .password
            return
        }
        dataError = nil
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
            if signingUpViewModel.dataError == .phone {
                createErrorView(error: .phone)
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
            if signingUpViewModel.dataError == .name {
                createErrorView(error: .name)
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
            if signingUpViewModel.dataError == .surname {
                createErrorView(error: .surname)
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
            if signingUpViewModel.dataError == .age {
                createErrorView(error: .age)
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
            if signingUpViewModel.dataError == .email {
                createErrorView(error: .email)
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
            if signingUpViewModel.dataError == .password {
                createErrorView(error: .password)
            }
        }
        .animation(.easeInOut, value: signingUpViewModel.dataError)
        
        CustomButton(buttonTitlte: "Sign Up",
                     buttonAction: {
                     if let user = signingUpViewModel.getUser() {
                            authService.signUp(user: user)
                            signingUpViewModel.dataError = nil
                            isSignUp.toggle()
                        }
                     },
                     buttonWidth: 150,
                     buttonHeight: 50)
        .padding(.top, 50)
        CustomButton(buttonTitlte: "Back",
                     buttonAction: { self.isSignUp.toggle() },
                     buttonWidth: 150,
                     buttonHeight: 50)
       
    }
    @ViewBuilder
    func createErrorView(error: DataValidationError) -> some View {
        Text(error.rawValue)
            .foregroundStyle(.red)
            .font(.system(size: 14))
            .transition(.opacity)
    }
}

enum DataValidationError: String {
    case phone = "Incorrect phone number"
    case name = "Incorrect name"
    case surname = "Incorrect surname"
    case age = "Age must be between 5 and 100 years"
    case email = "Incorrect email address"
    case password = "Password must contains at least 7 symbols"
}
