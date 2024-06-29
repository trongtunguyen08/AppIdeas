//
//  AppIdeasWidgets.swift
//  AppIdeasWidgets
//
//  Created by Tu Nguyen on 29/6/24.
//

import WidgetKit
import SwiftUI
import SwiftData

struct Provider: TimelineProvider {
    @MainActor
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), appIdeas: getAppIdeas())
    }

    @MainActor
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), appIdeas: getAppIdeas())
        completion(entry)
    }

    @MainActor
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let timeline = Timeline(entries: [SimpleEntry(date: .now, appIdeas: getAppIdeas())], policy: .after(.now.advanced(by: 60 )))
        
        completion(timeline)
    }
    
    @MainActor
    func getAppIdeas() -> [AppIdea] {
        let config = ModelConfiguration(isStoredInMemoryOnly: false)
        guard let container = try? ModelContainer(for: AppIdea.self, configurations: config)
        else {
            return []
        }
        
        let descriptor = FetchDescriptor<AppIdea>(predicate: #Predicate {idea in
            idea.isArchived == false
        })
        let appIdeas = try? container.mainContext.fetch(descriptor)
        
        print(appIdeas!)
        
        return appIdeas ?? []
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let appIdeas: [AppIdea]
}

struct AppIdeasWidgetsEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            ForEach(entry.appIdeas) { idea in
                Button(intent: ToggleFavoriteIntent(appIdeaName: idea.name)) {
                    HStack {
                        Image(systemName: idea.isFavorite ? "star.fill" : "star")
                            .foregroundStyle(Color.yellow)
                        
                        Spacer()
                        
                        Text(idea.name)
                    }
                }
            }
        }
    }
}

struct AppIdeasWidgets: Widget {
    let kind: String = "AppIdeasWidgets"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                AppIdeasWidgetsEntryView(entry: entry)
                    .containerBackground(.background, for: .widget)
            } else {
                AppIdeasWidgetsEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("App Ideas Widget")
        .description("This is an example widget.")
    }
}
