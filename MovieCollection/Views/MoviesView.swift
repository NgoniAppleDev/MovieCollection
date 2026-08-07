//
//  MoviesView.swift
//  MovieCollection
//
//  Created by Ngoni Katsidzira  on 6/8/2026.
//

import SwiftUI
import SwiftData

struct MoviesView: View {
    
    @Query(sort: \Movie.genre) private var movies: [Movie]
    
    @State private var showingCreateMovie = false
    @State private var primarySortOption: PrimarySort = .title
    @State private var secondarySortOption: SecondarySort = .newest
    @State private var searchText = ""
    @State private var selectedGenre: String?
    
    var genres: [String]  {
        Array(Set(movies.map { $0.genre })).sorted()
    }
    
    var body: some View {
        NavigationStack {
            MovieListView(
                primarySortOption: primarySortOption,
                secondarySortOption: secondarySortOption,
                searchText: searchText,
                genreFilter: selectedGenre ?? "All"
            )
            .navigationTitle("Movies")
            .toolbar {
                
                ToolbarItemGroup(placement: .topBarLeading) {
                    Menu {
                        Picker("Primary", selection: $primarySortOption.animation()) {
                            ForEach(PrimarySort.allCases) { option in
                                Text(option.rawValue)
                                    .tag(option)
                            }
                        }
                        
                        Divider()
                        
                        Picker("Secondary", selection: $secondarySortOption.animation()) {
                            ForEach(SecondarySort.allCases) { option in
                                Text(option.rawValue)
                                    .tag(option)
                            }
                        }
                        
                    } label: {
                        Label("Sort", systemImage: "arrow.up.arrow.down")
                    }
                    
                    Menu {
                        
                        Button("All", systemImage: selectedGenre == nil ? "checkmark" : "") {
                            withAnimation {
                                selectedGenre = nil
                            }
                        }
                        
                        Divider()
                        
                        Picker("Genre", selection: $selectedGenre.animation()) {
                            ForEach(genres, id: \.self) { genre in
                                Text(genre)
                                    .tag(genre)
                            }
                        }
                        
                    } label: {
                        Label("Sort", systemImage: "line.3.horizontal.decrease")
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
                CreateMovieView()
            }
            .searchable(text: $searchText, prompt: "Search movies...")
        }
    }
}

#Preview {
    MoviesView()
        .modelContainer(PreviewContainer.container)
}
