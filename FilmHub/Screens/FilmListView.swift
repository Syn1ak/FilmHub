//
//  FilmListView.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 16.05.2024.
//


import SwiftUI

final class FilmListViewModel: ObservableObject {
    @Published var isSearching: Bool = false
    @Published var isFiltering: Bool = false
}


struct FilmListView: View {
        
    init(inProduction: Bool) {
        self.inProduction = inProduction
        self.inProduction ? filmListDataService.downloadMovies() : filmListDataService.downloadFutureMovies()
    }
    
    let inProduction: Bool
    
    @ObservedObject private var filmListModel = FilmListViewModel()
    @ObservedObject private var filmListDataService = FilmListDataService()
    
    
    var body: some View {
        NavigationStack {
            FilmListHeader(filmListModel: filmListModel,
                           filmListDataService: filmListDataService,
                           inProduction: inProduction)
            ScrollView {
                if filmListModel.isSearching {
                    CustomTextField(textValue: $filmListDataService.searchingTitle, placeholder: "Enter film title")
                    .padding(.leading, 15)
                    .frame(height: 40)
                    .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("BackgroundColor"))
                    }
                    .padding(.top, 10)
                    .padding(.horizontal, 20)
                    .transition(.move(edge: .top))
                }
                LazyVStack(spacing: 20) {
                    ForEach(filmListDataService.currentMovies, id: \.id) { movie in
                        NavigationLink(value: movie,
                                       label: {
                                FilmView(movie: movie)
                                .transition(.opacity)
                        })
                    }
                }
                .animation(.easeInOut, value: filmListDataService.currentMovies)
                .padding(.top, 20)
                .padding(.bottom, 100)
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
    @ObservedObject private var filmListDataService: FilmListDataService
    
    let inProduction: Bool
        
    init(filmListModel: FilmListViewModel, filmListDataService: FilmListDataService, inProduction: Bool) {
        self.filmListModel = filmListModel
        self.filmListDataService = filmListDataService
        self.inProduction = inProduction
    }
    
    var body: some View {
        if inProduction {
            HStack {
                CustomMenu(selectedItem: $filmListDataService.currentCity,
                           options: filmListDataService.cities)
                CustomMenu(selectedItem: $filmListDataService.currentCinema,
                           options: filmListDataService.cinemas)
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
                    FilterView(filmListDataService: self.filmListDataService)
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
    
    
    
    struct CustomMenu<T: Hashable & CustomStringConvertible>: View {
    @Binding var selectedItem: T
    let options: [T]
    
    init(selectedItem: Binding<T>, options: [T]) {
        self._selectedItem = selectedItem
        self.options = options
    }
    var body: some View {
        Menu {
            ForEach(options, id: \.self) { option in
                Button(action: {
                    selectedItem = option
                }, label: {
                    if selectedItem == option {
                        Image(systemName: "checkmark")
                    }
                    Text(option.description)
                })
            }
        } label: {
            Text(selectedItem.description)
                .bold()
                .dynamicTypeSize(.large)
                .foregroundStyle(.white)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 5)
        }
    }
}
