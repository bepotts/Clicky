//
//  AppIntent.swift
//  ClickyWidget
//
//  Created by Brandon Potts on 3/8/26.
//

#if os(iOS)
import ActivityKit
import AppIntents
import os
import SwiftData
import WidgetKit

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource { "Configuration" }
    static var description: IntentDescription { "This is an example widget." }

    // An example configurable parameter.
    @Parameter(title: "Favorite Emoji", default: "😃")
    var favoriteEmoji: String
}

// MARK: - Live Activity App Intents

struct IncrementCounterIntent: LiveActivityIntent {
    static var title: LocalizedStringResource = "Increment counter"

    func perform() async throws -> some IntentResult {
        Logger.liveActivity.trace("Performing increment counter")
        guard let activity = Activity<ClickyWidgetAttributes>.activities.first else {
            Logger.liveActivity.error("Could not find an active widget activity to update")
            return .result()
        }
        let counterID = activity.attributes.id
        let context = ModelContext(ModelContainer.shared)
        let descriptor = FetchDescriptor<Counter>(predicate: #Predicate { $0.id == counterID })
        guard let counter = try context.fetch(descriptor).first else {
            Logger.liveActivity.error("Could not find counter with id \(counterID.uuidString) in SwiftData")
            return .result()
        }
        counter.increment()
        try context.save()
        let newState = ClickyWidgetAttributes.ContentState(count: counter.count)
        await activity.update(ActivityContent(state: newState, staleDate: nil))
        Logger.liveActivity.trace("Incremented counter to \(counter.count)")
        return .result()
    }
}

struct DecrementCounterIntent: LiveActivityIntent {
    static var title: LocalizedStringResource = "Decrement counter"

    func perform() async throws -> some IntentResult {
        Logger.liveActivity.trace("Performing decrement counter")
        guard let activity = Activity<ClickyWidgetAttributes>.activities.first else {
            Logger.liveActivity.error("Could not find an active widget activity to update")
            return .result()
        }
        let counterID = activity.attributes.id
        let context = ModelContext(ModelContainer.shared)
        let descriptor = FetchDescriptor<Counter>(predicate: #Predicate { $0.id == counterID })
        guard let counter = try context.fetch(descriptor).first else {
            Logger.liveActivity.error("Could not find counter with id \(counterID.uuidString) in SwiftData")
            return .result()
        }
        counter.decrement()
        try context.save()
        let newState = ClickyWidgetAttributes.ContentState(count: counter.count)
        await activity.update(ActivityContent(state: newState, staleDate: nil))
        Logger.liveActivity.trace("Decremented counter to \(counter.count)")
        return .result()
    }
}

#endif
