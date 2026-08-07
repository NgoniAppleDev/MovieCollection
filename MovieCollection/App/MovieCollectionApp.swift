//
//  MovieCollectionApp.swift
//  MovieCollection
//
//  Created by Ngoni Katsidzira  on 6/8/2026.
//

import SwiftUI
import SwiftData

@main
struct MovieCollectionApp: App {
    
    let container: AppContainer
    
    init() {
        container = AppContainer()
    }

    var body: some Scene {
        WindowGroup {
            MoviesView(container: container)
                .modelContainer(container.modelContainer)
        }
    }
}
