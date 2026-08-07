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
    
    init(primarySortOption: PrimarySort, secondarySortOption: SecondarySort) {
        _movies = Query(
            sort: [
                primarySortOption.sortDescriptor,
                secondarySortOption.sortDescriptor
            ]
        )
    }
    
    var body: some View {
        List {
            ForEach(movies) { movie in
                NavigationLink(value: movie) {
                    MovieRow(movie: movie)
                }
            }
            .onDelete(perform: deleteMovies)
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
            primarySortOption: .rating, secondarySortOption: .newest
        )
        .modelContainer(PreviewContainer.container)
    }
}
