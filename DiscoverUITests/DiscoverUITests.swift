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
        
        // Setup fastlane
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGenerateAppStoreScreenshots() {
        // Start of app
        let app = XCUIApplication()
        
        // Navigate to menu
        app.navigationBars["Toplists"].children(matching: .button).element.tap()
        snapshot("Menu")
        
        // Grab the table
        let tablesQuery = app.tables
        
        // Sign in and go back to menu
        app.tables.staticTexts["Sign in"].tap()
        app.buttons["Sign in"].tap()
        app.buttons["Done"].tap()
        snapshot("SignIn")
        app.navigationBars["Toplists"].children(matching: .button).element.tap()
        
        // Show watchlist
        tablesQuery.staticTexts["My watchlist"].tap()
        app.navigationBars["Watchlist"].buttons["Menu"].tap()
        snapshot("Watchlist")
        
        // Show favorites
        tablesQuery.staticTexts["My favorite movies"].tap()
        app.navigationBars["Favorites"].buttons["Menu"].tap()
        snapshot("Favorites")
        
        // Go to first movie detail
        tablesQuery.staticTexts["My favorite movies"].tap()
        snapshot("MovieDetail-1")
        
        // Scroll down 
        XCUIApplication().scrollViews.otherElements.containing(.staticText, identifier:"Her").element.swipeUp()
        snapshot("MovieDetail-2")
        
        // Navigate back to menu
        app.buttons["Back"].tap()
        app.navigationBars["Favorites"].children(matching: .button).element.tap()
    }
    
}
