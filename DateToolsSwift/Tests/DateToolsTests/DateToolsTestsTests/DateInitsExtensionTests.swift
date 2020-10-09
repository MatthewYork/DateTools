//
//  DateDateToolsTests.swift
//  DateToolsTests
//
//  Created by Matthew York on 8/29/16.
//  Copyright © 2016 Matthew York. All rights reserved.
//

import XCTest
@testable import DateToolsSwift

class DateDateToolsTests: XCTestCase {
    
    var formatter = DateFormatter()
    var controlDate = Date()
    
    override func setUp() {
        super.setUp()
        self.formatter.dateFormat = "yyyy MM dd HH:mm:ss.SSS"
        controlDate = self.formatter.date(from: "2011 12 25 4:30:30.000")!
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInitWithAll() {
        let testDate = Date(year: 2011, month: 12, day: 25, hour: 4, minute: 30, second: 30)
        XCTAssertTrue(testDate == controlDate)
    }
    
    func testInitWithYearMonthDay() {
        let testDate = Date(year: 2011, month: 12, day: 25)
        XCTAssertTrue(testDate.year == controlDate.year && testDate.month == controlDate.month && testDate.day == controlDate.day)
    }
    
    func testInitWithDatestringFormatTimezone() {
        let testDate = Date(dateString: "2011 12 25 4:30:30.000", format: "yyyy MM dd HH:mm:ss.SSS", timeZone: TimeZone(abbreviation: "CST")!)
        self.formatter.timeZone = TimeZone(abbreviation: "CST")
        controlDate = self.formatter.date(from: "2011 12 25 4:30:30.000")!
        XCTAssertTrue(testDate == controlDate)
    }
    
    func testInitWithDatestringFormat() {
        let testDate = Date(dateString: "2011 12 25 4:30:30.000", format: "yyyy MM dd HH:mm:ss.SSS")
        XCTAssertTrue(testDate == controlDate)
    }
    
}
