//
//  Batch_5_DemoUITests.swift
//  Batch 5 DemoUITests
//
//  Created by Leif Ashley on 3/7/22.
//

import XCTest

class Batch_5_DemoUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        app.terminate()
        app = nil
    }

    func testGoldenPath() {
        
        app.buttons["NewsButton"].tap()
        
        let firstCell = app.tables.cells.firstMatch
        
        XCTAssertTrue(firstCell.waitForExistence(timeout: 2))
        
        firstCell.tap()
        
        let webView = app.webViews.firstMatch
        
        XCTAssertTrue(webView.waitForExistence(timeout: 3))
        
        webView.swipeUp()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
