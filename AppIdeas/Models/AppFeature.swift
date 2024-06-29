//
//  Feature.swift
//  AppIdeas
//
//  Created by Tu Nguyen on 27/6/24.
//

import Foundation
import SwiftData

@Model
class AppFeature {
    @Attribute(.unique) var detailedDescription: String
    var creationDate: Date
    
    init(detailedDescription: String) {
        self.detailedDescription = detailedDescription
        self.creationDate = .now
    }
}
