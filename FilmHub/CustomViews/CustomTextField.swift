//
//  CutomTextField.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 16.05.2024.
//

import SwiftUI

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
