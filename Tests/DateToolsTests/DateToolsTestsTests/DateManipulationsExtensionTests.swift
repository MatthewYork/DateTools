//
//  DateManipulationsExtensionTests.swift
//  DateToolsTests
//
//  Created by Grayson Webster on 9/30/16.
//  Copyright © 2016 Matthew York. All rights reserved.
//

import XCTest
@testable import DateToolsTests

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
        controlDate.start(of: .second)
        XCTAssertTrue(controlDate.second == 12)
    }
    
    func testStartOfMinute() {
        controlDate.start(of: .minute)
        XCTAssertTrue(controlDate.minute == 50)
        XCTAssertTrue(controlDate.second == 0)
    }
    
    func testStartOfHour() {
        controlDate.start(of: .hour)
        XCTAssertTrue(controlDate.hour == 14)
        XCTAssertTrue(controlDate.minute == 0)
        XCTAssertTrue(controlDate.second == 0)
    }
    
    func testStartOfDay() {
        controlDate.start(of: .day)
        XCTAssertTrue(controlDate.day == 24)
        XCTAssertTrue(controlDate.hour == 0)
        XCTAssertTrue(controlDate.minute == 0)
        XCTAssertTrue(controlDate.second == 0)
    }
    
    func testStartOfMonth() {
        controlDate.start(of: .month)
        XCTAssertTrue(controlDate.month == 11)
        XCTAssertTrue(controlDate.day == 1)
        XCTAssertTrue(controlDate.hour == 0)
        XCTAssertTrue(controlDate.minute == 0)
        XCTAssertTrue(controlDate.second == 0)
    }
    
    func testStartOfYear() {
        controlDate.start(of: .year)
        XCTAssertTrue(controlDate.year == 2015)
        XCTAssertTrue(controlDate.month == 1)
        XCTAssertTrue(controlDate.day == 1)
        XCTAssertTrue(controlDate.hour == 0)
        XCTAssertTrue(controlDate.minute == 0)
        XCTAssertTrue(controlDate.second == 0)
    }
    
    
    // MARK: - End Of
    
    func testEndOfSecond() {
        controlDate.end(of: .second)
        XCTAssertTrue(controlDate.second == 12)
    }
    
    func testEndOfMinute() {
        controlDate.end(of: .minute)
        XCTAssertTrue(controlDate.minute == 50)
        XCTAssertTrue(controlDate.second == 59)
    }
    
    func testEndOfHour() {
        controlDate.end(of: .hour)
        XCTAssertTrue(controlDate.hour == 14)
        XCTAssertTrue(controlDate.minute == 59)
        XCTAssertTrue(controlDate.second == 59)
    }
    
    func testEndOfDay() {
        controlDate.end(of: .day)
        XCTAssertTrue(controlDate.day == 24)
        XCTAssertTrue(controlDate.hour == 23)
        XCTAssertTrue(controlDate.minute == 59)
        XCTAssertTrue(controlDate.second == 59)
    }
    
    func testEndOfMonth() {
        controlDate.end(of: .month)
        XCTAssertTrue(controlDate.month == 11)
        XCTAssertTrue(controlDate.day == 30)
        XCTAssertTrue(controlDate.hour == 23)
        XCTAssertTrue(controlDate.minute == 59)
        XCTAssertTrue(controlDate.second == 59)
    }
    
    func testEndOfYear() {
        controlDate.end(of: .year)
        XCTAssertTrue(controlDate.year == 2015)
        XCTAssertTrue(controlDate.month == 12)
        XCTAssertTrue(controlDate.day == 31)
        XCTAssertTrue(controlDate.hour == 23)
        XCTAssertTrue(controlDate.minute == 59)
        XCTAssertTrue(controlDate.second == 59)
    }
    
    
    // MARK: - Addition
    
    func testAddition() {
        XCTAssertTrue(controlDate.add(5.days).day == 29)
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
    }
    
    func testSubtractionOperatorChunk() {
        XCTAssertTrue((controlDate - 5.days).day == 19)
    }
    
    func testSubtractionOperatorInt() {
        XCTAssertTrue((controlDate - 5 * Constants.SecondsInDay).day == 19)
    }
    
}
