//
//  MoviesView.swift
//  MovieCollection
//
//  Created by Ngoni Katsidzira  on 6/8/2026.
//

import SwiftUI
import SwiftData

struct MoviesView: View {
    
    @State private var showingCreateMovie = false
    
    @State private var primarySortOption: PrimarySort = .title
    @State private var secondarySortOption: SecondarySort = .newest
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            MovieListView(
                primarySortOption: primarySortOption,
                secondarySortOption: secondarySortOption,
                searchText: searchText
            )
            .navigationTitle("Movies")
            .toolbar {
                
                ToolbarItem(placement: .topBarLeading) {
                    Menu {
                        Picker("Primary", selection: $primarySortOption.animation()) {
                            ForEach(PrimarySort.allCases) { option in
                                Text(option.rawValue)
                                    .tag(option)
                            }
                        }
                        
                        Divider()
                        
                        Picker("Secondary", selection: $secondarySortOption.animation()) {
                            ForEach(SecondarySort.allCases) { option in
                                Text(option.rawValue)
                                    .tag(option)
                            }
                        }
                        
                    } label: {
                        Label("Sort", systemImage: "arrow.up.arrow.down")
                    }
                }
                
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showingCreateMovie = true
                    } label: {
                        Label("Add Movie", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingCreateMovie) {
                CreateMovieView()
            }
            .searchable(text: $searchText, prompt: "Search movies...")
        }
    }
}

#Preview {
    MoviesView()
        .modelContainer(PreviewContainer.container)
}
