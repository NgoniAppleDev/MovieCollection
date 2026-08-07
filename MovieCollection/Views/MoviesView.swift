//
//  MoviesView.swift
//  MovieCollection
//
//  Created by Ngoni Katsidzira  on 6/8/2026.
//

import SwiftUI
import SwiftData

struct MoviesView: View {
    
    let container: AppContainer
    
    @Environment(\.modelContext) private var modelContext
    @State private var showingCreateMovie = false
    @State private var movieViewModel: MovieViewModel
    
    init(container: AppContainer) {
        self.container = container
        
        _movieViewModel = State(
            initialValue: .init(repository: container.movieRepository)
        )
    }
    
    var body: some View {
        NavigationStack {
            MovieListView(viewModel: movieViewModel)
            .navigationTitle("Movies")
            .toolbar {
                
                ToolbarItemGroup(placement: .topBarLeading) {
                    Menu("Options", systemImage: "slider.horizontal.3") {
                        Menu {
                            Picker("Primary", selection: $movieViewModel.primarySort.animation()) {
                                ForEach(PrimarySort.allCases) { option in
                                    Text(option.rawValue)
                                        .tag(option)
                                }
                            }
                            
                            Divider()
                            
                            Picker("Secondary", selection: $movieViewModel.secondarySort.animation()) {
                                ForEach(SecondarySort.allCases) { option in
                                    Text(option.rawValue)
                                        .tag(option)
                                }
                            }
                            
                        } label: {
                            Label("Sort", systemImage: "arrow.up.arrow.down")
                        }
                        
                        Menu {
                            
                            Button("All", systemImage: movieViewModel.genre == nil ? "checkmark" : "") {
                                withAnimation {
                                    movieViewModel.genre = nil
                                }
                            }
                            
                            Divider()
                            
                            Picker("Genre", selection: $movieViewModel.genre.animation()) {
                                ForEach(movieViewModel.genres, id: \.self) { genre in
                                    Text(genre)
                                        .tag(genre)
                                }
                            }
                            
                        } label: {
                            Label("Genre", systemImage: "line.3.horizontal.decrease")
                        }
                        
                        Button(
                            "Favorites Only",
                            systemImage: movieViewModel.favoritesOnly ? "heart.fill" : "heart"
                        ) {
                            withAnimation {
                                movieViewModel.favoritesOnly.toggle()
                            }
                        }
                    }
                }
                
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showingCreateMovie = true
                    } label: {
                        Label("Add Movie", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingCreateMovie) {
                CreateMovieView(movieViewModel: movieViewModel)
            }
            .searchable(text: $movieViewModel.searchText, prompt: "Search movies...")
        }
    }
}

#Preview {
    MoviesView(
        container: AppContainer(
            modelContainer: PreviewContainer.container,
            movieRepository: PreviewContainer.repository
        )
    )
    .modelContainer(PreviewContainer.container)
}
