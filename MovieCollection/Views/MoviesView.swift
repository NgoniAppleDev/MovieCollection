//
//  MoviesView.swift
//  MovieCollection
//
//  Created by Ngoni Katsidzira  on 6/8/2026.
//

import SwiftUI
import SwiftData

struct MoviesView: View {
    
    @Query(sort: \Movie.title) private var movies: [Movie]
    @Environment(\.modelContext) private var modelContext
    @State private var showingCreateMovie = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(movies) { movie in
                    NavigationLink(value: movie) {
                        MovieRow(movie: movie)
                    }
                }
                .onDelete(perform: deleteMovies)
            }
            .navigationTitle("Movies")
            .toolbar {
                Button {
                    showingCreateMovie = true
                } label: {
                    Label("Add Movie", systemImage: "plus")
                }
            }
            .sheet(isPresented: $showingCreateMovie) {
                CreateMovieView()
            }
            .navigationDestination(for: Movie.self) { movie in
                EditMovieView(movie: movie)
            }
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
    MoviesView()
        .modelContainer(PreviewContainer.container)
}
