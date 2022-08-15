//
//  Lab1_2022UITests.swift
//  Lab1_2022UITests
//
//  Created by ICS 224 on 2022-01-20.
//

import XCTest

class Lab1_2022UITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCharCount() throws {
        let app = XCUIApplication()
        app.launch()
             
        let addEntryButton = app.buttons["PlusButton"]
        addEntryButton.tap()

        app.tables.cells.firstMatch.tap();
        
        let detailText = app.staticTexts["DetailText"]
        let detailTextEditor = app.textViews["DetailTextEditor"]
        
        XCTAssertEqual(detailText.label, "7/150")
        
        detailTextEditor.tap()
             
        let keyH = app.keys["H"]
        
        keyH.tap()
        XCTAssertTrue(detailText.waitForExistence(timeout: 5))
        XCTAssertEqual(detailText.label, "8/150")
             
        let keyi = app.keys["i"]
        keyi.tap()
        XCTAssertEqual(detailText.label, "9/150")
    }
    
    func testMaxChars() throws {
        let app = XCUIApplication()
        app.launch()
        
        let addEntryButton = app.buttons["PlusButton"]
        addEntryButton.tap()
        
        app.tables.cells.firstMatch.tap();

        let detailText = app.staticTexts["DetailText"]
        XCTAssertEqual(detailText.label, "7/150")
             
        let detailTextEditor = app.textViews["DetailTextEditor"]
        detailTextEditor.tap()
        
        let keyZ = app.keys["G"]
        keyZ.tap()
        var i: Int = 0;
        let keyo = app.keys["o"]
        while i < 142 {
            keyo.tap()
            i += 1
        }
        
        XCTAssertTrue(detailText.waitForExistence(timeout: 2))
        XCTAssertEqual(detailText.label, "150/150")
        
        let keyi = app.keys["i"]
        keyi.tap()
        XCTAssertEqual(detailText.label, "150/150")
        
    }
    
    
    func testStepperDecrement() throws {
        let app = XCUIApplication()
        app.launch()
             
        let addEntryButton = app.buttons["PlusButton"]
        addEntryButton.tap()

        app.tables.cells.firstMatch.tap();

        let detailText = app.staticTexts["DetailText"]
        XCTAssertEqual(detailText.label, "7/150")
        
        let inventoryButton = app.buttons["Inventory"]
        inventoryButton.tap()
        
        let navButton = app.buttons["NavigationButton"]
        navButton.tap()
        
        let stepper = app.steppers["MaxCountStepper"]
        
        var i: Int = 0;
        while i < 16 {
            stepper.buttons["Decrement"].tap()
            i += 1
        }
        navButton.tap()
        
        app.tables.cells.firstMatch.tap();
        XCTAssertEqual(detailText.label, "7/10")
        
        let detailTextEditor = app.textViews["DetailTextEditor"]
        detailTextEditor.tap()
        let keyZ = app.keys["G"]
        keyZ.tap()
        i = 0;
        let keyo = app.keys["o"]
        while i < 2 {
            keyo.tap()
            i += 1
        }
        
        XCTAssertTrue(detailText.waitForExistence(timeout: 2))
        XCTAssertEqual(detailText.label, "10/10")
        
        let keyi = app.keys["i"]
        keyi.tap()
        XCTAssertEqual(detailText.label, "10/10")
        
        inventoryButton.tap()
        navButton.tap()
        
        i = 0;
        while i < 40 {
            stepper.buttons["Increment"].tap()
            i += 1
        }
        
        navButton.tap()
        app.tables.cells.firstMatch.tap();
        
        XCTAssertEqual(detailText.label, "10/300")
        
        inventoryButton.tap()
        navButton.tap()
        
        i = 0;
        while i < 15 {
            stepper.buttons["Decrement"].tap()
            i += 1
        }
         
        navButton.tap()
        app.tables.cells.firstMatch.tap();
        
        XCTAssertEqual(detailText.label, "10/150")
        
    }
    
    func testFavourite() throws {
        let app = XCUIApplication()
        app.launch()
    
        let addEntryButton = app.buttons["PlusButton"]
        addEntryButton.tap()
        addEntryButton.tap()
        
        app.tables.cells.firstMatch.tap();
        
        let favouriteToggle = app.switches["FavouriteToggle"]
        
        XCTAssertEqual(favouriteToggle.value as? String, "0")
        favouriteToggle.tap()
        XCTAssertEqual(favouriteToggle.value as? String, "1")
        
        let inventoryButton = app.buttons["Inventory"]
        inventoryButton.tap()
        
        let secondEntry = app.tables.cells.element(boundBy: 1)
        secondEntry.tap()
        
        XCTAssertEqual(favouriteToggle.value as? String, "0")
        favouriteToggle.tap()
        XCTAssertEqual(favouriteToggle.value as? String, "0")
        
        inventoryButton.tap()
        app.tables.cells.firstMatch.tap();
        favouriteToggle.tap()
        XCTAssertEqual(favouriteToggle.value as? String, "0")
        inventoryButton.tap()
        
        secondEntry.tap()
        favouriteToggle.tap()
        XCTAssertEqual(favouriteToggle.value as? String, "1")
    }
    
    func testAddItems() throws {
        let app = XCUIApplication()
        app.launch()
             
        XCTAssertEqual(app.tables.cells.count, 0)

        let addEntryButton = app.buttons["PlusButton"]
        addEntryButton.tap()

        app.tables.cells.firstMatch.tap();
        
        let detailText = app.staticTexts["DetailText"]
        let detailTextEditor = app.textViews["DetailTextEditor"]
        detailTextEditor.tap()
        XCTAssertTrue(detailText.waitForExistence(timeout: 2))
        
        detailTextEditor.tap()
        let keyH = app.keys["H"]
        keyH.tap()
        
        let inventoryButton = app.buttons["Inventory"]
        inventoryButton.tap()
        
        addEntryButton.tap()
        
        app.tables.cells.firstMatch.tap();
        XCTAssertEqual(detailText.label, "7/150")
        
        inventoryButton.tap()
        let secondEntry = app.tables.cells.element(boundBy: 1)
        secondEntry.tap()
        XCTAssertEqual(detailText.label, "8/150")
        
        XCTAssertEqual(app.tables.cells.count, 2)
        
    }
    
    func testDeleteItems() throws {
        let app = XCUIApplication()
        app.launch()
             
        
        let detailText = app.staticTexts["DetailText"]
        let inventoryButton = app.buttons["Inventory"]
        let addEntryButton = app.buttons["PlusButton"]
        
        
        addEntryButton.tap()
        addEntryButton.tap()

        XCTAssertEqual(app.tables.cells.count, 2)
        
        let secondEntry = app.tables.cells.element(boundBy: 1)
        secondEntry.tap()
        
        let detailTextEditor = app.textViews["DetailTextEditor"]
        detailTextEditor.tap()
        XCTAssertTrue(detailText.waitForExistence(timeout: 2))
        
        detailTextEditor.tap()
        let keyH = app.keys["H"]
        keyH.tap()

        inventoryButton.tap()

        app.tables.cells.firstMatch.swipeLeft();
        app.buttons["Delete"].tap();

        app.tables.cells.firstMatch.tap();
        XCTAssertEqual(detailText.label, "8/150")
        
        inventoryButton.tap()
        
        app.tables.cells.firstMatch.swipeLeft();
        app.buttons["Delete"].tap();
        
        XCTAssertEqual(app.tables.cells.count, 0)
        
    }
    
    func testLoadAndSave() throws {
        let app = XCUIApplication()
        app.launch()
        
        let detailText = app.staticTexts["DetailText"]
        let detailTextEditor = app.textViews["DetailTextEditor"]
        let inventoryButton = app.buttons["Inventory"]
        let addEntryButton = app.buttons["PlusButton"]
        let favouriteToggle = app.switches["FavouriteToggle"]
        
        addEntryButton.tap()
        addEntryButton.tap()

        let secondEntry = app.tables.cells.element(boundBy: 1)
        secondEntry.tap()
        
        XCTAssertEqual(favouriteToggle.value as? String, "0")
        favouriteToggle.tap()
        XCTAssertEqual(favouriteToggle.value as? String, "1")

        inventoryButton.tap();
        
        app.tables.cells.firstMatch.tap();
        XCTAssertTrue(detailText.waitForExistence(timeout: 2))

        detailTextEditor.tap()
        let keyH = app.keys["H"]
        keyH.tap()
        
        XCUIDevice.shared.press(.home)
        sleep(1)
        
        app.terminate()
        
        app.launch()
        
        app.tables.cells.firstMatch.tap();
        XCTAssertEqual(detailText.label, "8/150")
        
        inventoryButton.tap();
        
        secondEntry.tap();
        
        XCTAssertEqual(favouriteToggle.value as? String, "1")
        
        inventoryButton.tap();
        
        app.tables.cells.firstMatch.swipeLeft();
        app.buttons["Delete"].tap();
        
        app.tables.cells.firstMatch.swipeLeft();
        app.buttons["Delete"].tap();
        
    }
}
