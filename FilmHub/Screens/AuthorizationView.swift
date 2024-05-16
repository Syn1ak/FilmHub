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
    
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        ZStack (alignment: .center){
            Color("BackgroundColor")
            Text("Login")
                .foregroundStyle(.white)
                .font(.title2)
                .bold()
                .offset(y: 20)
        }
        .ignoresSafeArea()
        .frame(height: 40)
        Image("Logo")
            .scaleEffect(0.5)
            .padding(.top, 50)
        
        
        VStack (spacing: 20){
            CustomTextField(textValue: $email,
                            placeholder: "Email")
            
            CustomTextField(textValue: $password,
                            placeholder: "Password")
            CustomButton(buttonTitlte: "Login", buttonAction: { isAuthorized.toggle() })
                
        }
        Spacer()
    }
}



#Preview {
    ContentView()
}
