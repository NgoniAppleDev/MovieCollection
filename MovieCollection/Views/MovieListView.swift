//
//  MovieListView.swift
//  MovieCollection
//
//  Created by Ngoni Katsidzira  on 7/8/2026.
//

import SwiftUI
import SwiftData

struct MovieListView: View {

    @State private var viewModel: MovieViewModel
    @Environment(\.modelContext) private var modelContext
    
    init(viewModel: MovieViewModel) {
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        List {
            if viewModel.movies.isEmpty {
                ContentUnavailableView("No movies found.", systemImage: "movieclapper")
            } else {
                
                ForEach(viewModel.movies) { movie in
                    NavigationLink(value: movie) {
                        MovieRow(movie: movie)
                    }
                }
                .onDelete(perform: deleteMovies)
            }
        }
        .navigationDestination(for: Movie.self) { movie in
            EditMovieView(movie: movie, viewModel: viewModel)
        }
        .task {
            viewModel.fetchMovies()
        }
    }
    
    private func deleteMovies(at offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(viewModel.movies[index])
            }
            
            viewModel.fetchMovies()
        }
    }
    
}

#Preview {
    NavigationStack {
        MovieListView(
            viewModel: .init(repository:
                    .init(context: PreviewContainer.container.mainContext)
            )
        )
        .modelContainer(PreviewContainer.container)
    }
}
