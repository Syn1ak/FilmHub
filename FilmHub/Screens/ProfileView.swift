//
//  ProfileView.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 16.05.2024.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var phoneNumber: String
    @Published var name: String
    @Published var surname: String
    @Published var age: String
    @Published var email: String
    @Published var dataError = false
    
    init() {
        let user = AuthorizationService.currentUser!
        self.phoneNumber = user.phone
        self.name = user.firstName
        self.surname = user.lastName
        self.age = String(user.age)
        self.email = user.email
    }
    
    func getUser() -> User? {
        guard let age = Int(age) else {
            dataError = true
            return nil
        }
        return User(id: AuthorizationService.currentUser!.id,
             firstName: name,
             lastName: surname,
             password: "",
             email: email,
             age: age,
             phone: phoneNumber)
    }
}

struct ProfileView: View {
    @Binding private var isAuthorized: Bool
    @State private var isEditing: Bool = false
    @ObservedObject var profileViewModel = ProfileViewModel()
    private var userDataService = UserDataService()
    
    init(isAuthorized: Binding<Bool>) {
        self._isAuthorized = isAuthorized
    }
    
    var body: some View {
        VStack() {
            createHeader()
            VStack(alignment: .center){
                VStack(alignment: .leading, spacing: 7) {
                    AdditionalInfo(text: "Phone number")
                        .padding(.top, 10)
                    CustomTextField(textValue: $profileViewModel.phoneNumber, placeholder: "")
                        .disabled(!isEditing)
                        .frame(height: 40)
                        .padding(.leading, 10)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("BackgroundColor"), lineWidth: 2)
                        }
                    AdditionalInfo(text: "Name")
                        .padding(.top, 10)
                    CustomTextField(textValue: $profileViewModel.name, placeholder: "")
                        .disabled(!isEditing)
                        .frame(height: 40)
                        .padding(.leading, 10)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("BackgroundColor"), lineWidth: 2)
                        }
                    AdditionalInfo(text: "Surname")
                        .padding(.top, 10)
                    CustomTextField(textValue: $profileViewModel.surname, placeholder: "")
                        .disabled(!isEditing)
                        .frame(height: 40)
                        .padding(.leading, 10)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("BackgroundColor"), lineWidth: 2)
                        }
                    AdditionalInfo(text: "Age")
                        .padding(.top, 10)
                    CustomTextField(textValue: $profileViewModel.age, placeholder: "")
                        .disabled(!isEditing)
                        .frame(height: 40)
                        .padding(.leading, 10)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("BackgroundColor"), lineWidth: 2)
                        }
                    AdditionalInfo(text: "Email address")
                        .padding(.top, 10)
                    CustomTextField(textValue: $profileViewModel.email, placeholder: "")
                        .disabled(!isEditing)
                        .frame(height: 40)
                        .padding(.leading, 10)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("BackgroundColor"), lineWidth: 2)
                        }
                }
                
                if isEditing {
                    CustomButton(buttonTitlte: "Save",
                                 buttonAction: {
                                 if let user = profileViewModel.getUser() {
                                     userDataService.editUser(user: user)
                                     isEditing.toggle()
                                    }
                                 },
                                 buttonWidth: Const.screenWidth * 0.9,
                                 buttonHeight: 50)
                    .padding(.top, 50)
                    .transition(.opacity)
                } else {
                    CustomButton(buttonTitlte: "Log out",
                                 buttonAction: { isAuthorized.toggle() },
                                 buttonWidth: Const.screenWidth * 0.9,
                                 buttonHeight: 50)
                    .padding(.top, 50)
                    .transition(.opacity)
                }
            }
            .padding(.horizontal, 20)
            Spacer()
        }
        .ignoresSafeArea(.all)
        .animation(.easeInOut, value: isEditing)
    }
    
    @ViewBuilder
    private func createHeader() -> some View {
        VStack (alignment: .center){
            Spacer()
            HStack {
                Spacer()
                Text("Profile")
                    .foregroundStyle(.white)
                    .font(.title2)
                    .bold()
                    .padding(.bottom, 5)
                    .offset(x: isEditing ? 0 : 18)
                Spacer()
                if !isEditing {
                    Image(systemName: "square.and.pencil")
                        .foregroundStyle(.white)
                        .scaleEffect(1.2)
                        .padding(.trailing, 15)
                        .padding(.bottom, 10)
                        .onTapGesture {
                            isEditing.toggle()
                        }
                        .transition(.opacity)
                }
            }
            
        }
        .ignoresSafeArea()
        .frame(width: Const.screenWidth, height: 94)
        .background(Color("BackgroundColor"))
    }
    
    
}



