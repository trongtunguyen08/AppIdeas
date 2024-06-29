//
//  Idea.swift
//  AppIdeas
//
//  Created by Tu Nguyen on 27/6/24.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class AppIdea {
    @Attribute(.unique) var name: String
    var detailedDescription: String
    var creationDate: Date
    var isArchived: Bool = false
    var isFavorite: Bool = false
    
    init(name: String, detailedDescription: String, isArchived: Bool = false, isFavorite: Bool = false) {
        self.name = name
        self.detailedDescription = detailedDescription
        self.creationDate = .now
        self.isArchived = false
        self.isFavorite = false
    }
    
    @Relationship(deleteRule: .cascade) var features: [AppFeature] = []
}
