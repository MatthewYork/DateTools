//
//  DateToolsTests.swift
//  DateTools
//
//  Created by Grayson Webster on 8/18/16.
//  Copyright © 2016 Grayson Webster. All rights reserved.
//

import XCTest

class DateToolsTests : XCTestCase {
    
    var formatter: DateFormatter?
    var controlDate: Date?
    
    override func setUp() {
        super.up = nil
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.formatter = DateFormatter()
        self.formatter?.dateFormat = "yyyy MM dd HH:mm:ss.SSS"
        self.controlDate = self.formatter?.date(from: "2014 11 05 18:15:12.000")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: - Date Components
    func testEra() {
        XCTAssertEqual(1, Date.date().era(), "%s Failed", file: #function)
    }
    
    func testYear() {
        XCTAssertEqual(2014, self.controlDate.year, "%s Failed", file: #function)
    }
    
    func testMonth() {
        XCTAssertEqual(11, self.controlDate.month, "%s Failed", file: #function)
    }
    
    func testDay() {
        XCTAssertEqual(5, self.controlDate.day, "%s Failed", file: #function)
    }
    
    func testHour() {
        XCTAssertEqual(18, self.controlDate.hour, "%s Failed", file: #function)
    }
    
    func testMinute() {
        XCTAssertEqual(15, self.controlDate.minute, "%s Failed", file: #function)
    }
    
    func testSecond() {
        XCTAssertEqual(12, self.controlDate.second, "%s Failed", file: #function)
    }
    
    func testWeekday() {
        XCTAssertEqual(4, self.controlDate.weekday, "%s Failed", file: #function)
    }
    
    func testWeekdayOrdinal() {
        XCTAssertEqual(1, self.controlDate.weekdayOrdinal, "%s Failed", file: #function)
    }
    
    func testQuarter() {
        //Quarter is a little funky right now
        //XCTAssertEqual(4, self.testDate.quarter, @"%s Failed", file: #function);
    }
    
    func testWeekOfMonth() {
        XCTAssertEqual(2, self.controlDate.weekOfMonth, "%s Failed", file: #function)
    }
    
    func testWeekOfYear() {
        XCTAssertEqual(45, self.controlDate.weekOfYear, "%s Failed", file: #function)
    }
    
    func testYearForWeekOfYear() {
        XCTAssertEqual(2014, self.controlDate.yearForWeekOfYear, "%s Failed", file: #function)
    }
    
    func testDaysInMonth() {
        XCTAssertEqual(30, self.controlDate.daysInMonth, "%s Failed", file: #function)
    }
    
    func testDaysInYear() {
        //Non leap year (2014)
        XCTAssertEqual(365, self.controlDate.daysInYear, "%s Failed", file: #function)
        //Leap year (2000)
        XCTAssertEqual(366, self.controlDate.dateBySubtractingYears(14).daysInYear, "%s Failed", file: #function)
    }
    
    func testIsInLeapYear() {
        //Not leap year
        XCTAssertFalse(self.controlDate.isInLeapYear(), "%s Failed", file: #function)
        //Is leap year (%400) 2000
        XCTAssertTrue(self.controlDate.dateBySubtractingYears(14).isInLeapYear(), "%s Failed", file: #function)
        //Not leap year (%100) 1900
        XCTAssertFalse(self.controlDate.dateBySubtractingYears(114).isInLeapYear(), "%s Failed", file: #function)
        //Is leap year (%4) 2016
        XCTAssertTrue(self.controlDate.dateByAddingYears(2).isInLeapYear(), "%s Failed", file: #function)
    }
    
    func testIsToday() {
        //Test true now
        XCTAssertTrue(Date.date().isToday, "%s Failed", file: #function)
        //Test true past (Technically, could fail if you ran the test precisely at midnight, but...)
        XCTAssertTrue(Date.date().dateBySubtractingSeconds(1).isToday, "%s Failed", file: #function)
        //Test true future (Technically, could fail if you ran the test precisely at midnight, but...)
        XCTAssertTrue(Date.date().dateByAddingSeconds(1).isToday, "%s Failed", file: #function)
        //Tests false past
        XCTAssertFalse(Date.date().dateBySubtractingDays(2).isToday, "%s Failed", file: #function)
        //Tests false future
        XCTAssertFalse(Date.date().dateByAddingDays(1).isToday, "%s Failed", file: #function)
    }
    
    func testIsTomorrow() {
        //Test false with now
        XCTAssertFalse(Date.date().isTomorrow, "%s Failed", file: #function)
        //Test false past
        XCTAssertFalse(Date.date().dateBySubtractingDays(1).isTomorrow, "%s Failed", file: #function)
        //Test true future
        XCTAssertTrue(Date.date().dateByAddingDays(1).isTomorrow, "%s Failed", file: #function)
        //Tests false future
        XCTAssertFalse(Date.date().dateByAddingDays(2).isTomorrow, "%s Failed", file: #function)
    }
    
    func testIsYesterday() {
        //Test false with now
        XCTAssertFalse(Date.date().isYesterday, "%s Failed", file: #function)
        //Test true past
        XCTAssertTrue(Date.date().dateBySubtractingDays(1).isYesterday, "%s Failed", file: #function)
        //Test false future
        XCTAssertFalse(Date.date().dateByAddingDays(1).isYesterday, "%s Failed", file: #function)
        //Tests false future
        XCTAssertFalse(Date.date().dateBySubtractingDays(2).isYesterday, "%s Failed", file: #function)
    }
    
    func testIsWeekend() {
        //Created test dates
        var testFriday: Date = self.formatter!.date(from: "2015 09 04 12:45:12.000")!
        var testMonday: Date = self.formatter!.date(from: "2015 02 16 00:00:00.000")!
        var testWeekend: Date = self.formatter!.date(from: "2015 09 05 17:45:12.000")!
        //Test false with friday and monday
        XCTAssertFalse(testFriday.isWeekend, "%s Failed", file: #function)
        XCTAssertFalse(testMonday.isWeekend, "%s Failed", file: #function)
        //Test true past
        XCTAssertTrue(testWeekend.isWeekend, "%s Failed", file: #function)
    }
    
    func testIsSameDay() {
        //Test same time stamp
        XCTAssertTrue(Date.date().isSameDay(Date.date()), "%s Failed", file: #function)
        //Test true same day
        var testSameDay1: Date = self.formatter!.date(from: "2014 11 05 12:45:12.000")!
        var testSameDay2: Date = self.formatter!.date(from: "2014 11 05 17:45:12.000")!
        XCTAssertTrue(testSameDay1.isSameDay(testSameDay2), "%s Failed", file: #function)
        //Test false 1 day ahead
        XCTAssertFalse(testSameDay1.isSameDay(Date.date().dateByAddingDays(1)), "%s Failed", file: #function)
        //Test false 1 day before
        XCTAssertFalse(testSameDay1.isSameDay(Date.date().dateBySubtractingDays(1)), "%s Failed", file: #function)
    }
    
    func testIsSameDayStatic() {
        //Test true same time stamp
        XCTAssertTrue(Date.isSameDay(Date.date(), asDate: Date.date()), "%s Failed", file: #function)
        //Test true same day
        var testSameDay1: Date = self.formatter!.date(from: "2014 11 05 12:45:12.000")!
        var testSameDay2: Date = self.formatter!.date(from: "2014 11 05 17:45:12.000")!
        XCTAssertTrue(Date.isSameDay(testSameDay1, asDate: testSameDay2), "%s Failed", file: #function)
        //Test false 1 day ahead
        XCTAssertFalse(Date.isSameDay(Date.date(), asDate: Date.date().dateByAddingDays(1)), "%s Failed", file: #function)
        //Test false 1 day before
        XCTAssertFalse(Date.isSameDay(Date.date(), asDate: Date.date().dateBySubtractingDays(1)), "%s Failed", file: #function)
    }
    
    // MARK: - Date Editing
    // MARK: Date Creating
    func testDateWithYearMonthDayHourMinuteSecond() {
        XCTAssertEqual(true, self.controlDate.isEqualToDate(Date(year: 2014, month: 11, day: 5, hour: 18, minute: 15, second: 12)), "%s Failed", file: #function)
    }
    
    func testDateWithStringFormatStringTimeZone() {
        var testDate: Date = Date(string: "2015-02-27T18:15:00", formatString: "yyyy-MM-dd'T'HH:mm:ss", timeZone: NSTimeZone(identifier: "UTC"))
        XCTAssertEqual(true, testDate.isEqualToDate(Date(string: "2015-02-27T19:15:00", formatString: "yyyy-MM-dd'T'HH:mm:ss", timeZone: NSTimeZone(name: "Europe/Warsaw"))), "%s Failed", file: #function)
    }
    
    // MARK: Date By Adding
    func testDateByAddingYears() {
        var testDate: Date = self.formatter!.date(from: "2016 11 05 18:15:12.000")!
        XCTAssertEqual(true, self.controlDate.dateByAddingYears(2).isEqualToDate(testDate), "%s Failed", file: #function)
    }
    
    func testDateByAddingMonths() {
        var testDate: Date = self.formatter!.date(from: "2015 01 05 18:15:12.000")!
        XCTAssertEqual(true, self.controlDate.dateByAddingMonths(2).isEqualToDate(testDate), "%s Failed", file: #function)
    }
    
    func testDateByAddingWeeks() {
        var testDate: Date = self.formatter!.date(from: "2014 11 12 18:15:12.000")!
        XCTAssertEqual(true, self.controlDate.dateByAddingWeeks(1).isEqualToDate(testDate), "%s Failed", file: #function)
    }
    
    func testDateByAddingDays() {
        var testDate: Date = self.formatter!.date(from: "2014 11 07 18:15:12.000")!
        XCTAssertEqual(true, self.controlDate.dateByAddingDays(2).isEqualToDate(testDate), "%s Failed", file: #function)
    }
    
    func testDateByAddingHours() {
        var testDate: Date = self.formatter!.date(from: "2014 11 06 6:15:12.000")!
        XCTAssertEqual(true, self.controlDate.dateByAddingHours(12).isEqualToDate(testDate), "%s Failed", file: #function)
    }
    
    func testDateByAddingMinutes() {
        var testDate: Date = self.formatter!.date(from: "2014 11 05 18:30:12.000")!
        XCTAssertEqual(true, self.controlDate.dateByAddingMinutes(15).isEqualToDate(testDate), "%s Failed", file: #function)
    }
    
    func testDateByAddingSeconds() {
        var testDate: Date = self.formatter!.date(from: "2014 11 05 18:16:12.000")!
        XCTAssertEqual(true, self.controlDate.dateByAddingSeconds(60).isEqualToDate(testDate), "%s Failed", file: #function)
    }
    
    // MARK: Date By Subtracting
    func testDateBySubtractingYears() {
        var testDate: Date = self.formatter!.date(from: "2000 11 05 18:15:12.000")!
        XCTAssertEqual(true, self.controlDate.dateBySubtractingYears(14).isEqualToDate(testDate), "%s Failed", file: #function)
    }
    
    func testDateBySubtractingMonths() {
        var testDate: Date = self.formatter!.date(from: "2014 4 05 18:15:12.000")!
        XCTAssertEqual(true, self.controlDate.dateBySubtractingMonths(7).isEqualToDate(testDate), "%s Failed", file: #function)
    }
    
    func testDateBySubtractingWeeks() {
        var testDate: Date = self.formatter!.date(from: "2014 10 29 18:15:12.000")!
        XCTAssertEqual(true, self.controlDate.dateBySubtractingWeeks(1).isEqualToDate(testDate), "%s Failed", file: #function)
    }
    
    func testDateBySubtractingDays() {
        var testDate: Date = self.formatter!.date(from: "2014 11 01 18:15:12.000")!
        XCTAssertEqual(true, self.controlDate.dateBySubtractingDays(4).isEqualToDate(testDate), "%s Failed", file: #function)
    }
    
    func testDateBySubtractingHours() {
        var testDate: Date = self.formatter!.date(from: "2014 11 05 00:15:12.000")!
        XCTAssertEqual(true, self.controlDate.dateBySubtractingHours(18).isEqualToDate(testDate), "%s Failed", file: #function)
    }
    
    func testDateBySubtractingMinutes() {
        var testDate: Date = self.formatter!.date(from: "2014 11 05 17:45:12.000")!
        XCTAssertEqual(true, self.controlDate.dateBySubtractingMinutes(30).isEqualToDate(testDate), "%s Failed", file: #function)
    }
    
    func testDateBySubtractingSeconds() {
        var testDate: Date = self.formatter!.date(from: "2014 11 05 18:14:12.000")!
        XCTAssertEqual(true, self.controlDate.dateBySubtractingSeconds(60).isEqualToDate(testDate), "%s Failed", file: #function)
    }
    
    // MARK: - Date Comparison
    // MARK: Time From
    func testYearsFrom() {
        //Under a year
        var testDate: Date = self.formatter!.date(from: "2014 11 12 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.yearsFrom(testDate), "%s Failed", file: #function)
        //Exactly a year
        var testDate2: Date = self.formatter!.date(from: "2015 11 05 18:15:12.000")!
        XCTAssertEqual(-1, self.controlDate.yearsFrom(testDate2), "%s Failed", file: #function)
        //Year number later, still less than a year
        var testDate3: Date = self.formatter!.date(from: "2015 11 04 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.yearsFrom(testDate3), "%s Failed", file: #function)
        //Year number earlier, still less than a year
        var testDate5: Date = self.formatter!.date(from: "2013 11 06 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.yearsFrom(testDate5), "%s Failed", file: #function)
        //Over a year earlier
        var testDate6: Date = self.formatter!.date(from: "2012 11 04 18:15:12.000")!
        XCTAssertEqual(2, self.controlDate.yearsFrom(testDate6), "%s Failed", file: #function)
        ///Over a year later
        var testDate7: Date = self.formatter!.date(from: "2017 11 12 18:15:12.000")!
        XCTAssertEqual(-3, self.controlDate.yearsFrom(testDate7), "%s Failed", file: #function)
        ///Over a year later, but less than a year in final comparison year
        var testDate8: Date = self.formatter!.date(from: "2017 11 3 18:15:12.000")!
        XCTAssertEqual(-2, self.controlDate.yearsFrom(testDate8), "%s Failed", file: #function)
        ///Over a year earlier, but less than a year in final comparison year
        var testDate9: Date = self.formatter!.date(from: "2012 11 8 18:15:12.000")!
        XCTAssertEqual(1, self.controlDate.yearsFrom(testDate9), "%s Failed", file: #function)
    }
    
    func testMonthsFrom() {
        //Under a month
        var testDate: Date = self.formatter!.date(from: "2014 11 12 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.monthsFrom(testDate), "%s Failed", file: #function)
        //Exactly a month
        var testDate2: Date = self.formatter!.date(from: "2014 12 05 18:15:12.000")!
        XCTAssertEqual(-1, self.controlDate.monthsFrom(testDate2), "%s Failed", file: #function)
        //Year number later, still less than a year
        var testDate3: Date = self.formatter!.date(from: "2015 11 04 18:15:12.000")!
        XCTAssertEqual(-11, self.controlDate.monthsFrom(testDate3), "%s Failed", file: #function)
        //Year number earlier, still less than a year
        var testDate5: Date = self.formatter!.date(from: "2013 11 06 18:15:12.000")!
        XCTAssertEqual(11, self.controlDate.monthsFrom(testDate5), "%s Failed", file: #function)
        //Over a year earlier
        var testDate6: Date = self.formatter!.date(from: "2012 11 04 18:15:12.000")!
        XCTAssertEqual(24, self.controlDate.monthsFrom(testDate6), "%s Failed", file: #function)
        ///Over a year later
        var testDate7: Date = self.formatter!.date(from: "2017 11 12 18:15:12.000")!
        XCTAssertEqual(-36, self.controlDate.monthsFrom(testDate7), "%s Failed", file: #function)
    }
    
    func testWeeksFrom() {
        //Same week
        var testSameDate: Date = self.formatter!.date(from: "2014 11 06 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.weeksFrom(testSameDate), "%s Failed", file: #function)
        //Same year
        var testDate: Date = self.formatter!.date(from: "2014 11 12 18:15:12.000")!
        XCTAssertEqual(-1, self.controlDate.weeksFrom(testDate), "%s Failed", file: #function)
        //Eariler year
        var testDate2: Date = self.formatter!.date(from: "2013 11 12 18:15:12.000")!
        XCTAssertEqual(51, self.controlDate.weeksFrom(testDate2), "%s Failed", file: #function)
        //Later year
        var testDate3: Date = self.formatter!.date(from: "2015 11 12 18:15:12.000")!
        XCTAssertEqual(-53, self.controlDate.weeksFrom(testDate3), "%s Failed", file: #function)
    }
    
    func testDaysFrom() {
        //Same day
        var testSameDate: Date = self.formatter!.date(from: "2014 11 05 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.daysFrom(testSameDate), "%s Failed", file: #function)
        //Same year
        var testDate: Date = self.formatter!.date(from: "2014 11 12 18:15:12.000")!
        XCTAssertEqual(-7, self.controlDate.daysFrom(testDate), "%s Failed", file: #function)
        //Eariler year
        var testDate2: Date = self.formatter!.date(from: "2013 11 12 18:15:12.000")!
        XCTAssertEqual(358, self.controlDate.daysFrom(testDate2), "%s Failed", file: #function)
        //Later year
        var testDate3: Date = self.formatter!.date(from: "2015 11 12 18:15:12.000")!
        XCTAssertEqual(-372, self.controlDate.daysFrom(testDate3), "%s Failed", file: #function)
    }
    
    func testHoursFrom() {
        //Later
        var testDate: Date = self.formatter!.date(from: "2014 11 05 20:15:12.000")!
        XCTAssertEqual(-2, self.controlDate.hoursFrom(testDate), "%s Failed", file: #function)
        //Earlier
        var testDate2: Date = self.formatter!.date(from: "2014 11 05 15:15:12.000")!
        XCTAssertEqual(3, self.controlDate.hoursFrom(testDate2), "%s Failed", file: #function)
    }
    
    func testMinutesFrom() {
        //Later
        var testDate: Date = self.formatter!.date(from: "2014 11 05 20:15:12.000")!
        XCTAssertEqual(-120, self.controlDate.minutesFrom(testDate), "%s Failed", file: #function)
        //Earlier
        var testDate2: Date = self.formatter!.date(from: "2014 11 05 15:15:12.000")!
        XCTAssertEqual(180, self.controlDate.minutesFrom(testDate2), "%s Failed", file: #function)
    }
    
    func testSecondsFrom() {
        //Later
        var testDate: Date = self.formatter!.date(from: "2014 11 05 20:15:12.000")!
        XCTAssertEqual(-7200, self.controlDate.secondsFrom(testDate), "%s Failed", file: #function)
        //Earlier
        var testDate2: Date = self.formatter!.date(from: "2014 11 05 15:15:12.000")!
        XCTAssertEqual(10800, self.controlDate.secondsFrom(testDate2), "%s Failed", file: #function)
    }
    
    // MARK: Earlier Than
    func testYearsEarlierThan() {
        //Under a year
        var testDate: Date = self.formatter!.date(from: "2014 11 12 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.yearsEarlierThan(testDate), "%s Failed", file: #function)
        //Exactly a year
        var testDate2: Date = self.formatter!.date(from: "2015 11 05 18:15:12.000")!
        XCTAssertEqual(1, self.controlDate.yearsEarlierThan(testDate2), "%s Failed", file: #function)
        //Year number later, still less than a year
        var testDate3: Date = self.formatter!.date(from: "2015 11 04 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.yearsEarlierThan(testDate3), "%s Failed", file: #function)
        //Year number earlier, still less than a year
        var testDate5: Date = self.formatter!.date(from: "2013 11 06 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.yearsEarlierThan(testDate5), "%s Failed", file: #function)
        //Over a year earlier
        var testDate6: Date = self.formatter!.date(from: "2012 11 04 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.yearsEarlierThan(testDate6), "%s Failed", file: #function)
        ///Over a year later
        var testDate7: Date = self.formatter!.date(from: "2017 11 12 18:15:12.000")!
        XCTAssertEqual(3, self.controlDate.yearsEarlierThan(testDate7), "%s Failed", file: #function)
        ///Over a year later, but less than a year in final comparison year
        var testDate8: Date = self.formatter!.date(from: "2017 11 3 18:15:12.000")!
        XCTAssertEqual(2, self.controlDate.yearsEarlierThan(testDate8), "%s Failed", file: #function)
        ///Over a year earlier, but less than a year in final comparison year
        var testDate9: Date = self.formatter!.date(from: "2012 11 8 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.yearsEarlierThan(testDate9), "%s Failed", file: #function)
    }
    
    func testMonthsEarlerThan() {
        //Under a month
        var testDate: Date = self.formatter!.date(from: "2014 11 12 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.monthsEarlierThan(testDate), "%s Failed", file: #function)
        //Exactly a month
        var testDate2: Date = self.formatter!.date(from: "2014 12 05 18:15:12.000")!
        XCTAssertEqual(1, self.controlDate.monthsEarlierThan(testDate2), "%s Failed", file: #function)
        //Year number later, still less than a year
        var testDate3: Date = self.formatter!.date(from: "2015 11 04 18:15:12.000")!
        XCTAssertEqual(11, self.controlDate.monthsEarlierThan(testDate3), "%s Failed", file: #function)
        //Year number earlier, still less than a year
        var testDate5: Date = self.formatter!.date(from: "2013 11 06 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.monthsEarlierThan(testDate5), "%s Failed", file: #function)
        //Over a year earlier
        var testDate6: Date = self.formatter!.date(from: "2012 11 04 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.monthsEarlierThan(testDate6), "%s Failed", file: #function)
        ///Over a year later
        var testDate7: Date = self.formatter!.date(from: "2017 11 12 18:15:12.000")!
        XCTAssertEqual(36, self.controlDate.monthsEarlierThan(testDate7), "%s Failed", file: #function)
    }
    
    func testWeeksEarlierThan() {
        //Same week
        var testSameDate: Date = self.formatter!.date(from: "2014 11 06 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.weeksEarlierThan(testSameDate), "%s Failed", file: #function)
        //Same year
        var testDate: Date = self.formatter!.date(from: "2014 11 12 18:15:12.000")!
        XCTAssertEqual(1, self.controlDate.weeksEarlierThan(testDate), "%s Failed", file: #function)
        //Eariler year
        var testDate2: Date = self.formatter!.date(from: "2013 11 12 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.weeksEarlierThan(testDate2), "%s Failed", file: #function)
        //Later year
        var testDate3: Date = self.formatter!.date(from: "2015 11 12 18:15:12.000")!
        XCTAssertEqual(53, self.controlDate.weeksEarlierThan(testDate3), "%s Failed", file: #function)
    }
    
    func testDaysEarlierThan() {
        //Same day
        var testSameDate: Date = self.formatter!.date(from: "2014 11 05 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.daysEarlierThan(testSameDate), "%s Failed", file: #function)
        //Same year
        var testDate: Date = self.formatter!.date(from: "2014 11 12 18:15:12.000")!
        XCTAssertEqual(7, self.controlDate.daysEarlierThan(testDate), "%s Failed", file: #function)
        //Eariler year
        var testDate2: Date = self.formatter!.date(from: "2013 11 12 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.daysEarlierThan(testDate2), "%s Failed", file: #function)
        //Later year
        var testDate3: Date = self.formatter!.date(from: "2015 11 12 18:15:12.000")!
        XCTAssertEqual(372, self.controlDate.daysEarlierThan(testDate3), "%s Failed", file: #function)
    }
    
    func testHoursEarlierThan() {
        //Later
        var testDate: Date = self.formatter!.date(from: "2014 11 05 20:15:12.000")!
        XCTAssertEqual(2, self.controlDate.hoursEarlierThan(testDate), "%s Failed", file: #function)
        //Earlier
        var testDate2: Date = self.formatter!.date(from: "2014 11 05 15:15:12.000")!
        XCTAssertEqual(0, self.controlDate.hoursEarlierThan(testDate2), "%s Failed", file: #function)
    }
    
    func testMinutesEarlierThan() {
        //Later
        var testDate: Date = self.formatter!.date(from: "2014 11 05 20:15:12.000")!
        XCTAssertEqual(120, self.controlDate.minutesEarlierThan(testDate), "%s Failed", file: #function)
        //Earlier
        var testDate2: Date = self.formatter!.date(from: "2014 11 05 15:15:12.000")!
        XCTAssertEqual(0, self.controlDate.minutesEarlierThan(testDate2), "%s Failed", file: #function)
    }
    
    func testSecondsEarlierThan() {
        //Later
        var testDate: Date = self.formatter!.date(from: "2014 11 05 20:15:12.000")!
        XCTAssertEqual(7200, self.controlDate.secondsEarlierThan(testDate), "%s Failed", file: #function)
        //Earlier
        var testDate2: Date = self.formatter!.date(from: "2014 11 05 15:15:12.000")!
        XCTAssertEqual(0, self.controlDate.secondsEarlierThan(testDate2), "%s Failed", file: #function)
    }
    
    // MARK: Later Than
    func testYearsLaterThan() {
        //Under a year
        var testDate: Date = self.formatter!.date(from: "2014 11 12 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.yearsLaterThan(testDate), "%s Failed", file: #function)
        //Exactly a year later
        var testDate2: Date = self.formatter!.date(from: "2015 11 05 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.yearsLaterThan(testDate2), "%s Failed", file: #function)
        //Exactly a year earlier
        var testDate3: Date = self.formatter!.date(from: "2013 11 05 18:15:12.000")!
        XCTAssertEqual(1, self.controlDate.yearsLaterThan(testDate3), "%s Failed", file: #function)
        //Year number later, still less than a year
        var testDate4: Date = self.formatter!.date(from: "2015 11 04 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.yearsLaterThan(testDate4), "%s Failed", file: #function)
        //Year number earlier, still less than a year
        var testDate5: Date = self.formatter!.date(from: "2013 11 06 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.yearsLaterThan(testDate5), "%s Failed", file: #function)
        //Over a year earlier
        var testDate6: Date = self.formatter!.date(from: "2012 11 04 18:15:12.000")!
        XCTAssertEqual(2, self.controlDate.yearsLaterThan(testDate6), "%s Failed", file: #function)
        ///Over a year later
        var testDate7: Date = self.formatter!.date(from: "2017 11 12 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.yearsLaterThan(testDate7), "%s Failed", file: #function)
        ///Over a year later, but less than a year in final comparison year
        var testDate8: Date = self.formatter!.date(from: "2017 11 3 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.yearsLaterThan(testDate8), "%s Failed", file: #function)
        ///Over a year earlier, but less than a year in final comparison year
        var testDate9: Date = self.formatter!.date(from: "2012 11 8 18:15:12.000")!
        XCTAssertEqual(1, self.controlDate.yearsLaterThan(testDate9), "%s Failed", file: #function)
    }
    
    func testMonthsLaterThan() {
        //Under a month
        var testDate: Date = self.formatter!.date(from: "2014 11 12 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.monthsLaterThan(testDate), "%s Failed", file: #function)
        //Exactly a month
        var testDate2: Date = self.formatter!.date(from: "2014 12 05 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.monthsLaterThan(testDate2), "%s Failed", file: #function)
        //Year number later, still less than a year
        var testDate3: Date = self.formatter!.date(from: "2015 11 04 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.monthsLaterThan(testDate3), "%s Failed", file: #function)
        //Year number earlier, still less than a year
        var testDate5: Date = self.formatter!.date(from: "2013 11 06 18:15:12.000")!
        XCTAssertEqual(11, self.controlDate.monthsLaterThan(testDate5), "%s Failed", file: #function)
        //Over a year earlier
        var testDate6: Date = self.formatter!.date(from: "2012 11 04 18:15:12.000")!
        XCTAssertEqual(24, self.controlDate.monthsLaterThan(testDate6), "%s Failed", file: #function)
        ///Over a year later
        var testDate7: Date = self.formatter!.date(from: "2017 11 12 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.monthsLaterThan(testDate7), "%s Failed", file: #function)
    }
    
    func testWeeksLaterThan() {
        //Same week
        var testSameDate: Date = self.formatter!.date(from: "2014 11 06 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.weeksLaterThan(testSameDate), "%s Failed", file: #function)
        //Same year later
        var testDate: Date = self.formatter!.date(from: "2014 11 12 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.weeksLaterThan(testDate), "%s Failed", file: #function)
        //Same year earlier
        var testDate2: Date = self.formatter!.date(from: "2014 10 24 18:15:12.000")!
        XCTAssertEqual(1, self.controlDate.weeksLaterThan(testDate2), "%s Failed", file: #function)
        //Eariler year
        var testDate3: Date = self.formatter!.date(from: "2013 11 12 18:15:12.000")!
        XCTAssertEqual(51, self.controlDate.weeksLaterThan(testDate3), "%s Failed", file: #function)
        //Later year
        var testDate4: Date = self.formatter!.date(from: "2015 11 12 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.weeksLaterThan(testDate4), "%s Failed", file: #function)
    }
    
    func testDaysLaterThan() {
        //Same day
        var testSameDate: Date = self.formatter!.date(from: "2014 11 05 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.daysLaterThan(testSameDate), "%s Failed", file: #function)
        //Same year later
        var testDate: Date = self.formatter!.date(from: "2014 11 12 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.daysLaterThan(testDate), "%s Failed", file: #function)
        //Same year earlier
        var testDate2: Date = self.formatter!.date(from: "2014 11 3 18:15:12.000")!
        XCTAssertEqual(2, self.controlDate.daysLaterThan(testDate2), "%s Failed", file: #function)
        //Eariler year
        var testDate3: Date = self.formatter!.date(from: "2013 11 12 18:15:12.000")!
        XCTAssertEqual(358, self.controlDate.daysLaterThan(testDate3), "%s Failed", file: #function)
        //Later year
        var testDate4: Date = self.formatter!.date(from: "2015 11 12 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.daysLaterThan(testDate4), "%s Failed", file: #function)
    }
    
    func testHoursLaterThan() {
        //Later
        var testDate: Date = self.formatter!.date(from: "2014 11 05 20:15:12.000")!
        XCTAssertEqual(0, self.controlDate.hoursLaterThan(testDate), "%s Failed", file: #function)
        //Earlier
        var testDate2: Date = self.formatter!.date(from: "2014 11 05 15:15:12.000")!
        XCTAssertEqual(3, self.controlDate.hoursLaterThan(testDate2), "%s Failed", file: #function)
    }
    
    func testMinutesLaterThan() {
        //Later
        var testDate: Date = self.formatter!.date(from: "2014 11 05 20:15:12.000")!
        XCTAssertEqual(0, self.controlDate.minutesLaterThan(testDate), "%s Failed", file: #function)
        //Earlier
        var testDate2: Date = self.formatter!.date(from: "2014 11 05 15:15:12.000")!
        XCTAssertEqual(180, self.controlDate.minutesLaterThan(testDate2), "%s Failed", file: #function)
    }
    
    func testSecondsLaterThan() {
        //Later
        var testDate: Date = self.formatter!.date(from: "2014 11 05 20:15:12.000")!
        XCTAssertEqual(0, self.controlDate.secondsLaterThan(testDate), "%s Failed", file: #function)
        //Earlier
        var testDate2: Date = self.formatter!.date(from: "2014 11 05 15:15:12.000")!
        XCTAssertEqual(10800, self.controlDate.secondsLaterThan(testDate2), "%s Failed", file: #function)
    }
    
    // MARK: Comparators
    func testIsEarlierThan() {
        //Later
        var testDate: Date = self.formatter!.date(from: "2014 11 05 20:15:12.000")!
        XCTAssertEqual(true, self.controlDate.isEarlierThan(testDate), "%s Failed", file: #function)
        //Earlier
        var testDate2: Date = self.formatter!.date(from: "2014 11 05 15:15:12.000")!
        XCTAssertEqual(false, self.controlDate.isEarlierThan(testDate2), "%s Failed", file: #function)
        //Same
        XCTAssertEqual(false, self.controlDate.isEarlierThan(self.controlDate), "%s Failed", file: #function)
    }
    
    func testIsLaterThan() {
        //Later
        var testDate: Date = self.formatter!.date(from: "2014 11 05 20:15:12.000")!
        XCTAssertEqual(false, self.controlDate.isLaterThan(testDate), "%s Failed", file: #function)
        //Earlier
        var testDate2: Date = self.formatter!.date(from: "2014 11 05 15:15:12.000")!
        XCTAssertEqual(true, self.controlDate.isLaterThan(testDate2), "%s Failed", file: #function)
        //Same
        XCTAssertEqual(false, self.controlDate.isLaterThan(self.controlDate), "%s Failed", file: #function)
    }
    
    func testisEarlierThanOrEqualTo() {
        //Later
        var testDate: Date = self.formatter!.date(from: "2014 11 05 20:15:12.000")!
        XCTAssertEqual(true, self.controlDate.isEarlierThanOrEqualTo(testDate), "%s Failed", file: #function)
        //Earlier
        var testDate2: Date = self.formatter!.date(from: "2014 11 05 15:15:12.000")!
        XCTAssertEqual(false, self.controlDate.isEarlierThanOrEqualTo(testDate2), "%s Failed", file: #function)
        //Same
        XCTAssertEqual(true, self.controlDate.isEarlierThanOrEqualTo(self.controlDate), "%s Failed", file: #function)
    }
    
    func testIsLaterOrEqualToDate() {
        //Later
        var testDate: Date = self.formatter!.date(from: "2014 11 05 20:15:12.000")!
        XCTAssertEqual(false, self.controlDate.isLaterThanOrEqualTo(testDate), "%s Failed", file: #function)
        //Earlier
        var testDate2: Date = self.formatter!.date(from: "2014 11 05 15:15:12.000")!
        XCTAssertEqual(true, self.controlDate.isLaterThanOrEqualTo(testDate2), "%s Failed", file: #function)
        //Same
        XCTAssertEqual(true, self.controlDate.isLaterThanOrEqualTo(self.controlDate), "%s Failed", file: #function)
    }
    
}
