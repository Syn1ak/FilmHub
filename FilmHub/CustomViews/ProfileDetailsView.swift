//
//  ProfileDetailsView.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 06.06.2024.
//

import SwiftUI

class ProfileDetailsViewModel: ObservableObject {
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

struct ProfileDetailsView: View {
    let isLogin: Bool
    @ObservedObject var profileDetailsViewModel: ProfileDetailsViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 7){
            AdditionalInfo(text: "Phone number")
                .padding(.top, 10)
            CustomTextField(textValue: $profileDetailsViewModel.phoneNumber, placeholder: "")
                .frame(height: 40)
                .padding(.leading, 10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("BackgroundColor"), lineWidth: 2)
                }
            AdditionalInfo(text: "Name")
                .padding(.top, 10)
            CustomTextField(textValue: $profileDetailsViewModel.name, placeholder: "")
                .frame(height: 40)
                .padding(.leading, 10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("BackgroundColor"), lineWidth: 2)
                }
            AdditionalInfo(text: "Surname")
                .padding(.top, 10)
            CustomTextField(textValue: $profileDetailsViewModel.surname, placeholder: "")
                .frame(height: 40)
                .padding(.leading, 10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("BackgroundColor"), lineWidth: 2)
                }
            AdditionalInfo(text: "Age")
                .padding(.top, 10)
            CustomTextField(textValue: $profileDetailsViewModel.age, placeholder: "")
                .frame(height: 40)
                .padding(.leading, 10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("BackgroundColor"), lineWidth: 2)
                }
            AdditionalInfo(text: "Email address")
                .padding(.top, 10)
            CustomTextField(textValue: $profileDetailsViewModel.emailAdress, placeholder: "")
                .frame(height: 40)
                .padding(.leading, 10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("BackgroundColor"), lineWidth: 2)
                }
            if !isLogin {
                AdditionalInfo(text: "Password")
                    .padding(.top, 10)
                CustomSecureField(textValue: $profileDetailsViewModel.password, placeholder: "")
                    .frame(height: 40)
                    .padding(.leading, 10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("BackgroundColor"), lineWidth: 2)
                    }
            }
        }
    }
    
  
}
