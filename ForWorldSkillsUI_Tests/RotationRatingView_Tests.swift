//
//  RotationRatingView_Tests.swift
//  ForWorldSkillsUI_Tests
//
//  Created by Вадим Мартыненко on 04.02.2024.
//

import XCTest
@testable import ForWorldSkills

final class RotationRatingView_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func test_RotationRatingView_rateEqualStarPositionWhenTapOnStart() {
        let app = XCUIApplication()
        app.launch()
        
        
        let element = app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        let star3 = element.children(matching: .image).matching(identifier: "Избранное").element(boundBy: 2)
        let star2 = element.children(matching: .image).matching(identifier: "Избранное").element(boundBy: 1)
        
        star3.tap()
        
        XCTAssertTrue(star3.exists)
        
        sleep(2)
        
        star2.tap()
        
        XCTAssertTrue(star2.exists)
                
        
        sleep(3)
    }
}
