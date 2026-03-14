//
//  AppIntent.swift
//  ClickyWidget
//
//  Created by Brandon Potts on 3/8/26.
//

import ActivityKit
import AppIntents
import WidgetKit
import os

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
        Logger.liveActivity.trace("Found an activity to update")
        let newCount = activity.content.state.count + 1
        let newState = ClickyWidgetAttributes.ContentState(count: newCount)
        await activity.update(ActivityContent(state: newState, staleDate: nil))
        Logger.liveActivity.trace("Updated activity")
        return .result()
    }
}

struct DecrementCounterIntent: LiveActivityIntent {
    static var title: LocalizedStringResource = "Decrement counter"

    func perform() async throws -> some IntentResult {
        guard let activity = Activity<ClickyWidgetAttributes>.activities.first else {
            return .result()
        }
        let currentCount = activity.content.state.count
        let newCount = max(0, currentCount - 1)
        let newState = ClickyWidgetAttributes.ContentState(count: newCount)
        await activity.update(ActivityContent(state: newState, staleDate: nil))
        return .result()
    }
}
