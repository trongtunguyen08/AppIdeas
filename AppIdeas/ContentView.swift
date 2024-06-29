//
//  ContentView.swift
//  AppIdeas
//
//  Created by Tu Nguyen on 27/6/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query(filter: #Predicate<AppIdea>{$0.isArchived == false}, sort: \.creationDate, animation: .easeInOut) private var listIdeas: [AppIdea]
    @Query(filter: #Predicate<AppIdea>{$0.isFavorite && $0.isArchived == false}, sort: \.creationDate, animation: .easeInOut) private var favoriteIdeas: [AppIdea]
    @Query(filter: #Predicate<AppIdea>{$0.isArchived}, sort: \.creationDate, animation: .easeInOut) private var archivedIdeas: [AppIdea]
    @State private var showAddModal: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                if favoriteIdeas.isEmpty == false {
                    Section("Favorites") {
                        ForEach(favoriteIdeas) { idea in
                            AppIdeaItemView(idea: idea)
                        }
                    }
                }
                
                if listIdeas.isEmpty == false {
                    Section("All") {
                        ForEach(listIdeas) { idea in
                            AppIdeaItemView(idea: idea)
                        }
                    }
                }
                
                if archivedIdeas.isEmpty == false {
                    Section("Archived") {
                        ForEach(archivedIdeas) { idea in
                            AppIdeaItemView(idea: idea)
                        }
                    }
                }
            }
            .overlay(content: {
                if listIdeas.isEmpty && favoriteIdeas.isEmpty && archivedIdeas.isEmpty {
                    emptyView
                }
            })
            .navigationTitle("App Ideas")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add", systemImage: "plus.circle") {
                        self.showAddModal = true
                    }
                }
            }
            .sheet(isPresented: $showAddModal, content: {
                AddNewIdeaView()
                    .presentationDetents([.medium])
            })
            .navigationDestination(for: AppIdea.self) { EditAppIdeaView(idea: $0) }
        }
    }
}

extension ContentView {
    private var emptyView: some View {
        ContentUnavailableView(label: {
            Label("No App Ideas", systemImage: "square.stack.3d.up.slash")
            Text("Please add an app idea to get started")
                .font(.caption)
                .foregroundStyle(Color.gray) 
        })
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [AppIdea.self, AppFeature.self])
}
