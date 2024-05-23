//
//  ProfileView.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 16.05.2024.
//

import SwiftUI

struct ProfileView: View {
    @Binding private var isAuthorized: Bool
    @State private var phoneNumber = "+380972838677"
    @State private var emailAdress = "zakhlit@gmail.com"
    @State private var name = "Zakhar"
    @State private var surname = "Litvinchuk"
    
    
    init(isAuthorized: Binding<Bool>) {
        self._isAuthorized = isAuthorized
    }
    var body: some View {
        
        VStack() {
            createHeader()
            VStack(alignment: .leading, spacing: 15){
                AdditionalInfo(text: "Phone number")
                    .padding(.top, 10)
                CustomTextField(textValue: $phoneNumber, placeholder: "")
                    .frame(height: 40)
                    .padding(.leading, 10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color("BackgroundColor"), lineWidth: 2)
                    }
                AdditionalInfo(text: "Email address")
                    .padding(.top, 10)
                CustomTextField(textValue: $emailAdress, placeholder: "")
                    .frame(height: 40)
                    .padding(.leading, 10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color("BackgroundColor"), lineWidth: 2)
                    }
                AdditionalInfo(text: "Name")
                    .padding(.top, 10)
                CustomTextField(textValue: $name, placeholder: "")
                    .frame(height: 40)
                    .padding(.leading, 10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color("BackgroundColor"), lineWidth: 2)
                    }
                AdditionalInfo(text: "Surname")
                    .padding(.top, 10)
                CustomTextField(textValue: $surname, placeholder: "")
                    .frame(height: 40)
                    .padding(.leading, 10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color("BackgroundColor"), lineWidth: 2)
                    }
                
                CustomButton(buttonTitlte: "Log out",
                             buttonAction: { isAuthorized.toggle() },
                             buttonWidth: Const.screenWidth * 0.9,
                             buttonHeight: 50)
            }
            .padding(.horizontal, 20)
            
            
                
            Spacer()
        }
        .ignoresSafeArea(.all)
        
    }
    
    @ViewBuilder
    private func createHeader() -> some View {
        VStack (alignment: .center){
            Spacer()
            Text("Profile")
                .foregroundStyle(.white)
                .font(.title2)
                .bold()
                .padding(.bottom, 5)
        }
        .ignoresSafeArea()
        .frame(width: Const.screenWidth, height: 94)
        .background(Color("BackgroundColor"))
    }
}

