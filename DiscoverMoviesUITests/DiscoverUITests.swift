//
//  DiscoverUITests.swift
//  DiscoverUITests
//
//  Created by Kaira Diagne on 26-12-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import XCTest

class DiscoverUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()

        app = XCUIApplication()
        setupSnapshot(app)
        continueAfterFailure = false
        app.launch()
    }

    override func tearDown() {
        super.tearDown()
    }

    // This test requires the app to be logged in
    func testGenerateAppStoreScreenshots() {
        // Go to menu
        snapshot("Home-screenshot", waitForLoadingIndicator: true)

        tapMenuButton()
        snapshot("menu-screenshot")

        // Go to watchlist
        let tablesQuery = app.tables
        tablesQuery.staticTexts["My watchlist"].tap()
        snapshot("watchlist-screenshot", waitForLoadingIndicator: true)

        // Go back to menu
        tapMenuButton()
            
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

    private func tapMenuButton() {
        app.navigationBars.children(matching: .button).element.tap()
    }
}

