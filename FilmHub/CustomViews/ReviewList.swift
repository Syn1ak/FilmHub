//
//  ReviewList.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 22.05.2024.
//

import SwiftUI

struct ReviewListView: View {
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "ellipsis.message.fill")
                    .foregroundStyle(Color("BackgroundColor"))
                Text("Reviews (24)")
                Spacer()
            }
            .padding(.top, 5)
            AddOwnReviewView()
            LazyVStack {
                ReviewView()
                    .padding(.vertical, 15)
                Divider()
                ReviewView()
                    .padding(.vertical, 15)
                Divider()
                ReviewView()
                    .padding(.vertical, 15)
                Divider()
                ReviewView()
                    .padding(.vertical, 15)
                Divider()
                ReviewView()
                    .padding(.vertical, 15)
                
            }
            
               
        }
    }
}
