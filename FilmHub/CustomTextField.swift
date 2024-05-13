//
//  CustomTextField.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 13.05.2024.
//

import Foundation
import SwiftUI

struct CustomTextField: View {
    @State var isPlaceholderHiden = false
    @Binding var text: String
    let placeholder: String
    
    init(text: Binding<String>, placeholder: String) {
        self._text = text
        self.placeholder = placeholder
    }
    
    var body: some View {
        ZStack {
            TextField("", text: $text)
                .multilineTextAlignment(.center)
                .frame(height: 35)
                .border(Color.red, width: 3)
                .padding(.horizontal, 35)
                .onTapGesture {
                    if(text.isEmpty){
                        isPlaceholderHiden.toggle()
                    }
                }
            if(!isPlaceholderHiden){
                Text(placeholder)
                    .foregroundStyle(.gray)
            }
        }
    }
}
