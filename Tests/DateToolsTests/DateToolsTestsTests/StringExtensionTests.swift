//
//  StringExtensionTests.swift
//  DateToolsTests
//
//  Created by Matthew York on 8/29/16.
//  Copyright © 2016 Matthew York. All rights reserved.
//

import XCTest
@testable import DateToolsTests

class StringExtensionTests: XCTestCase {
    
    let controlDate = Date()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testStringExtension() {
        let dateString = String(controlDate)
        XCTAssertTrue(dateString == String(Date()))
    }
    
}
