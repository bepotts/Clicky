//
//  CreateCounterSheet.swift
//  Clicky
//
//  Created by Brandon Potts on 3/4/26.
//

import ActivityKit
import SwiftData
import SwiftUI
import os

struct CreateCounterSheet: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Bindable var counter: Counter
    let onCreated: () -> Void

    @State private var liveView = false

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Name of new Counter")
                .frame(maxWidth: .infinity)
            TextField("Name", text: $counter.name)
                .textFieldStyle(.roundedBorder)
            Text("Increment By")
                .frame(maxWidth: .infinity)
            TextField("Increment By", value: $counter.incrementBy, format: .number)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.numberPad)
            Text("Starting Count")
                .frame(maxWidth: .infinity)
            TextField("Starting Count", value: $counter.count, format: .number)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.numberPad)
            Toggle("Live View", isOn: $liveView)
            Button("Done") {
                modelContext.insert(counter)
                try? modelContext.save()
                if liveView {
                    Logger.liveActivity.info(
                        "Starting live activity for counter '\(self.counter.name)' with id \(self.counter.id.uuidString)"
                    )
                    let attributes = ClickyWidgetAttributes(title: counter.name, id: counter.id)
                    let content = ActivityContent(
                        state: ClickyWidgetAttributes.ContentState(count: counter.count),
                        staleDate: nil
                    )
                    do {
                        let info = ActivityAuthorizationInfo()
                        Logger.liveActivity.info("areActivitiesEnabled = \(info.areActivitiesEnabled)")

                        let activity = try Activity<ClickyWidgetAttributes>.request(
                            attributes: attributes,
                            content: content
                        )

                        Logger.liveActivity.info("Started live activity: \(activity.id)")
                    } catch {
                        Logger.liveActivity.error("Failed to start live activity: \(error.localizedDescription)")
                    }
                }
                onCreated()
                dismiss()
            }
            .frame(maxWidth: .infinity)
        }
        .padding()
    }
}
