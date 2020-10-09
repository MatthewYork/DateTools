//
//  DateFormatTests.swift
//  DateToolsTests
//
//  Created by Matthew York on 8/29/16.
//  Copyright © 2016 Matthew York. All rights reserved.
//

import XCTest
@testable import DateToolsSwift

class DateFormatTests: XCTestCase {
    
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
    
    
    // MARK: - Formatted Date - Style
    
    func testFormatStyle() {
        let testDate = Date(dateString: "2011 12 25 4:30:30.000", format: "yyyy MM dd HH:mm:ss.SSS")
        let formatString = testDate.format(with: DateFormatter.Style.long, timeZone: TimeZone.autoupdatingCurrent, locale: Locale.autoupdatingCurrent)
        XCTAssertTrue(formatString == "December 25, 2011")
    }
    
    func testFormatStyleWithoutTimezone() {
        let testDate = Date(dateString: "2011 12 25 4:30:30.000", format: "yyyy MM dd HH:mm:ss.SSS")
        let formatString = testDate.format(with: DateFormatter.Style.medium, locale: Locale.autoupdatingCurrent)
        XCTAssertTrue(formatString == "Dec 25, 2011")
    }
    
    func testFormatStyleWithoutLocale() {
        let testDate = Date(dateString: "2011 12 25 4:30:30.000", format: "yyyy MM dd HH:mm:ss.SSS")
        let formatString = testDate.format(with: DateFormatter.Style.short, timeZone: TimeZone.autoupdatingCurrent)
        XCTAssertTrue(formatString == "12/25/11")
    }
    
    func testFormatStyleAlone() {
        let testDate = Date(dateString: "2011 12 25 4:30:30.000", format: "yyyy MM dd HH:mm:ss.SSS")
        let formatString = testDate.format(with: DateFormatter.Style.full)
        XCTAssertTrue(formatString == "Sunday, December 25, 2011")
    }
    
    
    // MARK: - Formatted Date - String
    
    func testFormatString() {
        let testDate = Date(dateString: "2011 12 25 4:30:30.000", format: "yyyy MM dd HH:mm:ss.SSS")
        let formatString = testDate.format(with: "yyyy MM dd", timeZone: TimeZone.autoupdatingCurrent, locale: Locale.autoupdatingCurrent)
        XCTAssertTrue(formatString == "2011 12 25")
    }
    
    func testFormatStringWithoutTimezone() {
        let testDate = Date(dateString: "2011 12 25 4:30:30.000", format: "yyyy MM dd HH:mm:ss.SSS")
        let formatString = testDate.format(with: "dd-MM-yyyy", locale: Locale.autoupdatingCurrent)
        XCTAssertTrue(formatString == "25-12-2011")
    }
    
    func testFormatStringWithoutLocale() {
        let testDate = Date(dateString: "2011 12 25 4:30:30.000", format: "yyyy MM dd HH:mm:ss.SSS")
        let formatString = testDate.format(with: "MM/dd/yy", timeZone: TimeZone.autoupdatingCurrent)
        XCTAssertTrue(formatString == "12/25/11")
    }
    
    func testFormatStringAlone() {
        let testDate = Date(dateString: "2011 12 25 4:30:30.000", format: "yyyy MM dd HH:mm:ss.SSS")
        let formatString = testDate.format(with: "EEE, MMMM dd, yyyy")
        XCTAssertTrue(formatString == "Sun, December 25, 2011")
    }
    
}
