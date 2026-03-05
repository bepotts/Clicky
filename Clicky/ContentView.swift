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

    private var tapButton: some View {
        Button(action: { count += 1 }) {
            Text("Tap")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .frame(minWidth: 160, minHeight: 80)
                .background(.blue, in: RoundedRectangle(cornerRadius: 16))
        }
        .buttonStyle(.plain)
    }

    var body: some View {
        ZStack {
            Color.clear
            VStack(spacing: 24) {
                countText
                tapButton
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ContentView()
}
