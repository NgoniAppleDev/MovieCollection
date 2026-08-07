//
//  MovieListView.swift
//  MovieCollection
//
//  Created by Ngoni Katsidzira  on 7/8/2026.
//

import SwiftUI
import SwiftData

struct MovieListView: View {
    
    @Query(sort: \Movie.title) private var movies: [Movie]
    @Environment(\.modelContext) private var modelContext
    
    init(
        primarySortOption: PrimarySort,
        secondarySortOption: SecondarySort,
        searchText: String,
        genreFilter: String = "All"
    ) {
        
        let sortOptions = [
            primarySortOption.sortDescriptor,
            secondarySortOption.sortDescriptor
        ]
        
        if genreFilter == "All" {
            
            _movies = Query(
                filter: #Predicate<Movie> {
                    searchText.isTrimmedEmpty ||
                    $0.title.localizedStandardContains(searchText)
                },
                sort: sortOptions
            )
        } else {
            
            _movies = Query(
                filter: #Predicate<Movie> {
                    (searchText.isTrimmedEmpty ||
                     $0.title.localizedStandardContains(searchText)
                    ) &&
                    $0.genre == genreFilter
                },
                sort: sortOptions
            )
        }
        
    }
    
    var body: some View {
        List {
            if movies.isEmpty {
                ContentUnavailableView("No movies found.", systemImage: "movieclapper")
            } else {
                
                ForEach(movies) { movie in
                    NavigationLink(value: movie) {
                        MovieRow(movie: movie)
                    }
                }
                .onDelete(perform: deleteMovies)
            }
        }
        .navigationDestination(for: Movie.self) { movie in
            EditMovieView(movie: movie)
        }
    }
    
    private func deleteMovies(at offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(movies[index])
            }
        }
    }
    
}

#Preview {
    NavigationStack {
        MovieListView(
            primarySortOption: .rating,
            secondarySortOption: .newest,
            searchText: "",
            genreFilter: "All"
        )
        .modelContainer(PreviewContainer.container)
    }
}
