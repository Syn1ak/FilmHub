//
//  ContentView.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 16.05.2024.
//

import SwiftUI


struct AuthorizationView: View {
    @Binding var isAuthorized: Bool
    
    init(isAuthorized: Binding<Bool>) {
        self._isAuthorized = isAuthorized
    }
    
    let aspectRatio = Const.screenWidth/Const.screenHeight
    
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        AuthorizationHeader(text: "Login")
        
        Image("Logo")
            .resizable()
            .frame(width: 650 * aspectRatio, height: 350 * aspectRatio)
            .aspectRatio(contentMode: .fill)
            .padding(.top, 90)
            .padding(.bottom, Const.screenHeight/6)
        
        
        VStack (spacing: 20){
            CustomTextField(textValue: $email,
                            placeholder: "Email")
            
            CustomSecureField(textValue: $password,
                            placeholder: "Password")
            CustomButton(buttonTitlte: "Login", buttonAction: { isAuthorized.toggle() })
                
        }
        Spacer()
    }
    
}

#Preview {
    ContentView()
}

struct AuthorizationHeader: View {
    let text: String
    
    init(text: String) {
        self.text = text
    }
    
    var body: some View {
        VStack (alignment: .center){
            Text(text)
                .foregroundStyle(.white)
                .font(.title2)
                .bold()
                .padding(.top, 50)
        }
        .ignoresSafeArea()
        .frame(width: Const.screenWidth, height: 30)
        .background(Color("BackgroundColor"))
    }
}
