//
//  SpaceLaunchUITests.swift
//  SpaceLaunchUITests
//
//  Created by Prashant Singh on 8/3/2023.
//

import XCTest

final class SpaceLaunchUITests: XCTestCase {

    func testActivityLoader(){
        let app = XCUIApplication()
        app.launch()
        
        let tableView = app.tables.element(boundBy: 0)
        XCTAssertTrue(tableView.exists)
        let loadingSpinner = app.otherElements.activityIndicators.matching(identifier: AccessibilityIdentifier.loadingSpinnerIdentifier)
        XCTAssertTrue(loadingSpinner.element.exists)
    }
    
    func testAstronautListFetch() {
        let app = XCUIApplication()
        app.launch()
        let tableView = app.tables.element(boundBy: 0)
        XCTAssertTrue(tableView.exists)
        XCTAssertTrue(tableView.cells.element.waitForExistence(timeout: 5.0))
    }
    
    func testActivityLoaderDetailsScreen() {
        let app = XCUIApplication()
        app.launch()
        let tableView = app.tables.element(boundBy: 0)
        _ = tableView.cells.element.waitForExistence(timeout: 5.0)
        tableView.cells.firstMatch.tap()
        let loadingSpinner = app.otherElements.activityIndicators.matching(identifier: AccessibilityIdentifier.loadingSpinnerIdentifier)
        XCTAssertTrue(loadingSpinner.element.exists)
    }
    
    func testAstronautDetailScreenImageView() {
        let app = XCUIApplication()
        app.launch()
        let tableView = app.tables.element(boundBy: 0)
        _ = tableView.cells.element.waitForExistence(timeout: 5.0)
        tableView.cells.firstMatch.tap()
        XCTAssertTrue(app.images[AccessibilityIdentifier.astronautDetailImageView].waitForExistence(timeout: 5))
    }
}
