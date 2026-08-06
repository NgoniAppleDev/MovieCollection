//
//  PreviewContainer.swift
//  MovieCollection
//
//  Created by Ngoni Katsidzira  on 6/8/2026.
//

import Foundation
import SwiftData

@MainActor
enum PreviewContainer {
    
    static let container: ModelContainer = {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(
                for: Movie.self,
                configurations: config
            )
            
            let context = container.mainContext
            
            let movies = [
                Movie(title: "Interstellar", genre: "Sci-Fi", rating: 5, isFavorite: true),
                Movie(title: "Inception", genre: "Sci-Fi", rating: 5, isFavorite: true),
                Movie(title: "The Dark Knight", genre: "Action", rating: 5),
                Movie(title: "Whiplash", genre: "Drama", rating: 5),
                Movie(title: "Your Name", genre: "Anime", rating: 5, isFavorite: true),
                Movie(title: "Hello World", genre: "Anime", rating: 4),
                Movie(title: "Spirited Away", genre: "Anime", rating: 5),
                Movie(title: "The Matrix", genre: "Sci-Fi", rating: 5),
                Movie(title: "Parasite", genre: "Thriller", rating: 5),
                Movie(title: "Top Gun: Maverick", genre: "Action", rating: 4)
            ]
            
            movies.forEach {
                context.insert($0)
            }
            
            return container
            
        } catch {
            fatalError("Failed to create preview container: \(error)")
        }
    }()
}
