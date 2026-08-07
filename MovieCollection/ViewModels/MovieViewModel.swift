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
    
    var searchText = "" {
        didSet {
            fetchMovies()
        }
    }
    var genre: String? {
        didSet {
            fetchMovies()
        }
    }
    var favoritesOnly = false {
        didSet {
            fetchMovies()
        }
    }
    var primarySort: PrimarySort = .title {
        didSet {
            fetchMovies()
        }
    }
    var secondarySort: SecondarySort = .newest {
        didSet {
            fetchMovies()
        }
    }
    
    var genres: [String] = []
    
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
            genres = Array(Set(fetchMovieGenres())).sorted()
        } catch {
            print("Failed to fetch movies: \(error.localizedDescription)")
        }
    }
    
    func add(_ movie: Movie) {
        do {
            try repository.add(movie)
            fetchMovies()
        } catch {
            print("Failed to add movie: \(error.localizedDescription)")
        }
    }
    
    private func fetchMovieGenres() -> [String] {
        
        let builder = MovieQueryBuilder()
        
        do {
            
            return try repository.fetchMovieGenres(using: builder)
        } catch {
            print("Failed to fetch movies: \(error.localizedDescription)")
            return []
        }
    }
}
