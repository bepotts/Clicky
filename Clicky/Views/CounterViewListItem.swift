//
//  CounterViewListItem.swift
//  Clicky
//
//  Created by Brandon Potts on 3/7/26.
//

import SwiftData
import SwiftUI

struct CounterViewListItem: View {
    @Bindable var counter: Counter

    var body: some View {
        HStack {
            Button("-") {
                counter.count -= 1
            }
            .buttonStyle(.borderless)
            Spacer()
            VStack(alignment: .leading, spacing: 40) {
                Text(counter.name)
                Text("\(counter.count)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Button("+") {
                counter.count += 1
            }
            .buttonStyle(.borderless)
        }
    }
}

#Preview {
    CounterViewListItem(counter: Counter(count: 42, name: "Sample"))
}
