//
//  FilmListView.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 16.05.2024.
//


import SwiftUI

final class FilmListViewModel: ObservableObject {
    @Published var city: String = ""
    @Published var cinema: String = ""
}


struct FilmListView: View {
    
    @ObservedObject private var filmListModel = FilmListViewModel()
    
    private let userRole: UserRole
    
    init(userRole: UserRole) {
        self.userRole = userRole
    }
    
    var body: some View {
        NavigationStack {
            FilmListHeader(filmListModel: filmListModel)
            ScrollView {
                LazyVStack(spacing: 20) {
                    FilmView()
                    FilmView()
                    FilmView()
                    FilmView()
                }
                .padding(.top, 20)
            }
            
        }
    }
}

struct FilmListHeader: View {
    @ObservedObject private var filmListModel: FilmListViewModel
    var options = ["Cinema", "b", "c", "d", "e"]
    
    init(filmListModel: FilmListViewModel) {
        self.filmListModel = filmListModel
    }
    var body: some View {
        HStack {
            Menu {
                ForEach(options, id: \.self) { option in
                    Button(action: {
                        filmListModel.city = option
                    }, label: {
                        Text(option)
                    })
                }
            } label: {
                Text("City: \(filmListModel.city)")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.white)
            }
            .padding(.horizontal, 20)
            
            
            Menu {
                ForEach(options, id: \.self) { option in
                    Button(action: {
                        filmListModel.cinema = option
                    }, label: {
                        Text(option)
                    })
                }
            } label: {
                Text("Cinema: \(filmListModel.cinema)")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.white)
            }
          
            Spacer()
        }
        .frame(height: 50)
        .background(Color("BackgroundColor"))
        
    }
}
