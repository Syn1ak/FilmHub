//
//  FilterDataService.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 21.05.2024.
//

import Foundation

class FilterDataService: ObservableObject {
    
    let genreFetcher = GenreFetcher()
    var dateIsSelected = false
 
    @Published var actorName: String
    @Published var currentGenres: [Genre] = []
    @Published var date: Date {
        didSet {
            dateIsSelected = true
        }
    }
    @Published var allGenres: [Genre] = []
    
    
    init(actorName: String, cureentGenresIds: [String], date: String) {
        self.actorName = actorName
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        self.date = dateFormatter.date(from: date) ?? Date()
        
        Task {
            let genres = await genreFetcher.getAllGenres()
            await MainActor.run {
                self.allGenres = genres ?? []
                self.currentGenres = self.allGenres.filter{ genre in
                    cureentGenresIds.contains(where: { genreId in genre.id == genreId}) }
            }
        }
    }
    
    func applyFilters(filmListDataService: FilmListDataService) {
        filmListDataService.filters["actor"] = actorName
        filmListDataService.filters["genres"] = currentGenres.map { $0.id }.joined(separator: ",")
        filmListDataService.filters["date"] = dateIsSelected ? date.description : ""
        filmListDataService.downloadMovies()
    }
    
    func resetFilters(filmListDataService: FilmListDataService) {
        filmListDataService.filters["actor"] = ""
        filmListDataService.filters["genres"] = ""
        filmListDataService.filters["date"] = ""
        filmListDataService.downloadMovies()
    }

}
