//
//  UITestView_Tests.swift
//  ForWorldSkillsUI_Tests
//
//  Created by Вадим Мартыненко on 05.02.2024.
//

import XCTest

final class UITestView_Tests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_UITestView_signInUpButton_shouldNotSignIn() {
        app.textFields["TextFieldSignUp"].tap()
        
        app.buttons["SignUpButton"].tap()
        
        let navigationBar = app.navigationBars["Welcome!"]
        
        XCTAssertFalse(navigationBar.exists)
    }
    
    func test_UITestView_signInUpButton_shouldSignIn() {
        app.textFields["TextFieldSignUp"].tap()
        
        let keyA = app.keys["А"]
        keyA.tap()
        
        let keya = app.keys["а"]
        keya.tap()
        keya.tap()
        
        app.buttons["SignUpButton"].tap()
        
        let navigationBar = app.navigationBars["Welcome!"]
        
        XCTAssertTrue(navigationBar.exists)
    }
    
    func test_UITestView_showAleartButton_shouldDisplayAlert() {
        app.textFields["TextFieldSignUp"].tap()
        
        let keyA = app.keys["А"]
        keyA.tap()
        
        let keya = app.keys["а"]
        keya.tap()
        keya.tap()
        
        app.buttons["SignUpButton"].tap()
        
        
        let showAlertButton = app.buttons["ShowAlertButton"]
        
        XCTAssertTrue(showAlertButton.exists)
        
        showAlertButton.tap()
        
        let alert = app.alerts["welcome alert"]
        
        XCTAssertTrue(alert.exists)
    }
    
    func test_UITestView_showAleartButton_shouldDisplayAndDismissAlert() {
        
        app.textFields["TextFieldSignUp"].tap()
        
        let keyA = app.keys["А"]
        keyA.tap()
        
        let keya = app.keys["а"]
        keya.tap()
        keya.tap()
        
        app.buttons["SignUpButton"].tap()
        
        
        let showAlertButton = app.buttons["ShowAlertButton"]
        
        XCTAssertTrue(showAlertButton.exists)
        
        showAlertButton.tap()
        
        let alert = app.alerts.firstMatch
        
        XCTAssertTrue(alert.exists)
        
        alert.buttons["Cancel"].tap()
        
        XCTAssertFalse(alert.waitForExistence(timeout: 5))
    }
    
    func test_UITestView_NavigateToNextScreenButton_shouldNavigateToNextScreen() {
        
        app.textFields["TextFieldSignUp"].tap()
        
        let keyA = app.keys["А"]
        keyA.tap()
        
        let keya = app.keys["а"]
        keya.tap()
        keya.tap()
        
        app.buttons["SignUpButton"].tap()
        
        let navigateToNextScreenButton = app.buttons["NavigateToNextScreenButton"]
        
        XCTAssertTrue(navigateToNextScreenButton.waitForExistence(timeout: 2))
        
        navigateToNextScreenButton.tap()
        
        
        let nextScreenText = app.staticTexts["Destination"]
                
        XCTAssertTrue(nextScreenText.waitForExistence(timeout: 2))
    }
}
