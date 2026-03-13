//
//  ClickyApp.swift
//  Clicky
//
//  Created by Brandon Potts on 3/4/26.
//

import SwiftData
import SwiftUI

@main
struct ClickyApp: App {

    var body: some Scene {
        WindowGroup {
            CounterListView()
        }
        .modelContainer(ModelContainer.shared)
    }
}
