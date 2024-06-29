//
//  ToggleFavoriteIntent.swift
//  AppIdeasWidgetsExtension
//
//  Created by Tu Nguyen on 29/6/24.
//

import Foundation
import SwiftData
import AppIntents

struct ToggleFavoriteIntent: AppIntent {
    static var title: LocalizedStringResource = "Toggle Favorite"
    static var description: IntentDescription? = "Toggles wether an app idea is favoried"
    
    @Parameter(title: "App Idea Name")
    var appIdeaName: String
    
    init(appIdeaName: String) {
        self.appIdeaName = appIdeaName
    }
    
    init() {
        self.appIdeaName = ""
    }
    
    @MainActor
    func perform() async throws -> some IntentResult {
        let config = ModelConfiguration(isStoredInMemoryOnly: false)
        let container = try? ModelContainer(for: AppIdea.self, configurations: config)
        let descriptor = FetchDescriptor<AppIdea>(predicate: #Predicate{$0.name == appIdeaName})
        let ideas = try? container?.mainContext.fetch(descriptor)
        
        guard let modelContainer = container,
              let appIdeas = ideas,
              let idea = ideas?.first
        else {
            return .result()
        }
        
        let isFavorite = idea.isFavorite
        idea.isFavorite = !isFavorite
        
        return .result()
    }
}
