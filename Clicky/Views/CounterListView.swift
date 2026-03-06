//
//  CreateCounterView.swift
//  Clicky
//
//  Created by Brandon Potts on 3/4/26.
//

import SwiftUI

struct CounterListView: View {
    @State private var isSheetPresented = false
    @State private var counterName = ""

    var body: some View {
        Button("create new counter") {
            isSheetPresented = true
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .sheet(isPresented: $isSheetPresented) {
            VStack(alignment: .leading, spacing: 16) {
                Text("Name of new Counter")
                    .frame(maxWidth: .infinity)
                TextField("Name", text: $counterName)
                    .textFieldStyle(.roundedBorder)
            }
            .padding()
            .presentationDetents([.medium])
        }
    }
}

#Preview {
    CounterListView()
}
