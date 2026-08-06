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
    
    @State private var showingCreateMovie = false
    
    var body: some View {
        NavigationStack {
            List(movies) { movie in
                MovieRow(movie: movie)
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
        }
    }
}

#Preview {
    MoviesView()
        .modelContainer(PreviewContainer.container)
}
