//
//  CounterView.swift
//  Clicky
//
//  Created by Brandon Potts on 3/4/26.
//

import SwiftData
import SwiftUI

struct CounterView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var counters: [Counter]

    private var counter: Counter? {
        counters.first
    }

    private var nameTextField: some View {
        TextField("Enter name of count", text: Binding(
            get: { counter?.name ?? "" },
            set: { counter?.name = $0 }
        ))
        .textFieldStyle(.plain)
        .frame(maxWidth: 280)
    }

    private var countText: some View {
        Text("\(counter?.count ?? 0)")
            .font(.system(size: 48, weight: .bold))
            .monospacedDigit()
    }

    private var incrementButton: some View {
        Button(action: { counter?.count += 1 }) {
            Text("+")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .frame(minWidth: 80, minHeight: 80)
                .background(.blue, in: RoundedRectangle(cornerRadius: 16))
        }
        .buttonStyle(.plain)
    }

    private var decrementButton: some View {
        Button(action: { counter?.count -= 1 }) {
            Text("-")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .frame(minWidth: 80, minHeight: 80)
                .background(.blue, in: RoundedRectangle(cornerRadius: 16))
        }
        .buttonStyle(.plain)
    }

    var body: some View {
        ZStack {
            Color.clear
            VStack(spacing: 24) {
                nameTextField
                countText
                HStack(spacing: 24) {
                    decrementButton
                    incrementButton
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            if counters.isEmpty {
                modelContext.insert(Counter())
            }
        }
    }
}

#Preview {
    CounterView()
        .modelContainer(for: Counter.self, inMemory: true)
}
