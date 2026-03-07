//
//  ClickyApp.swift
//  Clicky
//
//  Created by Brandon Potts on 3/4/26.
//

import SwiftData
import SwiftUI

@main
struct ClickyApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
            Counter.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            CounterListView()
        }
        .modelContainer(sharedModelContainer)
    }
}
