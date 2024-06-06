//
//  FilmListDataService.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 21.05.2024.
//

import SwiftUI

class FilmListDataService: ObservableObject {
    
    let movieFetcher = MovieFetcher()
    let cityFetcher = CityFetcher()
    let cinemaFetcher = CinemaFetcher()
    
    var filters = ["city" : "", "cinema" : "", "genres" : "", "date" : "", "actor" : "", "query" : ""]
    
    @Published var currentMovies: [Movie] = []
    @Published var cities: [City] = []
    @Published var currentCity: City = City(id: "", name: "City") {
        didSet {
            filters["city"] = currentCity.id
            downloadMovies()
            downloadCinemas(for: currentCity.id)
            currentCinema = Cinema(id: "", name: "Cinema", address: "")
        }
    }
    @Published var cinemas: [Cinema] = []
    @Published var currentCinema = Cinema(id: "", name: "Cinema", address: "") {
        didSet {
            filters["cinema"] = currentCinema.id
            downloadMovies()
        }
    }
    @Published var searchingTitle: String = "" 

    
    init() {
        downloadCities()
    }
    
    func downloadMovies() {
        Task {
            let movies = await movieFetcher.getMovies(filters: filters)
            await MainActor.run {
                self.currentMovies = movies ?? []
            }
        }
    }
    
    func downloadFutureMovies() {
        Task {
            let futureMovies = await movieFetcher.getFutureMovies()
            await MainActor.run {
                self.currentMovies = futureMovies ?? []
            }
        }
    }
    
    private func downloadCities() {
        Task {
            let cities = await cityFetcher.getAllMovies()
            await MainActor.run {
                self.cities = cities ?? []
            }
        }
    }
    
    private func downloadCinemas(for cityID: String) {
        Task {
            let cinemas = await cinemaFetcher.getAllCinemas(for: cityID)
            await MainActor.run {
                self.cinemas = cinemas ?? []
            }
        }
    }
    
}
