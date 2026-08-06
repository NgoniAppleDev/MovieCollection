//
//  CreateMovieView.swift
//  MovieCollection
//
//  Created by Ngoni Katsidzira  on 6/8/2026.
//

import SwiftUI
import SwiftData

struct CreateMovieView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var title = ""
    @State private var genre = ""
    @State private var rating = 3
    @State private var isFavorite = false
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $title)
                TextField("Genre", text: $genre)
                Stepper("Rating: \(rating)", value: $rating, in: 1...5)
                Toggle("Favorite", isOn: $isFavorite)
            }
            .navigationTitle("New Movie")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save", role: .confirm, action: saveMovie)
                    .disabled(title.isTrimmedEmpty)
                }
            }
        }
    }
    
    private func saveMovie() {
        let movie = Movie(
            title: title, genre: genre, rating: rating, isFavorite: isFavorite
        )
        
        modelContext.insert(movie)
        
        dismiss()
    }
}

#Preview {
    CreateMovieView()
}
