//
//  ReviewView.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 22.05.2024.
//

import SwiftUI

struct ReviewView: View {
    let review: Review
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                HStack (spacing: 10) {
                    AdditionalInfo(text: "\(review.user.lastName) \(review.user.firstName)")
                    AdditionalTitle(title: review.formatedReviewDate)
                }
                Text(review.comment)
                    .lineLimit(nil)
                HStack {
                    ForEach(1...5, id: \.self) { index in
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: review.rating < index ? "star" : "star.fill")
                                .foregroundStyle(.yellow)
                                .scaleEffect(1.3)
                        })
                    }
                }
            }
            Spacer()
        }
    }
}
