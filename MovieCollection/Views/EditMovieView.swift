//
//  EditMovieView.swift
//  MovieCollection
//
//  Created by Ngoni Katsidzira  on 7/8/2026.
//

import SwiftUI
import SwiftData

struct EditMovieView: View {
    
    @Bindable var movie: Movie
    let viewModel: MovieViewModel
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Form {
            Section("Title") {
                TextField("Title", text: $movie.title)
            }
            
            Section("Genre") {
                TextField("Genre", text: $movie.genre)
            }
            
            Section {
                Stepper("Rating: \(movie.rating)", value: $movie.rating, in: 1...5)
                Toggle("Favorite", isOn: $movie.isFavorite)
            }
            
            Section("Created on") {
                Text(movie.createdAt.formatted(date: .abbreviated, time: .shortened))
            }
        }
        .navigationTitle("Edit Movie")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .destructiveAction) {
                Button("Delete", role: .destructive) {
                    modelContext.delete(movie)
                    viewModel.fetchMovies()
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        EditMovieView(
            movie: PreviewContainer.movieSample,
            viewModel: .init(repository: PreviewContainer.repository)
        )
        .modelContainer(
            PreviewContainer.container
        )
    }
}
