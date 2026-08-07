//
//  SecondarySort.swift
//  MovieCollection
//
//  Created by Ngoni Katsidzira  on 7/8/2026.
//

import Foundation
import SwiftData

enum SecondarySort: String, CaseIterable, Identifiable {
    
    case newest = "Newest"
    case oldest = "Oldest"
    
    var id: Self { self }
    
    var sortDescriptor: SortDescriptor<Movie> {
        switch self {
        case .newest:
            SortDescriptor(\Movie.createdAt, order: .reverse)
        case .oldest:
            SortDescriptor(\Movie.createdAt)
        }
    }
}
