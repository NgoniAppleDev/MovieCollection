//
//  MovieRepository.swift
//  MovieCollection
//
//  Created by Ngoni Katsidzira  on 7/8/2026.
//

import Foundation
import SwiftData

@MainActor
final class MovieRepository {
    
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func fetchMovies(using builder: MovieQueryBuilder) throws -> [Movie] {
        
        let descriptor = builder.build()
        
        return try context.fetch(descriptor)
    }
    
    func fetchMovieGenres(using builder: MovieQueryBuilder) throws -> [String] {
        let movies = try fetchMovies(using: builder)
        
        return movies.map { $0.genre }
    }
}
