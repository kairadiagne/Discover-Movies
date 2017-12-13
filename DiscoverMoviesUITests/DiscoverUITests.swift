//
//  DiscoverUITests.swift
//  DiscoverUITests
//
//  Created by Kaira Diagne on 26-12-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import XCTest

class DiscoverUITests: XCTestCase {

    override func setUp() {
        super.setUp()

        // Create the app
        let app = XCUIApplication()

        // Set up snapshot
        setupSnapshot(app)

        // Stop in case of failure
        continueAfterFailure = false
        // Launch the application
        app.launch()
    }

    override func tearDown() {
        super.tearDown()
    }

    // This test requires the app to be logged in
    // This is not possible in the test because the website has no accesabiliy support
    func testGenerateAppStoreScreenshots() {
        // Go to menu
        let app = XCUIApplication()
        snapshot("Home-screenshot", waitForLoadingIndicator: true)

        // TODO: - See if you can login
        app.navigationBars["Toplists"].buttons["Menu"].tap()
        snapshot("menu-screenshot")

        // Go to watchlist
        let tablesQuery = app.tables
        tablesQuery.staticTexts["My watchlist"].tap()
        snapshot("watchlist-screenshot", waitForLoadingIndicator: true)

        // Go back to menu
        app.navigationBars["Watchlist"].buttons["Menu"].tap()
            
        // Go to favorites
        tablesQuery.staticTexts["My favorite movies"].tap()
        snapshot("favorites-snapshot", waitForLoadingIndicator: true)

        // Go to detail of first movie in list
        app.tables.staticTexts["Her"].tap()
        snapshot("detail-screenshot")

        // Scroll down
        let herElement = app.scrollViews.otherElements.containing(.staticText, identifier:"Her").element
        herElement.swipeUp()
        snapshot("detail-screenshot-2")
    }

}

