//
//  CustomButtom.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 16.05.2024.
//

import SwiftUI

struct CustomButton: View{
    let buttonTitlte: String
    let buttonAction: () -> Void
    
    init(buttonTitlte: String, buttonAction: @escaping () -> Void) {
        self.buttonTitlte = buttonTitlte
        self.buttonAction = buttonAction
    }
    
    var body: some View{
        Button(action: {
            buttonAction()
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
}
