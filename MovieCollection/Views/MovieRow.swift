//
//  MovieRow.swift
//  MovieCollection
//
//  Created by Ngoni Katsidzira  on 6/8/2026.
//

import SwiftUI

struct MovieRow: View {
    
    let movie: Movie
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    if movie.isFavorite {
                        Image(systemName: "heart.fill")
                            .foregroundStyle(.red.gradient)
                    }
                    
                    Text(movie.title)
                        .font(.headline)
                }
                
                Text(movie.genre)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                Text(movie.createdAt, style: .date)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
            }
            
            Spacer()
            
            Text(String(repeating: "★", count: movie.rating))
                .font(.caption)
                .foregroundStyle(.orange)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    MovieRow(movie: PreviewContainer.movieSample)
        .padding()
}
