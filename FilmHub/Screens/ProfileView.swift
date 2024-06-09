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
    @Published var dataError: DataValidationError?
    
    init() {
        let user = AuthorizationService.currentUser!
        self.phoneNumber = user.phone
        self.name = user.firstName
        self.surname = user.lastName
        self.age = String(user.age)
        self.email = user.email
    }
    
    func getUser() -> User? {
        validate()
        if dataError == nil {
            return User(id: "",
                        firstName: name,
                        lastName: surname,
                        password: "",
                        email: email,
                        age: Int(age)!,
                        phone: phoneNumber)
        } else {
            return nil
        }
    }
    
    func validate(){
        if phoneNumber.count == 13 {
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
        if !email.contains("@") {
            dataError = .email
            return
        }
        dataError = nil
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
                    if profileViewModel.dataError == .phone {
                        createErrorView(error: .phone)
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
                    if profileViewModel.dataError == .name {
                        createErrorView(error: .name)
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
                    if profileViewModel.dataError == .surname {
                        createErrorView(error: .surname)
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
                    if profileViewModel.dataError == .age {
                        createErrorView(error: .age)
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
                    if profileViewModel.dataError == .email {
                        createErrorView(error: .email)
                    }
                }
                
                if isEditing {
                    CustomButton(buttonTitlte: "Save",
                                 buttonAction: {
                                 if let user = profileViewModel.getUser() {
                                     userDataService.editUser(user: user)
                                     profileViewModel.dataError = nil
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
        .animation(.easeInOut, value: profileViewModel.dataError  )
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
        .frame(width: Const.screenWidth, height: Const.screenHeight * 0.11)
        .background(Color("BackgroundColor"))
    }
    
    @ViewBuilder
    func createErrorView(error: DataValidationError) -> some View {
        Text(error.rawValue)
            .foregroundStyle(.red)
            .font(.system(size: 14))
            .transition(.opacity)
    }
    
}



