//
//  CounterIntents.swift
//  Clicky
//
//  Created by Brandon Potts on 5/2/26.
//

#if os(iOS)
import ActivityKit
import AppIntents
import OSLog

struct ClickyWidgetAttributes: ActivityAttributes {
    struct ContentState: Codable, Hashable {
        var count: Int
    }

    var title: LocalizedStringResource
    var id: UUID
}


// MARK: Activity Intents

struct IncrementCounterIntent: LiveActivityIntent {
    static var title: LocalizedStringResource = "Increment counter"

    func perform() async throws -> some IntentResult {
        Logger.liveActivity.info("Performing increment counter")
        for activity in Activity<ClickyWidgetAttributes>.activities {
            let newState = ClickyWidgetAttributes.ContentState(count: activity.content.state.count + 1)
            await activity.update(ActivityContent(state: newState, staleDate: nil))
        }
        return .result()
    }
}

struct DecrementCounterIntent: LiveActivityIntent {
    static var title: LocalizedStringResource = "Decrement counter"

    func perform() async throws -> some IntentResult {
        Logger.liveActivity.info("Performing decrement counter")
        for activity in Activity<ClickyWidgetAttributes>.activities {
            let newState = ClickyWidgetAttributes.ContentState(count: max(0, activity.content.state.count - 1))
            await activity.update(ActivityContent(state: newState, staleDate: nil))
        }
        return .result()
    }
}

#endif
