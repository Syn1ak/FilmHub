//
//  ContentView.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 13.05.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        ZStack (alignment: .center){
            Color("BackgroundColor")
            Text("Profile")
                .foregroundStyle(.white)
                .font(.system(size: 30).bold())
                .offset(y: 20)
        }
        .ignoresSafeArea()
        .frame(height: 40)
        Image("Logo")
            .scaleEffect(0.5)
            .padding(.top, 50)
        
        
        VStack {
            CustomTextField(textValue: $email,
                            placeholder: "Email")
            
            CustomTextField(textValue: $password,
                            placeholder: "Password")
            
            Button(action: {
                
            }, label: {
                Text("Sign In")
                    .foregroundStyle(.white)
                    .font(.title2.bold())
                    .frame(width: 100, height: 50)
                    .background(Color("BackgroundColor"))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.top, 40)
            })
                
                
        }
        Spacer()
    }
}



struct CustomTextField: View {
    @Binding var textValue: String
    let placeholder: String
    @FocusState private var emailFieldIsFocused: Bool

    init(textValue: Binding<String>, placeholder: String) {
        self._textValue = textValue
        self.placeholder = placeholder
    }
    
    var body: some View {
        TextField(
                placeholder,
                text: $textValue
            )
            .focused($emailFieldIsFocused)
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .padding(.leading, 7)
            .frame(height: 30)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color("BackgroundColor"))
            }
            .padding(.horizontal, 35)
    }
}

#Preview {
    ContentView()
}
