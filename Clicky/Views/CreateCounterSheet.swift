//
//  CreateCounterSheet.swift
//  Clicky
//
//  Created by Brandon Potts on 3/4/26.
//

import SwiftData
import SwiftUI

struct CreateCounterSheet: View {
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
            Button("Done") {
                modelContext.insert(counter)
                onCreated()
                dismiss()
            }
            .frame(maxWidth: .infinity)
        }
        .padding()
    }
}
