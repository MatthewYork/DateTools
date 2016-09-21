//
//  TimeIntervalTests.swift
//  DateToolsTests
//
//  Created by Matthew York on 8/29/16.
//  Copyright © 2016 Matthew York. All rights reserved.
//

import XCTest
@testable import DateToolsTests

class TimeIntervalTests: XCTestCase {
    
    var time = TimeInterval()
    
    override func setUp() {
        super.setUp()
        time = 600000
    }
    
    override func tearDown() {
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
