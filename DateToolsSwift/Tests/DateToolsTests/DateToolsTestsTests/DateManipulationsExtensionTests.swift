//
//  DateManipulationsExtensionTests.swift
//  DateToolsTests
//
//  Created by Grayson Webster on 9/30/16.
//  Copyright © 2016 Matthew York. All rights reserved.
//

import XCTest
@testable import DateToolsSwift

class DateManipulationsTests: XCTestCase {
    
    let formatter = DateFormatter()
    var controlDate = Date()
    
    override func setUp() {
        super.setUp()
        formatter.dateFormat = "yyyy MM dd HH:mm:ss.SSS"
        controlDate = formatter.date(from: "2015 11 24 14:50:12.001")!
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Start Of
    
    func testStartOfSecond() {
        let testDate = controlDate.start(of: .second)
        XCTAssertTrue(testDate.second == 12)
    }
    
    func testStartOfMinute() {
        let testDate = controlDate.start(of: .minute)
        XCTAssertTrue(testDate.minute == 50)
        XCTAssertTrue(testDate.second == 0)
    }
    
    func testStartOfHour() {
        let testDate = controlDate.start(of: .hour)
        XCTAssertTrue(testDate.hour == 14)
        XCTAssertTrue(testDate.minute == 0)
        XCTAssertTrue(testDate.second == 0)
    }
    
    func testStartOfDay() {
        let testDate = controlDate.start(of: .day)
        XCTAssertTrue(testDate.day == 24)
        XCTAssertTrue(testDate.hour == 0)
        XCTAssertTrue(testDate.minute == 0)
        XCTAssertTrue(testDate.second == 0)
    }
    
    func testStartOfMonth() {
        let testDate = controlDate.start(of: .month)
        XCTAssertTrue(testDate.month == 11)
        XCTAssertTrue(testDate.day == 1)
        XCTAssertTrue(testDate.hour == 0)
        XCTAssertTrue(testDate.minute == 0)
        XCTAssertTrue(testDate.second == 0)
    }
    
    func testStartOfYear() {
        let testDate = controlDate.start(of: .year)
        XCTAssertTrue(testDate.year == 2015)
        XCTAssertTrue(testDate.month == 1)
        XCTAssertTrue(testDate.day == 1)
        XCTAssertTrue(testDate.hour == 0)
        XCTAssertTrue(testDate.minute == 0)
        XCTAssertTrue(testDate.second == 0)
    }
    
    
    // MARK: - End Of
    
    func testEndOfSecond() {
        let testDate = controlDate.end(of: .second)
        XCTAssertTrue(testDate.second == 12)
    }
    
    func testEndOfMinute() {
        let testDate = controlDate.end(of: .minute)
        XCTAssertTrue(testDate.minute == 50)
        XCTAssertTrue(testDate.second == 59)
    }
    
    func testEndOfHour() {
        let testDate = controlDate.end(of: .hour)
        XCTAssertTrue(testDate.hour == 14)
        XCTAssertTrue(testDate.minute == 59)
        XCTAssertTrue(testDate.second == 59)
    }
    
    func testEndOfDay() {
        let testDate = controlDate.end(of: .day)
        XCTAssertTrue(testDate.day == 24)
        XCTAssertTrue(testDate.hour == 23)
        XCTAssertTrue(testDate.minute == 59)
        XCTAssertTrue(testDate.second == 59)
    }
    
    func testEndOfMonth() {
        let testDate = controlDate.end(of: .month)
        XCTAssertTrue(testDate.month == 11)
        XCTAssertTrue(testDate.day == 30)
        XCTAssertTrue(testDate.hour == 23)
        XCTAssertTrue(testDate.minute == 59)
        XCTAssertTrue(testDate.second == 59)
    }
    
    func testEndOfYear() {
        let testDate = controlDate.end(of: .year)
        XCTAssertTrue(testDate.year == 2015)
        XCTAssertTrue(testDate.month == 12)
        XCTAssertTrue(testDate.day == 31)
        XCTAssertTrue(testDate.hour == 23)
        XCTAssertTrue(testDate.minute == 59)
        XCTAssertTrue(testDate.second == 59)
    }
    
    
    // MARK: - Addition
    
    func testAddition() {
        XCTAssertTrue(controlDate.add(5.days).day == 29)
        
        let testDate = formatter.date(from: "2016 10 19 18:40:24.001")!
        let testChunk = TimeChunk(seconds: 12, minutes: -10, hours: 4, days: 2, weeks: -1, months: -1, years: 1)
        let testAddedDate = controlDate + testChunk;
        XCTAssertTrue(testAddedDate == testDate)
    }
    
    func testAdditionOperatorChunk() {
        XCTAssertTrue((controlDate + 5.days).day == 29)
    }
    
    func testAdditionOperatorInt() {
        XCTAssertTrue((controlDate + 5 * Constants.SecondsInDay).day == 29)
    }
    
    
    // MARK: - Subtraction

    func testSubtraction() {
        XCTAssertTrue(controlDate.subtract(5.days).day == 19)
        
        let testDate = formatter.date(from: "2016 10 19 18:40:24.001")!
        let testChunk = TimeChunk(seconds: -12, minutes: 10, hours: -4, days: -2, weeks: 1, months: 1, years: -1)
        let testAddedDate = controlDate - testChunk;
        XCTAssertTrue(testAddedDate == testDate)
    }
    
    func testSubtractionOperatorChunk() {
        XCTAssertTrue((controlDate - 5.days).day == 19)
    }
    
    func testSubtractionOperatorInt() {
        XCTAssertTrue((controlDate - 5 * Constants.SecondsInDay).day == 19)
    }
    
}
