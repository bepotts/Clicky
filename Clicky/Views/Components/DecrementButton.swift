//
//  DecrementButton.swift
//  Clicky
//
//  Created by Brandon Potts on 3/4/26.
//

import SwiftUI

struct DecrementButton: View {
    let counter: Counter

    var body: some View {
        Button {
            counter.decrement()
        } label: {
            Text("-")
                .font(.largeTitle)
                .bold()
                .foregroundStyle(.white)
                .frame(minWidth: 80, minHeight: 80)
                .background(.blue, in: RoundedRectangle(cornerRadius: 16))
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Decrement")
    }
}
