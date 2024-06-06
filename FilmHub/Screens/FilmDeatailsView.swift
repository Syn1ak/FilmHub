//
//  FilmDeatailsView.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 16.05.2024.
//

import SwiftUI
import SDWebImageSwiftUI


struct FilmDeatailsView: View {
    let cinemaId: String
    @ObservedObject var filmDataService: FIlmDetailsDataService
    init(film: Movie, cinemaId: String) {
        self.filmDataService = FIlmDetailsDataService(movie: film)
        self.cinemaId = cinemaId
    }
    
    var body: some View {
        ScrollView {
            WebImage(url: filmDataService.movie.posterLink)
                .resizable()
                .scaledToFill()
                .frame(width: Const.screenWidth)
                .overlay { createPlayButton() }
            VStack (alignment: .leading){
                createFilmTitle(title: filmDataService.movie.title)
                AdditionalTitle(title: "\(filmDataService.movie.fortmattedDuration) | \( filmDataService.additionalInfo?.formattedGenres ?? "")")
                AdditionalInfo(text: filmDataService.movie.description)
                    .padding(.top, 15)
                AdditionalTitle(title: "Release date")
                    .padding(.top, 15)
                AdditionalInfo(text: filmDataService.movie.formattedDate)
                AdditionalTitle(title: "Director")
                    .padding(.top, 15)
                AdditionalInfo(text: filmDataService.movie.director)
                AdditionalTitle(title: "Starring")
                    .padding(.top, 15)
                AdditionalInfo(text: filmDataService.additionalInfo?.getFormattedActorsAndMovies() ?? "")
                
                if filmDataService.movie.releaseDate < Date() {
                    Divider()
                    LazyVStack {
                        ReviewListView(reviews: filmDataService.additionalInfo?.reviews ?? [], movieService: filmDataService)
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 30)
            
        }
        .navigationTitle("Details")
        if filmDataService.movie.releaseDate < Date() && cinemaId != "" {
            NavigationLink(
                destination: SessionsView(movie: filmDataService.movie, cinemaId: cinemaId),
                           label: {
                Text("Sessions")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 35)
                    .background(Color("BackgroundColor"))
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .padding(.horizontal, 30)
                    .padding(.bottom, 20)
            })
        }
    }
    
    @ViewBuilder
    private func createPlayButton() -> some View {
        Button(action: {
            
        }, label: {
            ZStack{
                Circle()
                    .foregroundStyle(.red)
                Image(systemName: "play.fill")
                    .foregroundColor(.white)
                    .frame(width: 50, height: 50)
            }
            .frame(width: 50, height: 50)
        })
    }
    
    @ViewBuilder
    private func createFilmTitle(title: String) -> some View {
        Text(title)
            .font(.title)
            .bold()
            .padding(.top, 30)
            .padding(.bottom, 7)
    }
    
}

struct AdditionalTitle: View {
    let title: String
    
    init(title: String) {
        self.title = title
    }
    
    var body: some View {
        Text(title)
            .font(.system(size: 14))
            .foregroundStyle(.gray)
    }
}

struct AdditionalInfo: View {
    let text: String
    
    init(text: String) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .font(.system(size: 16))
            .bold()
    }
}

struct CustomTextEditor: View {
    @Binding var textValue: String
    @FocusState private var focusedState: Bool

    init(textValue: Binding<String>) {
        self._textValue = textValue
    }
    
    var body: some View {
        TextEditor(text: $textValue)
            .focused($focusedState)
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .onReceive(textValue.publisher.last()) {
                if ($0 as Character).asciiValue == 10 {
                    focusedState = false
                    textValue.removeLast()
                }
            }
    }
}






