//
//  IntegerExtensionTests.swift
//  DateToolsTests
//
//  Created by Matthew York on 8/29/16.
//  Copyright © 2016 Matthew York. All rights reserved.
//

import XCTest
@testable import DateToolsSwift

class IntegerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSecondsChunk() {
        let testChunk = 1.seconds
        let controlChunk = TimeChunk(seconds: 1, minutes: 0, hours: 0, days: 0, weeks: 0, months: 0, years: 0)
        XCTAssertTrue(testChunk == controlChunk)
        XCTAssertFalse(testChunk == 4.seconds)
    }
    
    func testMinutesChunk() {
        let testChunk = 1.minutes
        let controlChunk = TimeChunk(seconds: 0, minutes: 1, hours: 0, days: 0, weeks: 0, months: 0, years: 0)
        XCTAssertTrue(testChunk == controlChunk)
        XCTAssertFalse(testChunk == 4.minutes)
    }
    
    func testHoursChunk() {
        let testChunk = 1.hours
        let controlChunk = TimeChunk(seconds: 0, minutes: 0, hours: 1, days: 0, weeks: 0, months: 0, years: 0)
        XCTAssertTrue(testChunk == controlChunk)
        XCTAssertFalse(testChunk == 4.hours)
    }
    
    func testDaysChunk() {
        let testChunk = 1.days
        let controlChunk = TimeChunk(seconds: 0, minutes: 0, hours: 0, days: 1, weeks: 0, months: 0, years: 0)
        XCTAssertTrue(testChunk == controlChunk)
        XCTAssertFalse(testChunk == 4.days)
    }
    
    func testWeeksChunk() {
        let testChunk = 1.weeks
        let controlChunk = TimeChunk(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 1, months: 0, years: 0)
        XCTAssertTrue(testChunk == controlChunk)
        XCTAssertFalse(testChunk == 4.weeks)
    }
    
    func testMonthsChunk() {
        let testChunk = 1.months
        let controlChunk = TimeChunk(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: 1, years: 0)
        XCTAssertTrue(testChunk == controlChunk)
        XCTAssertFalse(testChunk == 4.months)
    }
    
    func testYearsChunk() {
        let testChunk = 1.years
        let controlChunk = TimeChunk(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: 0, years: 1)
        XCTAssertTrue(testChunk == controlChunk)
        XCTAssertFalse(testChunk == 4.years)
    }
    
}
