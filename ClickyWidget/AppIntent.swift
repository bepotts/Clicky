//
//  AppIntent.swift
//  ClickyWidget
//
//  Created by Brandon Potts on 3/8/26.
//

#if os(iOS)
import ActivityKit
import AppIntents
import OSLog
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
        let count = activity.content.state.count
        let newState = ClickyWidgetAttributes.ContentState(count: count + 1)
        await activity.update(ActivityContent(state: newState, staleDate: nil))
        Logger.liveActivity.trace("Incremented counter to \(newState.count)")
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
        let count = activity.content.state.count
        let newState = ClickyWidgetAttributes.ContentState(count: max(0, count - 1))
        await activity.update(ActivityContent(state: newState, staleDate: nil))
        Logger.liveActivity.trace("Decremented counter to \(newState.count)")
        return .result()
    }
}

#endif
