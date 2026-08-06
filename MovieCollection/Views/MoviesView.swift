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
    
    var body: some View {
        NavigationStack {
            List(movies) { movie in
                MovieRow(movie: movie)
            }
            .navigationTitle("Movies")
        }
    }
}

#Preview {
    MoviesView()
        .modelContainer(PreviewContainer.container)
}
