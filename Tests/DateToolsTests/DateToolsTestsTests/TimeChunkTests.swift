//
//  TimeChunkTests.swift
//  DateToolsTests
//
//  Created by Grayson Webster on 8/26/16.
//  Copyright © 2016 Matthew York. All rights reserved.
//

import XCTest
@testable import DateToolsTests

class TimeChunkTests: XCTestCase {
    
    var controlChunkSeconds = TimeChunk()
    var controlChunkMinutes = TimeChunk()
    var controlChunkHours = TimeChunk()
    var controlChunkDays = TimeChunk()
    var controlChunkWeeks = TimeChunk()
    var controlChunkMonths = TimeChunk()
    var controlChunkYears = TimeChunk()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        controlChunkSeconds = 60.seconds
        controlChunkMinutes = 60.minutes
        controlChunkHours = 24.hours
        controlChunkDays = 7.days
        controlChunkWeeks = 5.weeks
        controlChunkMonths = 12.months
        controlChunkYears = 2.years
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    // MARK: - Comparisons
    
    func testEqualsSeconds() {
        let testChunk = 60.seconds
        XCTAssertTrue(controlChunkSeconds.equals(chunk: testChunk))
        XCTAssertFalse(controlChunkSeconds.equals(chunk: 1.minutes))
    }
    
    func testEqualsMinutes() {
        let testChunk = 60.minutes
        XCTAssertTrue(controlChunkMinutes.equals(chunk: testChunk))
        XCTAssertFalse(controlChunkMinutes.equals(chunk: 1.hours))
    }
    
    func testEqualsHours() {
        let testChunk = 24.hours
        XCTAssertTrue(controlChunkHours.equals(chunk: testChunk))
        XCTAssertFalse(controlChunkHours.equals(chunk: 25.hours))
    }
    
    func testEqualsDays() {
        let testChunk = 8.days
        XCTAssertTrue(controlChunkDays.equals(chunk: 7.days))
        XCTAssertFalse(controlChunkDays.equals(chunk: testChunk))
    }
    
    func testEqualsWeeks() {
        let testChunk = 5.weeks
        XCTAssertTrue(controlChunkWeeks.equals(chunk: testChunk))
        XCTAssertFalse(controlChunkWeeks.equals(chunk: 50.weeks))
    }
    
    func testEqualMonths() {
        let testChunk = 12.months
        XCTAssertTrue(controlChunkMonths.equals(chunk: testChunk))
        XCTAssertFalse(controlChunkMonths.equals(chunk: 15.months))
    }
    
    func testEqualYears() {
        let testChunk = TimeChunk(seconds: 43, minutes: 324, hours: 3, days: 342, weeks: 3, months: 4, years: 2)
        XCTAssertTrue(controlChunkYears.equals(chunk: 2.years))
        XCTAssertFalse(controlChunkYears.equals(chunk: testChunk))
    }
    
    
    
}
