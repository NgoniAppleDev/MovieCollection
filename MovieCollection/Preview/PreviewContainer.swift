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
    
    private static func randomDate(daysAgo: Int) -> Date {
        Calendar.current.date(
            byAdding: .day,
            value: -daysAgo,
            to: .now
        )!
    }
    
    static let container: ModelContainer = {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(
                for: Movie.self,
                configurations: config
            )
            
            let context = container.mainContext
            
            let movies = [
                Movie(
                    title: "Interstellar",
                    genre: "Sci-Fi",
                    rating: 5,
                    isFavorite: true,
                    createdAt: randomDate(daysAgo: 2)
                ),
                Movie(
                    title: "Inception",
                    genre: "Sci-Fi",
                    rating: 5,
                    isFavorite: true,
                    createdAt: randomDate(daysAgo: 15)
                ),
                Movie(
                    title: "The Dark Knight",
                    genre: "Action",
                    rating: 5,
                    createdAt: randomDate(daysAgo: 7)
                ),
                Movie(
                    title: "Whiplash",
                    genre: "Drama",
                    rating: 5,
                    createdAt: randomDate(daysAgo: 30)
                ),
                Movie(
                    title: "Your Name",
                    genre: "Anime",
                    rating: 5,
                    isFavorite: true,
                    createdAt: randomDate(daysAgo: 5)
                ),
                Movie(
                    title: "Hello World",
                    genre: "Anime",
                    rating: 4,
                    createdAt: randomDate(daysAgo: 20)
                ),
                Movie(
                    title: "Spirited Away",
                    genre: "Anime",
                    rating: 5,
                    createdAt: randomDate(daysAgo: 1)
                ),
                Movie(
                    title: "The Matrix",
                    genre: "Sci-Fi",
                    rating: 5,
                    createdAt: randomDate(daysAgo: 45)
                ),
                Movie(
                    title: "Parasite",
                    genre: "Thriller",
                    rating: 5,
                    createdAt: randomDate(daysAgo: 12)
                ),
                Movie(
                    title: "Top Gun: Maverick",
                    genre: "Action",
                    rating: 4,
                    createdAt: randomDate(daysAgo: 60)
                )
            ]
            
            movies.forEach {
                context.insert($0)
            }
            
            return container
            
        } catch {
            fatalError("Failed to create preview container: \(error)")
        }
    }()
    
    static let context: ModelContext = container.mainContext
    
    static let repository: MovieRepository = .init(context: context)
    
    static let movieSample: Movie = {
        let movies = try? container.mainContext.fetch(FetchDescriptor<Movie>())
        return movies?.first ?? Movie(title: "Interstellar", genre: "Sci-Fi", rating: 5, isFavorite: true)
    }()
}
