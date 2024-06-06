//
//  ProfileView.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 16.05.2024.
//

import SwiftUI

struct ProfileView: View {
    @Binding private var isAuthorized: Bool
    
    init(isAuthorized: Binding<Bool>) {
        self._isAuthorized = isAuthorized
    }
    var body: some View {
        
        VStack() {
            createHeader()
            ProfileDetailsView(isLogin: true, profileDetailsViewModel: ProfileDetailsViewModel())
            .padding(.horizontal, 20)
            CustomButton(buttonTitlte: "Log out",
                         buttonAction: { isAuthorized.toggle() },
                         buttonWidth: Const.screenWidth * 0.9,
                         buttonHeight: 50)
            .padding(.top, 50)
            Spacer()
        }
        .ignoresSafeArea(.all)
        
    }
    
    @ViewBuilder
    private func createHeader() -> some View {
        VStack (alignment: .center){
            Spacer()
            Text("Profile")
                .foregroundStyle(.white)
                .font(.title2)
                .bold()
                .padding(.bottom, 5)
        }
        .ignoresSafeArea()
        .frame(width: Const.screenWidth, height: 94)
        .background(Color("BackgroundColor"))
    }
}

