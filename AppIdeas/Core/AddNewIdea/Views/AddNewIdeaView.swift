//
//  AddNewIdeaView.swift
//  AppIdeas
//
//  Created by Tu Nguyen on 27/6/24.
//

import SwiftUI
import SwiftData

struct AddNewIdeaView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var description: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                TextField("Description", text: $description)
            }
            .navigationTitle("Add New Idea")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Close", systemImage: "xmark") {
                        dissmissView()
                    }
                }
                
                if !name.isEmpty {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Save") {
                            let item = AppIdea(name: name, detailedDescription: description)
                            
                            modelContext.insert(item)
                            
                            dissmissView()
                        }
                    }
                    
                }
            }
        }
    }
    
    private func dissmissView() {
        dismiss()
    }
}

#Preview {
    AddNewIdeaView()
        .modelContainer(for: [AppIdea.self, AppFeature.self])
}
