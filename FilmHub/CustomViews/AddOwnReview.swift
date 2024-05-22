//
//  AddOwnReview.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 22.05.2024.
//

import SwiftUI

struct AddOwnReviewView: View {
    @State private var reviewRating = 0
    @State private var review = ""
    
    var body: some View {
        VStack(alignment: .leading){
            CustomTextEditor(textValue: $review)
                .frame(height: 100)
                .padding(.horizontal, 10)
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.blue, lineWidth: 2)
                }
                .background(.white)
            createRatingStars()
                .padding(.top, 10)
            Button(action: {
                
            }, label: {
                Text("Add review")
                    .font(.system(size: 18))
                    .bold()
                    .foregroundStyle(.white)
                    .frame(width: 120, height: 30)
                    .background(Color("BackgroundColor"))
                    .clipShape(RoundedRectangle(cornerRadius: 5))
            })
            .padding(.top, 15)
        }
        .padding(.all, 30)
        .background(Color("ReviewBackgroundColor"))
        .clipShape(RoundedRectangle(cornerRadius: 5))
    }
    
    @ViewBuilder
    private func createRatingStars() -> some View {
        HStack {
            ForEach(1...5, id: \.self) { index in
                Button(action: {
                    reviewRating = index
                }, label: {
                    Image(systemName: reviewRating < index ? "star" : "star.fill")
                        .foregroundStyle(.yellow)
                        .scaleEffect(1.3)
                })
            }
            Spacer()
        }
    }
}
