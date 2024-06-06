//
//  ContentView.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 16.05.2024.
//

import SwiftUI

final class AuthorizationViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isSignUp = false
}


struct AuthorizationView: View {
    @ObservedObject private var authorizationViewModel = AuthorizationViewModel()
    @ObservedObject private var authService: AuthorizationService
    @ObservedObject private var profileDetailsModel = ProfileDetailsViewModel()
    
    init(authService: AuthorizationService) {
        self.authService = authService
    }
    
    let aspectRatio = Const.screenWidth/Const.screenHeight

    var body: some View {
        VStack {
            if !authorizationViewModel.isSignUp {
                VStack {
                    ScreenTitleHeader(text: "")
                    Image("Logo")
                        .resizable()
                        .frame(width: 650 * aspectRatio, height: 350 * aspectRatio)
                        .aspectRatio(contentMode: .fill)
                        .padding(.top, 90)
                        .padding(.bottom, Const.screenHeight/6)
                    VStack (spacing: 20){
                        VStack(spacing: 20) {
                            CustomTextField(textValue: $authorizationViewModel.email,
                                            placeholder: "Email")
                            .frame(height: 40)
                            .padding(.leading, 10)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("BackgroundColor"), lineWidth: 2)
                            }
                            .padding(.horizontal, 35)
                            CustomSecureField(textValue: $authorizationViewModel.password,
                                              placeholder: "Password")
                            .frame(height: 40)
                            .padding(.leading, 10)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("BackgroundColor"), lineWidth: 2)
                            }
                            .padding(.horizontal, 35)
                        }
                        .offset(y: -50)
                        CustomButton(buttonTitlte: "Login",
                                     buttonAction: {
                            authService.login(email: authorizationViewModel.email,
                                              password: authorizationViewModel.password)
                        }, buttonWidth: 150,
                                     buttonHeight: 50)
                        CustomButton(buttonTitlte: "Sign Up",
                                     buttonAction: { authorizationViewModel.isSignUp.toggle() },
                                     buttonWidth: 150,
                                     buttonHeight: 50)
                    }
                    .padding(.bottom, 50)
                    Spacer()
                }
                .transition(.opacity)
            } else {
                VStack {
                    ScreenTitleHeader(text: "")
                    ProfileDetailsView(isLogin: false, profileDetailsViewModel: profileDetailsModel)
                        .padding(.horizontal, 35)
                    CustomButton(buttonTitlte: "Sign Up",
                                 buttonAction: {
                        signUpUser()
                    },
                                 buttonWidth: 150,
                                 buttonHeight: 50)
                    .padding(.top, 30)
                    Spacer()
                }
            }
        }
        .animation(.easeInOut, value: authorizationViewModel.isSignUp)
    }
    
    private func signUpUser() {
        guard let user = profileDetailsModel.getUser() else { return }
        authService.signUp(user: user)
        authorizationViewModel.isSignUp.toggle()
    }
}

#Preview {
    MainView()
}

