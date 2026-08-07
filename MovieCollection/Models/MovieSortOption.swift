//
//  MovieSortOption.swift
//  MovieCollection
//
//  Created by Ngoni Katsidzira  on 7/8/2026.
//

import Foundation

enum MovieSortOption: String, CaseIterable, Identifiable {
    case title = "Title"
    case rating = "Rating"
    case newest = "Newest"
    case oldest = "Oldest"
    
    var id: Self { self }
}
