//
//  ReviewView.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 22.05.2024.
//

import SwiftUI

struct ReviewView: View {
    let rating = 4
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            HStack (spacing: 10) {
                AdditionalInfo(text: "Natalya")
                AdditionalTitle(title: "29 April 2024 12:51")
            }
            Text("This works for me! What I do not really understand though is why I don't have to always do this. E.g. I have two Texts that should wrap lines below each other in a VStack. It's only needed for the first one. For the second one I don't have to do anything. Is this a bug or a feature? (Sidenote: both Texts are also inside a Group on that I set .frame(maxWidth: .infinity, alignment: .leading) for text alignment) ")
            .lineLimit(nil)
            HStack {
                ForEach(1...5, id: \.self) { index in
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: rating < index ? "star" : "star.fill")
                            .foregroundStyle(.yellow)
                            .scaleEffect(1.3)
                    })
                }
            }
        }
        
        
    }
}
