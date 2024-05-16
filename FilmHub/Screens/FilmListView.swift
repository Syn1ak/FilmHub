//
//  FilmListView.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 16.05.2024.
//


import SwiftUI

final class FilmListViewModel: ObservableObject {
    @Published var city: String = "City"
    @Published var cinema: String = "Cinema"
    @Published var isSearching: Bool = false
    @Published var searchingFilmString: String = ""
    @Published var isFiltering: Bool = false
}


struct FilmListView: View {
    let inProduction: Bool
    
    let films = [Film(
        id: 1,
        title: "Inception",
        releaseDate: Date(),
        language: "English",
        duration: 8880, 
        poster: "inception_poster.jpg",
        director: "Christopher Nolan",
        rating: 8.8
    ),
                 Film(
                    id: 2,
                    title: "The Shawshank Redemption",
                    releaseDate: Date(timeIntervalSince1970: 747859200),
                    language: "English",
                    duration: 8520, // Довжина фільму у секундах
                    poster: "shawshank_redemption_poster.jpg",
                    director: "Frank Darabont",
                    rating: 9.3
                 ),
                 Film(
                    id: 3,
                    title: "The Godfather",
                    releaseDate: Date(timeIntervalSince1970: 478224000),
                    language: "English",
                    duration: 10500,
                    poster: "godfather_poster.jpg",
                    director: "Francis Ford Coppola",
                    rating: 9.2
                 ),
                 Film(
                    id: 4,
                    title: "The Dark Knight",
                    releaseDate: Date(timeIntervalSince1970: 1218060800),
                    language: "English",
                    duration: 9120,
                    poster: "dark_knight_poster.jpg",
                    director: "Christopher Nolan",
                    rating: 9.0
                 ),
                 Film(
                    id: 5,
                    title: "Pulp Fiction",
                    releaseDate: Date(timeIntervalSince1970: 783216000),
                    language: "English",
                    duration: 9240,
                    poster: "pulp_fiction_poster.jpg",
                    director: "Quentin Tarantino",
                    rating: 8.9
                 )]
    
    @ObservedObject private var filmListModel = FilmListViewModel()
    
    private let userRole: UserRole
    
    init(inProduction: Bool, userRole: UserRole) {
        self.inProduction = inProduction
        self.userRole = userRole
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                FilmListHeader(filmListModel: filmListModel, inProduction: inProduction)
                if filmListModel.isSearching {
                    CustomTextField(textValue: $filmListModel.searchingFilmString, placeholder: "Enter film title, actor")
                    .padding(.leading, 15)
                    .frame(height: 40)
                    .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("BackgroundColor"))
                    }
                    .transition(.move(edge: .top))
                }
                LazyVStack(spacing: 20) {
                    ForEach(self.films, id: \.id) { film in
                        NavigationLink(value: film,
                                       label: {
                                FilmView(film: film)
                        })
                    }
                }
                .padding(.top, 20)
            }
            .navigationDestination(
                for: Film.self,
                destination: { FilmDeatailsView(film: $0) }
            )
            .ignoresSafeArea(.all)
            .animation(.easeInOut, value: filmListModel.isSearching)
        }
    }

    
    
struct FilmListHeader: View {
    
    @ObservedObject private var filmListModel: FilmListViewModel
    
    let inProduction: Bool
    var options = ["Cinema", "b", "c", "d", "e"]
        
    init(filmListModel: FilmListViewModel, inProduction: Bool) {
        self.filmListModel = filmListModel
        self.inProduction = inProduction
    }
    
    var body: some View {
        if inProduction {
            HStack {
                
                CustomMenu(selectedItem: $filmListModel.city,
                           options: options)
                CustomMenu(selectedItem: $filmListModel.cinema,
                           options: options)
                Spacer()
                
                Button(action: {
                    filmListModel.isSearching.toggle()
                }, label: {
                    Image(systemName: "magnifyingglass")
                        .scaleEffect(1.2)
                        .foregroundStyle(.white)
                })
                .padding(.top, 50)    
                
                Button(action: {
                }, label: {
                    Image(systemName: "slider.horizontal.3")
                        .scaleEffect(1.2)
                        .foregroundStyle(.white)
                })
                .padding(.horizontal, 20)
                .padding(.top, 50)
            }
            .frame(width: Const.screenWidth, height: 100)
            .background(Color("BackgroundColor"))
        } else {
            ScreenTitleHeader(text: "Soon")
        }
    }
}
    
    
    
struct CustomMenu: View {
    @Binding var selectedItem: String
    let options: [String]
    
    init(selectedItem: Binding<String>, options: [String]) {
        self._selectedItem = selectedItem
        self.options = options
    }
    var body: some View {
        Menu {
            ForEach(options, id: \.self) { option in
                Button(action: {
                    selectedItem = option
                }, label: {
                    Text(option)
                })
            }
        } label: {
            Text(selectedItem)
                .font(.title2)
                .bold()
                .foregroundStyle(.white)
        }
        .padding(.horizontal, 20)
        .padding(.top, 50)
        }
    }
}
