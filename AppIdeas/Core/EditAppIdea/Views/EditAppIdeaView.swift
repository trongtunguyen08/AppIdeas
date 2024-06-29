//
//  EditAppIdeaView.swift
//  AppIdeas
//
//  Created by Tu Nguyen on 27/6/24.
//

import SwiftUI
import SwiftData

struct EditAppIdeaView: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var idea: AppIdea
    @State private var newFeatureDescription: String = ""
    
    var body: some View {
        Form {
            TextField("Name", text: $idea.name)
            TextField("Description", text: $idea.detailedDescription)
            
            Section("Features") {
                TextField("Feature", text: $newFeatureDescription)
                    .onSubmit {
                        let feature = AppFeature(detailedDescription: newFeatureDescription)
                        idea.features.append(feature)
                        self.newFeatureDescription.removeAll()
                    }
                ForEach(idea.features) { feature in
                    Text(feature.detailedDescription)
                        .contextMenu(ContextMenu(menuItems: {
                            Button("Delete", systemImage: "trash", role: .destructive) {
                                idea.features.removeAll(where: {$0.detailedDescription == feature.detailedDescription})
                                modelContext.delete(feature)
                            }
                        }))
                }
            }
        }
        .navigationTitle("Edit App Idea")
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let schema = Schema([AppIdea.self, AppFeature.self])
    let container = try! ModelContainer(for: schema, configurations: config)
    
    let idea = AppIdea(name: "ABC", detailedDescription: "DEF", isArchived: false)
    
    return EditAppIdeaView(idea: idea)
}
