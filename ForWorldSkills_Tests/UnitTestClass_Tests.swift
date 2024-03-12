//
//  UnitTestClass_Tests.swift
//  ForWorldSkills_Tests
//
//  Created by Вадим Мартыненко on 04.02.2024.
//

import XCTest
@testable import ForWorldSkills

final class UnitTestClass_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func test_UnitTestClass_addString_stringAddSuccess() {
        let unitTestClass = UnitTestClass()
        
        let beforeCount = unitTestClass.strings.count
        
        let string = UUID().uuidString
        
        unitTestClass.addString(string: string)
        
        let afterCount = unitTestClass.strings.count
        
        let result = afterCount - beforeCount
        
        XCTAssertEqual(result, 1)
        
        let tryGetRemovedString = unitTestClass.strings.first(where: { $0 == string })
        
        XCTAssertNotNil(tryGetRemovedString)
    }
    
    func test_UnitTestClass_removeString_stringRemoveSuccess() {
        let unitTestClass = UnitTestClass()
        
        let beforeCount = unitTestClass.strings.count
        
        let string = UUID().uuidString
        
        unitTestClass.addString(string: string)
        
        let afterCount = unitTestClass.strings.count
        
        let result = afterCount - beforeCount
        
        XCTAssertEqual(result, 1)
        
        unitTestClass.removeString(string: string)
        
        let nowCount = unitTestClass.strings.count
        
        XCTAssertEqual(nowCount, beforeCount)
        
        let tryGetRemovedString = unitTestClass.strings.first(where: { $0 == string })
        
        XCTAssertNil(tryGetRemovedString)
    }
}
