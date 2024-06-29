//
//  AppIdeasApp.swift
//  AppIdeas
//
//  Created by Tu Nguyen on 27/6/24.
//

import SwiftUI
import SwiftData

@main
struct AppIdeasApp: App {
    private var container: ModelContainer {
        let config = ModelConfiguration(isStoredInMemoryOnly: false)
        let schema = Schema([AppIdea.self, AppFeature.self])
        let container = try! ModelContainer(for: schema, configurations: config)
        
        return container
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
    }
}
