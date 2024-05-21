//
//  CheckBox.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 19.05.2024.
//

import SwiftUI

struct CheckBox: View {
    @Binding private var isOn: Bool
    
    init(isOn: Binding<Bool>) {
        self._isOn = isOn
    }
    
    var body: some View {
        Image(systemName: isOn ? "checkmark.square" : "square")
                .resizable()
                .frame(width: 24, height: 24)
                .onTapGesture { isOn.toggle() }
    }
}
