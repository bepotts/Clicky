//
//  ClickyWidgetLiveActivity.swift
//  ClickyWidget
//
//  Created by Brandon Potts on 3/8/26.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct ClickyWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct ClickyWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: ClickyWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension ClickyWidgetAttributes {
    fileprivate static var preview: ClickyWidgetAttributes {
        ClickyWidgetAttributes(name: "World")
    }
}

extension ClickyWidgetAttributes.ContentState {
    fileprivate static var smiley: ClickyWidgetAttributes.ContentState {
        ClickyWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: ClickyWidgetAttributes.ContentState {
         ClickyWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: ClickyWidgetAttributes.preview) {
   ClickyWidgetLiveActivity()
} contentStates: {
    ClickyWidgetAttributes.ContentState.smiley
    ClickyWidgetAttributes.ContentState.starEyes
}
