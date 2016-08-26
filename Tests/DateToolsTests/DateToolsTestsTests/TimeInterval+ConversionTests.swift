//
//  TimeInterval+ConversionTests.swift
//  DateToolsTests
//
//  Created by Grayson Webster on 8/26/16.
//  Copyright © 2016 Matthew York. All rights reserved.
//

import XCTest
@testable import DateToolsTests

class TimeInterval_ConversionTests: XCTestCase {
    
    var time = TimeInterval()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        time = 600000
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: - Tests
    
    func testSeconds() {
        XCTAssertEqual(600000.0, time.seconds)
    }
    
    func testMinutes() {
        XCTAssertEqual(10000.0, time.minutes)
    }
    
    func testHours() {
        XCTAssertEqual(166, Int(time.hours))
    }
    
    func testDays() {
        XCTAssertEqual(6, Int(time.days))
    }
    
    func testWeeks() {
        XCTAssertEqual(0, Int(time.weeks))
    }
    
}
