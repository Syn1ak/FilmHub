//
//  CustomButtom.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 16.05.2024.
//

import SwiftUI

struct CustomButton: View {
    let buttonTitlte: String
    let buttonAction: () -> Void
    let buttonWidth: CGFloat
    let buttonHeight: CGFloat

    init(buttonTitlte: String, buttonAction: @escaping () -> Void, buttonWidth: CGFloat, buttonHeight: CGFloat) {
        self.buttonTitlte = buttonTitlte
        self.buttonAction = buttonAction
        self.buttonWidth = buttonWidth
        self.buttonHeight = buttonHeight
    }
    
    var body: some View{
        Button(action: {
            buttonAction()
        }, label: {
            Text(buttonTitlte)
                .foregroundStyle(.white)
                .font(.title2.bold())
                .frame(width: buttonWidth, height: buttonHeight)
                .background(Color("BackgroundColor"))
                .clipShape(RoundedRectangle(cornerRadius: 10))
        })

    }
}
