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
    
    let aspectRatio = UIScreen.main.bounds.width/UIScreen.main.bounds.height
    
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        ZStack (alignment: .center){
            Color("BackgroundColor")
            Text("Login")
                .foregroundStyle(.white)
                .font(.title2)
                .bold()
                .padding(.top, 35)
        }
        .ignoresSafeArea()
        .frame(height: 40)
        Image("Logo")
            .resizable()
            .frame(width: 600 * aspectRatio, height: 350 * aspectRatio)
            .aspectRatio(contentMode: .fill)
            .padding(.top, 90)
            .padding(.bottom, UIScreen.main.bounds.height/6)
        
        
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
