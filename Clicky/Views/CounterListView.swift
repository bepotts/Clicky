//
//  CounterListView.swift
//  Clicky
//
//  Created by Brandon Potts on 3/4/26.
//

import OSLog
import SwiftData
import SwiftUI

struct CounterListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var counters: [Counter]
    @State private var selectedCounter: Counter?

    var body: some View {
        NavigationStack {
            Group {
                if counters.isEmpty {
                    ContentUnavailableView {
                        Label("No Counters", systemImage: "number.square")
                    } description: {
                        Text("Tap the + button to create your first counter.")
                    }
                } else {
                    List(counters) { counter in
                        Button {
                            // TODO: Navigate to CounterView
                        } label: {
                            CounterViewListItem(counter: counter, onLongPress: { editCounter(counter) })
                        }
                        .buttonStyle(.plain)
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                deleteCounter(counter)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Add Counter", systemImage: "plus") {
                        selectedCounter = Counter()
                    }
                }
            }
            .sheet(item: $selectedCounter) { counter in
                CreateCounterSheet(counter: counter)
                    .presentationDetents([.medium])
            }
        }
    }

    private func editCounter(_ counter: Counter) {
        Logger.views.info("Editing counter: \(counter.id)")
        selectedCounter = counter
    }
    
    private func deleteCounter(_ counter: Counter) {
        do {
            try CounterStore(context: modelContext).delete(counter)
        } catch {
            Logger.storage.error("Failed to delete counter: \(error)")
        }
    }
}

#Preview {
    CounterListView()
}
