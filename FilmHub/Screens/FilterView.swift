//
//  FilterView.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 16.05.2024.
//

import SwiftUI


final class FilterViewModel: ObservableObject {
    @Published var searchingActor = false
    @Published var choosingGenre = false
    @Published var choosingDate = false
    @Published var bool = false
}

struct FilterView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject private var filterViewModel = FilterViewModel()
    @ObservedObject private var filmListDataService: FilmListDataService
    @ObservedObject private var filterDataService: FilterDataService
   
    init(filmListDataService: FilmListDataService) {
        self.filmListDataService = filmListDataService
        let actor = filmListDataService.filters["actor"] ?? ""
        let genresIds = filmListDataService.filters["genres"]?.split(separator: ",") ?? []
        let date = filmListDataService.filters["date"] ?? ""
        self.filterDataService = FilterDataService(actorName: actor,
                                                   cureentGenresIds: genresIds.map { String($0) },
                                                   date: date)
    }
    
    var body: some View {
        VStack {
            createFilterListElement(imageName: "person",
                              filterTitle: "Actor",
                              buttonTitle: "Search",
                              buttonAction: { filterViewModel.searchingActor.toggle() })
            if filterViewModel.searchingActor {
                CustomTextField(textValue: $filterDataService.actorName, placeholder: "Enter actor name")
                    .padding(.leading, 15)
                    .frame(height: 40)
                    .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("BackgroundColor"))
                    }
                    .transition(.opacity)
            }
            Divider()
            createFilterListElement(imageName: "popcorn",
                            filterTitle: "Genre",
                            buttonTitle: "Choose",
                            buttonAction: { filterViewModel.choosingGenre.toggle() })
            if filterViewModel.choosingGenre {
                createListOfGenres()
            }
            Divider()

            createFilterListElement(imageName: "calendar",
                              filterTitle: "Date",
                              buttonTitle: "Choose",
                              buttonAction: { filterViewModel.choosingDate.toggle() })
            
            if filterViewModel.choosingDate {
                DatePicker("Select a date",
                           selection: $filterDataService.date,
                           displayedComponents: [.date])
                .datePickerStyle(CompactDatePickerStyle())
                .transition(.opacity)
            }
            Divider()
            Spacer()
            HStack(spacing: 50){
                Button(action: {
                    filterDataService.resetFilters(filmListDataService: filmListDataService)
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Reset")
                        .font(.title3)
                        .foregroundStyle(.white)
                        .frame(width: 130, height: 40)
                        .background(Color("BackgroundColor"))
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                })
                Button(action: {
                    filterDataService.applyFilters(filmListDataService: filmListDataService)
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Apply")
                        .font(.title3)
                        .foregroundStyle(.white)
                        .frame(width: 130, height: 40)
                        .background(Color("BackgroundColor"))
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                })
            }
            .padding(.bottom, 50)
        }
        .padding(.horizontal, 20)
        .animation(.easeInOut, value: filterViewModel.searchingActor)
        .animation(.easeInOut, value: filterViewModel.choosingGenre)
        .animation(.easeInOut, value: filterViewModel.choosingDate)

    }
    
    @ViewBuilder
    private func createFilterListElement(imageName: String, filterTitle: String, buttonTitle: String, buttonAction: @escaping () -> Void) -> some View {
        HStack {
            Image(systemName: imageName)
                .foregroundStyle(Color("BackgroundColor"))
                .scaleEffect(1.6)
            Text(filterTitle)
                .font(.title3)
                .padding(.leading, 20)
            Spacer()
            Button(action: {
                buttonAction()
            }, label: {
                Text(buttonTitle)
                    .font(.title3)
                    //.bold()
                    .foregroundStyle(.white)
                    .frame(width: 80, height: 30)
                    .background(Color("BackgroundColor"))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            })
        }
        .frame(height: 50)
    }
    
    @ViewBuilder
    private func createListOfGenres() -> some View {
        ScrollView {
            LazyVStack {
                ForEach(Array(filterDataService.allGenres.enumerated()), id: \.element.id) { index, genre in
                    HStack {
                        CheckBox(isOn: Binding(
                            get: { self.filterDataService.currentGenres.contains(where: { $0.id  == genre.id })},
                            set: { $0 ? self.filterDataService.currentGenres.append(genre) :
                                self.filterDataService.currentGenres.removeAll(where: { $0.id  == genre.id })}))
                        Text(genre.name)
                        Spacer()
                    }
                }
            }
        }
    }
    
}
