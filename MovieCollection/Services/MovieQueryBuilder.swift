//
//  MovieQueryBuilder.swift
//  MovieCollection
//
//  Created by Ngoni Katsidzira  on 7/8/2026.
//

import Foundation
import SwiftData

struct MovieQueryBuilder {
    
    var searchText = ""
    var genre: String = "All"
    var favoritesOnly = false
    
    var primarySort: PrimarySort = .title
    var secondarySort: SecondarySort = .newest
    
    func build() -> FetchDescriptor<Movie> {
        
        let predicate = #Predicate<Movie> {
            (searchText.isTrimmedEmpty ||
             $0.title.localizedStandardContains(searchText)
            )
            &&
            (genre == "All" || $0.genre == genre)
            &&
            (!favoritesOnly || $0.isFavorite)
        }
        
        return FetchDescriptor<Movie>(
            predicate: predicate,
            sortBy: [primarySort.sortDescriptor, secondarySort.sortDescriptor]
        )
    }
}
