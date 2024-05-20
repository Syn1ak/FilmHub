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
    @Published var searchingTitle: String = ""
    @Published var isFiltering: Bool = false
}


struct FilmListView: View {
        
    init(inProduction: Bool, userRole: UserRole) {
        self.inProduction = inProduction
        self.userRole = userRole
    }
    let movies: [Movie] = [
        Movie(id: 1,
              title: "Inception",
              releaseDate: Date(timeIntervalSince1970: 1279344000), // 18 Jul 2010
              description: "A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O.",
              posterLink: URL(string: "https://example.com/inception.jpg")!,
              duration: 148 * 60, // 148 minutes
              director: "Christopher Nolan",
              rating: 8.8),
              
        Movie(id: 2,
              title: "The Matrix",
              releaseDate: Date(timeIntervalSince1970: 922752000), // 31 Mar 1999
              description: "A computer hacker learns from mysterious rebels about the true nature of his reality and his role in the war against its controllers.",
              posterLink: URL(string: "https://example.com/matrix.jpg")!,
              duration: 136 * 60, // 136 minutes
              director: "Lana Wachowski, Lilly Wachowski",
              rating: 8.7),
              
        Movie(id: 3,
              title: "Interstellar",
              releaseDate: Date(timeIntervalSince1970: 1415232000), // 6 Nov 2014
              description: "A team of explorers travel through a wormhole in space in an attempt to ensure humanity's survival.",
              posterLink: URL(string: "https://example.com/interstellar.jpg")!,
              duration: 169 * 60, // 169 minutes
              director: "Christopher Nolan",
              rating: 8.6),
              
        Movie(id: 4,
              title: "The Dark Knight",
              releaseDate: Date(timeIntervalSince1970: 1216080000), // 17 Jul 2008
              description: "When the menace known as the Joker emerges from his mysterious past, he wreaks havoc and chaos on the people of Gotham.",
              posterLink: URL(string: "https://example.com/dark_knight.jpg")!,
              duration: 152 * 60, // 152 minutes
              director: "Christopher Nolan",
              rating: 9.0),
              
        Movie(id: 5,
              title: "The Godfather",
              releaseDate: Date(timeIntervalSince1970: 68040000), // 24 Mar 1972
              description: "The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.",
              posterLink: URL(string: "https://example.com/godfather.jpg")!,
              duration: 175 * 60, // 175 minutes
              director: "Francis Ford Coppola",
              rating: 9.2)
    ]
    let inProduction: Bool
    
    @ObservedObject private var filmListModel = FilmListViewModel()
    
    private let userRole: UserRole
    
    var body: some View {
        NavigationStack {
            FilmListHeader(filmListModel: filmListModel,
                           inProduction: inProduction)
            ScrollView {
                if filmListModel.isSearching {
                    CustomTextField(textValue: $filmListModel.searchingTitle, placeholder: "Enter film title")
                    .padding(.leading, 15)
                    .frame(height: 40)
                    .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("BackgroundColor"))
                    }
                    .padding(.top, 10)
                    .transition(.move(edge: .top))
                }
                LazyVStack(spacing: 20) {
                    ForEach(self.movies, id: \.id) { movie in
                        NavigationLink(value: movie,
                                       label: {
                                FilmView(film: movie)
                        })
                    }
                }
                .padding(.top, 20)
            }
            .navigationDestination(
                for: Movie.self,
                destination: {
                    FilmDeatailsView(film: $0)  
                })
            .ignoresSafeArea(.all)
            .padding(.top, -8)
            .animation(.easeInOut, value: filmListModel.isSearching)
        }
    }

    
    
struct FilmListHeader: View {
    
    @ObservedObject private var filmListModel: FilmListViewModel
    
    let inProduction: Bool
    var options = ["Cinema", "b", "c", "d", "e"]
        
    init(filmListModel: FilmListViewModel,
         inProduction: Bool) {
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
                .padding(.bottom, 5)
                
                NavigationLink {
                    FilterView()
                } label: {
                    Image(systemName: "slider.horizontal.3")
                        .scaleEffect(1.2)
                        .foregroundStyle(.white)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 5)
            }
            .frame(width: Const.screenWidth, height: 35)
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
        .padding(.bottom, 5)
        }
    }
}
