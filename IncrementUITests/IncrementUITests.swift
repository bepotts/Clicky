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
    func testLaunchShowsSeededCounterList() {
        let app = launchApp()

        XCTAssertTrue(app.buttons["add-counter-button"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.buttons["delete-all-counters-button"].exists)
        XCTAssertTrue(app.staticTexts["counter-list-item-name-ui-test-counter"].exists)
        XCTAssertTrue(app.staticTexts["counter-list-item-count-ui-test-counter"].exists)
        XCTAssertFalse(app.staticTexts["No Counters"].exists)
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
    func testCreateCounterFromEmptyState() {
        let app = launchApp(arguments: ["-ui-testing", "-ui-testing-empty"])

        XCTAssertTrue(app.staticTexts["No Counters"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.staticTexts["Tap the + button to create your first counter."].exists)

        app.buttons["empty-add-counter-button"].tap()

        XCTAssertTrue(app.staticTexts["Name of new Counter"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.staticTexts["Increment By"].exists)
        XCTAssertTrue(app.staticTexts["Starting Count"].exists)

        app.textFields["Name"].tap()
        app.textFields["Name"].typeText("Books")
        app.buttons["Done"].tap()

        let name = app.staticTexts["counter-list-item-name-books"]
        let count = app.staticTexts["counter-list-item-count-books"]
        XCTAssertTrue(name.waitForExistence(timeout: 5))
        XCTAssertEqual(name.label, "Books")
        XCTAssertEqual(count.label, "0")

        app.buttons["counter-list-item-increment-books"].tap()

        wait(for: count, toHaveLabel: "1")
    }

    @MainActor
    func testDeleteAllCountersShowsEmptyState() {
        let app = launchApp()

        XCTAssertTrue(app.staticTexts["counter-list-item-name-ui-test-counter"].waitForExistence(timeout: 5))

        app.buttons["delete-all-counters-button"].tap()
        XCTAssertTrue(app.alerts["Delete All Counters?"].waitForExistence(timeout: 2))
        app.alerts["Delete All Counters?"].buttons["Delete All"].tap()

        XCTAssertTrue(app.staticTexts["No Counters"].waitForExistence(timeout: 5))
        XCTAssertFalse(app.staticTexts["counter-list-item-name-ui-test-counter"].exists)
    }

    @MainActor
    func testLandingPageCanBeShownDuringUITests() {
        let app = launchApp(arguments: ["-ui-testing", "-ui-testing-empty", "-ui-testing-show-landing"])

        XCTAssertTrue(app.staticTexts["Welcome to Increment"].waitForExistence(timeout: 5))

        XCTAssertTrue(app.staticTexts["No Counters"].waitForExistence(timeout: 5))
    }

    @MainActor
    private func launchApp(arguments: [String] = ["-ui-testing"]) -> XCUIApplication {
        let app = XCUIApplication()
        app.launchArguments = arguments
        app.launch()
        return app
    }

    private func wait(for element: XCUIElement, toHaveLabel expectedLabel: String, timeout: TimeInterval = 2) {
        let predicate = NSPredicate(format: "label == %@", expectedLabel)
        expectation(for: predicate, evaluatedWith: element)
        waitForExpectations(timeout: timeout)
    }
}
