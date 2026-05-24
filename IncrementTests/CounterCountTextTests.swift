//
//  CounterCountTextTests.swift
//  IncrementTests
//
//  Created by Brandon Potts on 5/24/26.
//

import Testing
@testable import Increment

/// Unit tests for the formatted counter count text.
@MainActor
struct CounterCountTextTests {
    @Test(arguments: [0, 1, 1_000])
    func renders(count: Int) throws {
        try render(CounterCountText(count: count))
    }
}
