//
//  CounterViewTests.swift
//  IncrementTests
//
//  Created by Brandon Potts on 5/24/26.
//

import Testing
@testable import Increment

/// Unit tests for the counter detail view.
@MainActor
struct CounterViewTests {
    @Test func renders() throws {
        try render(CounterView(counter: Counter(count: 42, name: "Sample")), container: makeTestContainer())
    }
}
