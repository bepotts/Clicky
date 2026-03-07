//
//  CounterListView.swift
//  Clicky
//
//  Created by Brandon Potts on 3/4/26.
//

import SwiftData
import SwiftUI

struct CounterListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var counters: [Counter]
    @State private var isSheetPresented = false
    @State private var counterName = ""
    @State private var navigateToCounterView = false
    @State private var newCounter = Counter()

    var body: some View {
        NavigationStack {
            Group {
                if counters.isEmpty {
                    Button("create new counter") {
                        isSheetPresented = true
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List(counters) { counter in
                        CounterViewListItem(counter: counter)
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    modelContext.delete(counter)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        isSheetPresented = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isSheetPresented, onDismiss: handleSheetDismiss) {
                CreateCounterSheet(counter: newCounter, onCreated: handleCounterCreated)
                    .presentationDetents([.medium])
            }
            .navigationDestination(isPresented: $navigateToCounterView) {
                CounterView()
            }
        }
    }

    private func handleSheetDismiss() {
        newCounter = Counter()
    }

    private func handleCounterCreated() {
        // navigateToCounterView = true TODO: Change this once I decide how to handle the navigation
    }
}

private struct CreateCounterSheet: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Bindable var counter: Counter
    let onCreated: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Name of new Counter")
                .frame(maxWidth: .infinity)
            TextField("Name", text: $counter.name)
                .textFieldStyle(.roundedBorder)
            Button("Create") {
                modelContext.insert(counter)
                onCreated()
                dismiss()
            }
            .frame(maxWidth: .infinity)
        }
        .padding()
    }
}

#Preview {
    CounterListView()
}
