//
//  CounterViewListItem.swift
//  Increment
//
//  Created by Brandon Potts on 3/7/26.
//

import OSLog
import SwiftData
import SwiftUI

struct CounterViewListItem: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.analyticsClient) private var analyticsClient
    @Bindable var counter: Counter
    var onLongPress: () -> Void
    private var accessibilitySuffix: String {
        counter.name
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()
            .replacingOccurrences(of: " ", with: "-")
    }

    var body: some View {
        HStack {
            Button("-") { Task { await decrement() } }
                .buttonStyle(.borderless)
                .accessibilityLabel("Decrement")
                .accessibilityIdentifier("counter-list-item-decrement-\(accessibilitySuffix)")
            Spacer()
            VStack(alignment: .leading, spacing: 40) {
                Text(counter.localizedName)
                    .accessibilityIdentifier("counter-list-item-name-\(accessibilitySuffix)")
                Text("\(counter.count)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .accessibilityIdentifier("counter-list-item-count-\(accessibilitySuffix)")
            }
            Spacer()
            Button("+") { Task { await increment() } }
                .buttonStyle(.borderless)
                .accessibilityLabel("Increment")
                .accessibilityIdentifier("counter-list-item-increment-\(accessibilitySuffix)")
        }
        .onLongPressGesture(perform: onLongPress)
    }

    private func increment() async {
        do {
            try await CounterStore(context: modelContext).updateLiveActivity(for: counter.id, operation: .increment)
            analyticsClient.logEvent(.incrementFromApp, parameters: nil)
        } catch {
            Logger.storage.error("Failed to increment counter: \(error)")
        }
    }

    private func decrement() async {
        do {
            try await CounterStore(context: modelContext).updateLiveActivity(for: counter.id, operation: .decrement)
            analyticsClient.logEvent(.decrementFromApp, parameters: nil)
        } catch {
            Logger.storage.error("Failed to decrement counter: \(error)")
        }
    }
}

#Preview {
    CounterViewListItem(counter: Counter(count: 42, name: "Sample"), onLongPress: {})
}
