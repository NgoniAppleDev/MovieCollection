//
//  PrimarySort.swift
//  MovieCollection
//
//  Created by Ngoni Katsidzira  on 7/8/2026.
//

import SwiftData
import Foundation

enum PrimarySort: String, CaseIterable, Identifiable {
    
    case title = "Title"
    case rating = "Rating"
    
    var id: Self { self }
    
    var sortDescriptor: SortDescriptor<Movie> {
        switch self {
        case .title:
            SortDescriptor(\Movie.title)
        case .rating:
            SortDescriptor(\Movie.rating, order: .reverse)
        }
    }
}
