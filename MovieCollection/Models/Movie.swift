//
//  Movie.swift
//  MovieCollection
//
//  Created by Ngoni Katsidzira  on 6/8/2026.
//

import Foundation
import SwiftData

@Model
final class Movie {
    
    var title: String
    var genre: String
    var rating: Int
    var isFavorite: Bool
    var createdAt: Date
    
    init(title: String, genre: String, rating: Int, isFavorite: Bool = false, createdAt: Date = .now) {
        self.title = title
        self.genre = genre
        self.rating = rating
        self.isFavorite = isFavorite
        self.createdAt = createdAt
    }
}
