//
//  ProfileView.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 16.05.2024.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundStyle(.white)
            .frame(height: 200)
            .padding(.horizontal, 30)
            .shadow(color: Color.black.opacity(0.5), radius: 5)
    }
}

