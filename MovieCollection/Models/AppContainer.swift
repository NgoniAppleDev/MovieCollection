//
//  AppContainer.swift
//  MovieCollection
//
//  Created by Ngoni Katsidzira  on 7/8/2026.
//

import SwiftData

final class AppContainer {
    
    let modelContainer: ModelContainer
    let movieRepository: MovieRepository
    
    init(modelContainer: ModelContainer? = nil, movieRepository: MovieRepository? = nil) {
        
        guard let modelContainer, let movieRepository else {
            
            let container = try! ModelContainer(
                for: Movie.self
            )
            
            self.modelContainer = container
            
            self.movieRepository = MovieRepository(
                context: container.mainContext
            )
            
            return
        }
        
        self.modelContainer = modelContainer
        self.movieRepository = movieRepository
    }
}
