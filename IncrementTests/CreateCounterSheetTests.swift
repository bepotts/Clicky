//
//  CreateCounterSheetTests.swift
//  IncrementTests
//
//  Created by Brandon Potts on 5/24/26.
//

import Testing
@testable import Increment

/// Unit tests for the counter creation and editing sheet.
@MainActor
struct CreateCounterSheetTests {
    @Test func renders() throws {
        try render(CreateCounterSheet(counter: Counter(name: "Pages")), container: makeTestContainer())
    }
}
