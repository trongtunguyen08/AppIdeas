//
//  AppIdeaItemView.swift
//  AppIdeas
//
//  Created by Tu Nguyen on 28/6/24.
//

import SwiftUI
import SwiftData

struct AppIdeaItemView: View {
    @Environment(\.modelContext) var modelContext
    let idea: AppIdea
    
    var body: some View {
        NavigationLink(value: idea) {
            VStack(alignment: .leading) {
                Text(idea.name)
                
                if !idea.detailedDescription.isEmpty {
                    Text(idea.detailedDescription)
                        .textScale(.secondary)
                        .foregroundStyle(Color.secondary)
                }
            }
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
            Button("Archive", systemImage: idea.isArchived ? "archivebox.fill" : "archivebox") {
                idea.isArchived.toggle()
            }
            .sensoryFeedback(.decrease, trigger: idea.isArchived)
            .tint(.blue)
         
            Button("Delete", systemImage: "trash", role: .destructive) {
                modelContext.delete(idea)
            }
            .sensoryFeedback(.success, trigger: idea)
        }
        .swipeActions(edge: .leading, allowsFullSwipe: true) {
            Button(action: {
                idea.isFavorite.toggle()
            }, label: {
                Label("Favorite", systemImage: idea.isFavorite ? "star.fill" : "star.slash")
            })
            .tint(.yellow)
            .sensoryFeedback(.increase, trigger: idea.isFavorite)
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: AppIdea.self, configurations: config)
    
    let idea = AppIdea(name: "ABC", detailedDescription: "DEF", isArchived: false)
    return List(content: {
        AppIdeaItemView(idea: idea)
    })
    .modelContainer(container)
}
