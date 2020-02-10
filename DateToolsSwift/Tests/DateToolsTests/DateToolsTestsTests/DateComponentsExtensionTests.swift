//
//  DateComponents.swift
//  DateToolsTests
//
//  Created by Matthew York on 8/29/16.
//  Copyright © 2016 Matthew York. All rights reserved.
//

import XCTest
@testable import DateToolsSwift

class DateComponentsTests: XCTestCase {
    
    var controlDate = Date()
    var formatter = DateFormatter()
    var formatterWithQuarter = DateFormatter()
    
    override func setUp() {
        super.setUp()
        self.formatter.dateFormat = "yyyy MM dd HH:mm:ss.SSS"
        self.controlDate = formatter.date(from: "2014 11 05 18:15:12.000")!
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testComponent() {
        let testDate = self.formatter.date(from: "2014 04 26 18:15:12.000")!
        XCTAssertTrue(testDate.component(.year) == controlDate.component(.year))
    }
    
    func testOrdinality() {
        let testDate = self.formatter.date(from: "2014 11 26 18:15:12.000")!
        XCTAssertTrue(testDate.ordinality(of: .month, in: .year) == controlDate.ordinality(of: .month, in: .year))
        XCTAssertFalse(testDate.ordinality(of: .day, in: .year) == controlDate.ordinality(of: .day, in: .year))
    }
    
//    func testUnit() {
//        let testDate = self.formatter.date(from: "2014 05 26 18:15:12.000")!
//        let testDate2 = self.formatter.date(from: "2012 05 26 18:15:12.000")!
//        let testDate3 = self.formatter.date(from: "2012 02 26 18:15:12.000")!
//        
//        XCTAssertTrue(testDate.unit(of: .month, in: .year) == 12)
//        XCTAssertTrue(testDate.unit(of: .day, in: .month) == 31)
//        XCTAssertTrue(testDate.unit(of: .day, in: .year) == 365)
//        XCTAssertTrue(testDate.unit(of: .hour, in: .year) == 365 * 24)
//        XCTAssertTrue(testDate.unit(of: .minute, in: .day) == 60 * 24)
//        XCTAssertTrue(testDate.unit(of: .day, in: .minute) == nil)
//        XCTAssertTrue(testDate.unit(of: .second, in: .minute) == 60)
//        XCTAssertTrue(testDate.unit(of: .weekday, in: .month) == nil)
//        XCTAssertTrue(testDate.unit(of: .second, in: .month) == 60 * 60 * 24 * 31)
//        XCTAssertTrue(testDate.unit(of: .second, in: .year) == 60 * 60 * 24 * 365)
//        // Leap year test
//        XCTAssertTrue(testDate2.unit(of: .day, in: .year) == 366)
//        XCTAssertTrue(testDate2.unit(of: .hour, in: .year) == 366 * 24)
//        XCTAssertTrue(testDate2.unit(of: .second, in: .year) == 60 * 60 * 24 * 366)
//        XCTAssertTrue(testDate3.unit(of: .day, in: .month) == 29)
//        // Equality test
//        XCTAssertTrue(testDate.unit(of: .day, in: .month)! == controlDate.unit(of: .day, in: .month)! + 1)
//    }
    
    
    // MARK: - Components
    
    func testEra() {
        let testDate = self.formatter.date(from: "2014 05 26 18:15:12.000")!
        XCTAssertTrue(testDate.era == controlDate.era)
    }
    
    func testYear() {
        let testDate = self.formatter.date(from: "2014 05 26 18:15:12.000")!
        let testDate2 = self.formatter.date(from: "2013 05 26 18:15:12.000")!
        XCTAssertTrue(testDate.year == controlDate.year)
        XCTAssertFalse(testDate2.year == controlDate.year)
    }
    
    func testMonth() {
        let testDate = self.formatter.date(from: "2014 11 26 18:15:12.000")!
        let testDate2 = self.formatter.date(from: "2013 05 26 18:15:12.000")!
        XCTAssertTrue(testDate.month == controlDate.month)
        XCTAssertFalse(testDate2.month == controlDate.month)
    }
    
    func testDay() {
        let testDate = self.formatter.date(from: "2014 08 05 18:45:12.000")!
        let testDate2 = self.formatter.date(from: "2013 05 26 16:15:12.000")!
        XCTAssertTrue(testDate.day == controlDate.day)
        XCTAssertFalse(testDate2.day == controlDate.day)
    }
    
    func testHour() {
        let testDate = self.formatter.date(from: "2014 08 05 18:45:12.000")!
        let testDate2 = self.formatter.date(from: "2013 05 26 16:15:12.000")!
        XCTAssertTrue(testDate.hour == controlDate.hour)
        XCTAssertFalse(testDate2.hour == controlDate.hour)
    }
    
    func testMinute() {
        let testDate = self.formatter.date(from: "2014 08 05 18:15:12.000")!
        let testDate2 = self.formatter.date(from: "2013 05 26 16:23:12.000")!
        XCTAssertTrue(testDate.minute == controlDate.minute)
        XCTAssertFalse(testDate2.minute == controlDate.minute)
    }
    
    func testSecond() {
        let testDate = self.formatter.date(from: "2014 08 05 18:15:12.000")!
        let testDate2 = self.formatter.date(from: "2013 05 26 16:23:15.000")!
        XCTAssertTrue(testDate.second == controlDate.second)
        XCTAssertFalse(testDate2.second == controlDate.second)
    }
    
    func testWeekday() {
        let testDate = self.formatter.date(from: "2014 11 12 18:15:12.000")!
        let testDate2 = self.formatter.date(from: "2014 11 13 16:23:15.000")!
        XCTAssertTrue(testDate.weekday == controlDate.weekday)
        XCTAssertFalse(testDate2.weekday == controlDate.weekday)
    }
    
    func testWeekdayOrdinal() {
        let testDate = self.formatter.date(from: "2014 12 1 18:15:12.000")!
        let testDate2 = self.formatter.date(from: "2014 11 13 16:23:15.000")!
        XCTAssertTrue(testDate.weekdayOrdinal == controlDate.weekdayOrdinal)
        XCTAssertFalse(testDate2.weekdayOrdinal == controlDate.weekdayOrdinal)
    }
    
    func testQuarter() {
        // Apple has a bug in their quarter component where it does not interpret the quarter
//        let testDate = self.formatterWithQuarter.date(from: "4 2016 12 1 18:15:12.000")!
//        let testDate2 = self.formatterWithQuarter.date(from: "1 2014 1 13 16:23:15.000")!
//        print(testDate.quarter)
//        print(controlDate.quarter)
//        XCTAssertTrue(testDate.quarter == controlDate.quarter)
//        XCTAssertFalse(testDate2.quarter == controlDate.quarter)
    }
    
    func testWeekOfMonth() {
        let testDate = self.formatter.date(from: "2014 11 06 18:15:12.000")!
        let testDate2 = self.formatter.date(from: "2014 11 21 16:23:15.000")!
        XCTAssertTrue(testDate.weekOfMonth == controlDate.weekOfMonth)
        XCTAssertFalse(testDate2.weekOfMonth == controlDate.weekOfMonth)
    }
    
    func testWeekOfYear() {
        let testDate = self.formatter.date(from: "2014 11 06 18:15:12.000")!
        let testDate2 = self.formatter.date(from: "2014 11 21 16:23:15.000")!
        XCTAssertTrue(testDate.weekOfYear == controlDate.weekOfYear)
        XCTAssertFalse(testDate2.weekOfYear == controlDate.weekOfYear)
    }
    
    func testYearForWeekOfYear() {
        let testDate = self.formatter.date(from: "2015 12 31 18:15:12.000")!
        let testDate2 = self.formatter.date(from: "2014 11 21 16:23:15.000")!
        XCTAssertTrue(testDate.yearForWeekOfYear == 2016)
        XCTAssertFalse(testDate2.yearForWeekOfYear == 2015)
    }
    
    
    // MARK: - Bools
    
    func testIsInLeapYear() {
        let testDate = self.formatter.date(from: "2000 12 31 18:15:12.000")!
        let testDate2 = self.formatter.date(from: "1900 11 21 16:23:15.000")!
        let testDate3 = self.formatter.date(from: "1992 11 21 16:23:15.000")!
        XCTAssertTrue(testDate.isInLeapYear)
        XCTAssertFalse(testDate2.isInLeapYear)
        XCTAssertTrue(testDate3.isInLeapYear)
    }
    
    func testIsToday() {
        let testDate = self.formatter.date(from: "2000 12 31 18:15:12.000")!
        let testDate2 = Date()
        XCTAssertFalse(testDate.isToday)
        XCTAssertTrue(testDate2.isToday)
    }
    
    func testIsTomorrow() {
        let testDate = self.formatter.date(from: "2000 12 31 18:15:12.000")!
        let testDate2 = Date() + 1.days
        XCTAssertFalse(testDate.isTomorrow)
        XCTAssertTrue(testDate2.isTomorrow)
    }
    
    func testIsYesterday() {
        let testDate = self.formatter.date(from: "2000 12 31 18:15:12.000")!
        let testDate2 = Date() - 1.days
        XCTAssertFalse(testDate.isYesterday)
        XCTAssertTrue(testDate2.isYesterday)
    }
    
    func testIsWeekend() {
        let testDate = self.formatter.date(from: "2016 09 25 18:15:12.000")!
        let testDate2 = self.formatter.date(from: "2016 09 24 18:15:12.000")!
        let testDate3 = self.formatter.date(from: "2016 09 23 18:15:12.000")!
        XCTAssertTrue(testDate.isWeekend)
        XCTAssertTrue(testDate2.isWeekend)
        XCTAssertFalse(testDate3.isWeekend)
    }
    
    func testDaysInMonth() {
        XCTAssertEqual(30, self.controlDate.daysInMonth)
    }
}
