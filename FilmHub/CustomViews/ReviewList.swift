//
//  ReviewList.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 22.05.2024.
//

import SwiftUI

struct ReviewListView: View {
    let reviews: [Review]
    @ObservedObject var movieService: FIlmDetailsDataService
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "ellipsis.message.fill")
                    .foregroundStyle(Color("BackgroundColor"))
                Text("Reviews (\(reviews.count))")
                Spacer()
            }
            .padding(.top, 5)
            AddOwnReviewView(movieDetailsService: movieService)
            LazyVStack(spacing: 15) {
                ForEach(reviews, id: \.id) { review in
                    ReviewView(review: review)
                    Divider()
                }
            }
            
               
        }
    }
}
