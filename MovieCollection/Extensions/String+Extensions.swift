//
//  String+Extensions.swift
//  MovieCollection
//
//  Created by Ngoni Katsidzira  on 6/8/2026.
//

import Foundation

extension String {
    var trimmed: String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var isTrimmedEmpty: Bool {
        trimmed.isEmpty
    }
}
