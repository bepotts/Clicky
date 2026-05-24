//
//  IncrementUITests.swift
//  IncrementUITests
//
//  Created by Brandon Potts on 3/4/26.
//

import XCTest

/// UI tests for the Increment app.
final class IncrementUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testCounterViewListItemIncrementButtonUpdatesCount() {
        let app = launchApp()
        let count = app.staticTexts["counter-list-item-count-ui-test-counter"]

        XCTAssertTrue(count.waitForExistence(timeout: 5))
        XCTAssertEqual(count.label, "6")

        app.buttons["counter-list-item-increment-ui-test-counter"].tap()

        wait(for: count, toHaveLabel: "8")
    }

    @MainActor
    func testCounterViewListItemDecrementButtonUpdatesCount() {
        let app = launchApp()
        let count = app.staticTexts["counter-list-item-count-ui-test-counter"]

        XCTAssertTrue(count.waitForExistence(timeout: 5))
        XCTAssertEqual(count.label, "6")

        app.buttons["counter-list-item-decrement-ui-test-counter"].tap()

        wait(for: count, toHaveLabel: "4")
    }

    @MainActor
    func testCounterViewListItemDecrementButtonDoesNotGoBelowZero() {
        let app = launchApp()
        let count = app.staticTexts["counter-list-item-count-ui-test-counter"]
        let decrementButton = app.buttons["counter-list-item-decrement-ui-test-counter"]

        XCTAssertTrue(count.waitForExistence(timeout: 5))

        decrementButton.tap()
        wait(for: count, toHaveLabel: "4")
        decrementButton.tap()
        wait(for: count, toHaveLabel: "2")
        decrementButton.tap()
        wait(for: count, toHaveLabel: "0")
        decrementButton.tap()

        wait(for: count, toHaveLabel: "0")
    }

    @MainActor
    private func launchApp() -> XCUIApplication {
        let app = XCUIApplication()
        app.launchArguments = ["-ui-testing"]
        app.launch()
        return app
    }

    private func wait(for element: XCUIElement, toHaveLabel expectedLabel: String, timeout: TimeInterval = 2) {
        let predicate = NSPredicate(format: "label == %@", expectedLabel)
        expectation(for: predicate, evaluatedWith: element)
        waitForExpectations(timeout: timeout)
    }
}
