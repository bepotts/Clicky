//
//  ActivityUtils.swift
//  Clicky
//
//  Created by Brandon Potts on 3/10/26.
//

import Foundation
import SwiftData

private let sharedModelContainer: ModelContainer = {
    let schema = Schema([Counter.self])
    let configuration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
    do {
        return try ModelContainer(for: schema, configurations: [configuration])
    } catch {
        fatalError("Could not create ModelContainer: \(error)")
    }
}()

/// Creates and returns a new ModelContext using the shared model container.
func createModelContext() -> ModelContext {
    ModelContext(sharedModelContainer)
}

/// Fetches the counter with the given UUID, increments its count, saves, and returns the new count.
/// - Parameters:
///   - id: The unique identifier of the counter.
///   - modelContext: The SwiftData model context to use for fetch and save.
/// - Returns: The new count after incrementing, or `nil` if no counter was found for the UUID.
func incrementCounter(id: UUID, modelContext: ModelContext) throws -> Int? {
    let descriptor = FetchDescriptor<Counter>(
        predicate: #Predicate<Counter> { $0.id == id }
    )
    let counters = try modelContext.fetch(descriptor)
    guard let counter = counters.first else {
        return nil
    }
    counter.increment()
    try modelContext.save()
    return counter.count
}
