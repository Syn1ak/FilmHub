//
//  ProfileDetailsView.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 06.06.2024.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var phoneNumber: String
    @Published var name: String
    @Published var surname: String
    @Published var age: String
    @Published var email: String
    
    init() {
        let user = AuthorizationService.currentUser!
        self.phoneNumber = user.phone
        self.name = user.firstName
        self.surname = user.lastName
        self.age = String(user.age)
        self.email = user.email
    }
}

struct ProfileDetailsView: View {
    @ObservedObject var profileViewModel = ProfileViewModel()
    var body: some View {
        VStack(alignment: .leading, spacing: 7){
            AdditionalInfo(text: "Phone number")
                .padding(.top, 10)
            CustomTextField(textValue: $profileViewModel.phoneNumber, placeholder: "")
                .frame(height: 40)
                .padding(.leading, 10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("BackgroundColor"), lineWidth: 2)
                }
            AdditionalInfo(text: "Name")
                .padding(.top, 10)
            CustomTextField(textValue: $profileViewModel.name, placeholder: "")
                .frame(height: 40)
                .padding(.leading, 10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("BackgroundColor"), lineWidth: 2)
                }
            AdditionalInfo(text: "Surname")
                .padding(.top, 10)
            CustomTextField(textValue: $profileViewModel.surname, placeholder: "")
                .frame(height: 40)
                .padding(.leading, 10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("BackgroundColor"), lineWidth: 2)
                }
            AdditionalInfo(text: "Age")
                .padding(.top, 10)
            CustomTextField(textValue: $profileViewModel.age, placeholder: "")
                .frame(height: 40)
                .padding(.leading, 10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("BackgroundColor"), lineWidth: 2)
                }
            AdditionalInfo(text: "Email address")
                .padding(.top, 10)
            CustomTextField(textValue: $profileViewModel.email, placeholder: "")
                .frame(height: 40)
                .padding(.leading, 10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("BackgroundColor"), lineWidth: 2)
                }
        }
    }
    
  
}
