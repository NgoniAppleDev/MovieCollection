//
//  MovieViewModel.swift
//  MovieCollection
//
//  Created by Ngoni Katsidzira  on 7/8/2026.
//

import Foundation
import SwiftData
import Observation

@MainActor @Observable
final class MovieViewModel {
    
    private let repository: MovieRepository
    
    var movies: [Movie] = []
    
    var searchText = ""
    var genre: String? = "All"
    var favoritesOnly = false
    var primarySort: PrimarySort = .title
    var secondarySort: SecondarySort = .newest
    
    init(repository: MovieRepository) {
        self.repository = repository
    }
    
    func fetchMovies() {
        
        let builder = MovieQueryBuilder(
            searchText: searchText,
            genre: genre ?? "All",
            favoritesOnly: favoritesOnly,
            primarySort: primarySort,
            secondarySort: secondarySort
        )
        
        do {
            
            movies = try repository.fetchMovies(using: builder)
        } catch {
            print("Failed to fetch movies: \(error.localizedDescription)")
        }
    }
}
