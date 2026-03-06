//
//  ContentView.swift
//  Clicky
//
//  Created by Brandon Potts on 3/4/26.
//

import SwiftUI

struct ContentView: View {
    @State private var count = 0

    private var countText: some View {
        Text("\(count)")
            .font(.system(size: 48, weight: .bold))
            .monospacedDigit()
    }

    private var incrementButton: some View {
        Button(action: { count += 1 }) {
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
        Button(action: { count -= 1 }) {
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
                countText
                HStack(spacing: 24) {
                    decrementButton
                    incrementButton
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ContentView()
}
