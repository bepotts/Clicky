//
//  CreateCounterView.swift
//  Clicky
//
//  Created by Brandon Potts on 3/4/26.
//

import SwiftUI
import SwiftData

struct CounterListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var counters: [Counter]
    @State private var isSheetPresented = false
    @State private var counterName = ""
    @State private var navigateToCounterView = false

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
                        Text(counter.name)
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
            .sheet(isPresented: $isSheetPresented) {
                CreateCounterSheet(counterName: $counterName, onCreated: {
                    navigateToCounterView = true
                })
                .presentationDetents([.medium])
            }
            .navigationDestination(isPresented: $navigateToCounterView) {
                CounterView()
            }
        }
    }
}

private struct CreateCounterSheet: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Binding var counterName: String
    let onCreated: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Name of new Counter")
                .frame(maxWidth: .infinity)
            TextField("Name", text: $counterName)
                .textFieldStyle(.roundedBorder)
            Button("Create") {
                let counter = Counter(name: counterName)
                modelContext.insert(counter)
                onCreated()
                counterName = ""
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
