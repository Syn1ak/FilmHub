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
}


struct AuthorizationView: View {
    @ObservedObject private var authorizationViewModel = AuthorizationViewModel()
    @Binding var isAuthorized: Bool
    
    init(isAuthorized: Binding<Bool>) {
        self._isAuthorized = isAuthorized
    }
    
    let aspectRatio = Const.screenWidth/Const.screenHeight

    var body: some View {
        ScreenTitleHeader(text: "Login")
        
        Image("Logo")
            .resizable()
            .frame(width: 650 * aspectRatio, height: 350 * aspectRatio)
            .aspectRatio(contentMode: .fill)
            .padding(.top, 90)
            .padding(.bottom, Const.screenHeight/6)
        
        
        VStack (spacing: 20){
            CustomTextField(textValue: $authorizationViewModel.email,
                            placeholder: "Email")
            .padding(.leading, 7)
            .frame(height: 30)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color("BackgroundColor"))
            }
            .padding(.horizontal, 35)
            
            CustomSecureField(textValue: $authorizationViewModel.password,
                            placeholder: "Password")

            CustomButton(buttonTitlte: "Login",
                         buttonAction: { isAuthorized.toggle() }, buttonWidth: 100,
                             buttonHeight: 50)
        }
        Spacer()
    }
}

#Preview {
    ContentView()
}

