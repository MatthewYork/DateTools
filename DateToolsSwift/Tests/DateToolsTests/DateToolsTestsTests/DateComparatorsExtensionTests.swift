//
//  DateComparators.swift
//  DateToolsTests
//
//  Created by Matthew York on 8/29/16.
//  Copyright © 2016 Matthew York. All rights reserved.
//

import XCTest
@testable import DateToolsSwift

class DateComparatorsTests: XCTestCase {
    
    var controlDate = Date()
    var formatter = DateFormatter()
    
    override func setUp() {
        super.setUp()
        self.formatter.dateFormat = "yyyy MM dd HH:mm:ss.SSS"
        self.controlDate = self.formatter.date(from: "2016 09 16 13:30:25.000")!
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testChunkBetweenFuture() {
        let testDate1 = self.formatter.date(from: "2018 09 16 13:30:25.000")!
        var resultChunk = self.controlDate.chunkBetween(date: testDate1)
        XCTAssertTrue(resultChunk.years == 2)
        
        let testDate2 = self.formatter.date(from: "2018 08 14 13:30:25.000")!
        resultChunk = self.controlDate.chunkBetween(date: testDate2)
        XCTAssertTrue(resultChunk.years == 1 && resultChunk.months == 10 && resultChunk.days == 29)
        
        let testDate3 = self.formatter.date(from: "2020 03 09 13:30:25.000")! // Leap year
        resultChunk = self.controlDate.chunkBetween(date: testDate3)
        XCTAssertTrue(resultChunk.years == 3 && resultChunk.months == 5 && resultChunk.days == 22)
        
        let testDate4 = self.formatter.date(from: "2018 08 14 11:28:24.000")!
        resultChunk = self.controlDate.chunkBetween(date: testDate4)
        XCTAssertTrue(resultChunk.years == 1 && resultChunk.months == 10 && resultChunk.days == 28 && resultChunk.hours == 21 && resultChunk.minutes == 57 && resultChunk.seconds == 59)
    }
    
    func testChunkBetweenPast() {
        let testDate1 = self.formatter.date(from: "2012 09 16 13:30:25.000")!
        var resultChunk = self.controlDate.chunkBetween(date: testDate1)
        XCTAssertTrue(resultChunk.years == -4)
        
        let testDate2 = self.formatter.date(from: "2012 08 16 13:30:25.000")!
        resultChunk = self.controlDate.chunkBetween(date: testDate2)
        XCTAssertTrue(resultChunk.years == -4 && resultChunk.months == -1)
        
        let testDate3 = self.formatter.date(from: "2012 10 16 13:30:25.000")!
        resultChunk = self.controlDate.chunkBetween(date: testDate3)
        XCTAssertTrue(resultChunk.years == -3 && resultChunk.months == -11)
        
        let testDate4 = self.formatter.date(from: "2012 10 19 13:30:25.000")!
        resultChunk = self.controlDate.chunkBetween(date: testDate4)
        XCTAssertTrue(resultChunk.years == -3 && resultChunk.months == -10 && resultChunk.days == -28)
        
        let testDate5 = self.formatter.date(from: "2012 02 19 13:30:25.000")! // Leap year
        resultChunk = self.controlDate.chunkBetween(date: testDate5)
        XCTAssertTrue(resultChunk.years == -4 && resultChunk.months == -6 && resultChunk.days == -26)
        
        let testDate6 = self.formatter.date(from: "2012 10 19 17:40:45.000")!
        resultChunk = self.controlDate.chunkBetween(date: testDate6)
        XCTAssertTrue(resultChunk.years == -3 && resultChunk.months == -10 && resultChunk.days == -27 && resultChunk.hours == -19 && resultChunk.minutes == -49 && resultChunk.seconds == -40)
        
        self.controlDate = self.formatter.date(from: "2016 01 16 13:30:25.000")!
        let testDate7 = self.formatter.date(from: "2012 02 18 13:30:25.000")! // Leap year
        resultChunk = self.controlDate.chunkBetween(date: testDate7)
        XCTAssertTrue(resultChunk.years == -3 && resultChunk.months == -10 && resultChunk.days == -27)
        
    }
    
    
    // MARK: - Comparisons
    func testEquals() {
        let compDate1 = self.formatter.date(from: "2016 01 16 13:30:25.000")!
        var compDate2 = self.formatter.date(from: "2016 01 16 13:30:25.000")!
        
        XCTAssertTrue(compDate1 == compDate2)
        XCTAssertTrue(compDate1.equals(compDate2))
        
        compDate2 = self.formatter.date(from: "2016 01 16 13:30:25.001")!
        XCTAssertFalse(compDate1 == compDate2)
        XCTAssertFalse(compDate1.equals(compDate2))
    }
    
    func testIsLater() {
        let compDate1 = self.formatter.date(from: "2016 01 16 13:30:25.001")!
        var compDate2 = self.formatter.date(from: "2016 01 16 13:30:25.000")!
        
        XCTAssertTrue(compDate1.isLater(than: compDate2))
        
        compDate2 = self.formatter.date(from: "2016 01 16 13:30:25.002")!
        XCTAssertFalse(compDate1.isLater(than: compDate2))
        
        compDate2 = self.formatter.date(from: "2016 01 16 13:30:25.001")!
        XCTAssertFalse(compDate1.isLater(than: compDate2))
    }
    
    func testIsLaterOrEqual() {
        let compDate1 = self.formatter.date(from: "2016 01 16 13:30:25.001")!
        var compDate2 = self.formatter.date(from: "2016 01 16 13:30:25.000")!
        
        XCTAssertTrue(compDate1.isLaterThanOrEqual(to: compDate2))
        
        compDate2 = self.formatter.date(from: "2016 01 16 13:30:25.002")!
        XCTAssertFalse(compDate1.isLaterThanOrEqual(to: compDate2))
        
        compDate2 = self.formatter.date(from: "2016 01 16 13:30:25.001")!
        XCTAssertTrue(compDate1.isLaterThanOrEqual(to: compDate2))
    }
    
    func testEarlier() {
        let compDate1 = self.formatter.date(from: "2016 01 16 13:30:25.000")!
        var compDate2 = self.formatter.date(from: "2016 01 16 13:30:25.001")!
        
        XCTAssertTrue(compDate1.isEarlier(than: compDate2))
        
        compDate2 = self.formatter.date(from: "2016 01 16 13:30:24.999")!
        XCTAssertFalse(compDate1.isEarlier(than: compDate2))
        
        compDate2 = self.formatter.date(from: "2016 01 16 13:30:25.000")!
        XCTAssertFalse(compDate1.isEarlier(than: compDate2))
    }
    
    func testEarlierOrEqual() {
        let compDate1 = self.formatter.date(from: "2016 01 16 13:30:25.000")!
        var compDate2 = self.formatter.date(from: "2016 01 16 13:30:25.001")!
        
        XCTAssertTrue(compDate1.isEarlierThanOrEqual(to: compDate2))
        
        compDate2 = self.formatter.date(from: "2016 01 16 13:30:24.999")!
        XCTAssertFalse(compDate1.isEarlierThanOrEqual(to: compDate2))
        
        compDate2 = self.formatter.date(from: "2016 01 16 13:30:25.000")!
        XCTAssertTrue(compDate1.isEarlierThanOrEqual(to: compDate2))
    }
    
    // MARK: - Date Comparison
    func testYears() {
        //Under a year
        let testDate = self.formatter.date(from: "2016 11 12 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.years(from: testDate))
        
        //Exactly a year
        let testDate2 = self.formatter.date(from: "2017 09 16 13:30:25.000")!
        XCTAssertEqual(-1, self.controlDate.years(from: testDate2))
        
        //Year number later, still less than a year
        let testDate3 = self.formatter.date(from: "2017 01 16 13:30:25.000")!
        XCTAssertEqual(0, self.controlDate.years(from: testDate3))
        
        //Year number earlier, still less than a year
        let testDate5 = self.formatter.date(from: "2015 11 16 13:30:25.000")!
        XCTAssertEqual(0, self.controlDate.years(from: testDate5))
        
        //Over a year earlier
        let testDate6 = self.formatter.date(from: "2014 09 16 13:30:25.000")!
        XCTAssertEqual(2, self.controlDate.years(from: testDate6))
        
        //Over a year later
        let testDate7 = self.formatter.date(from: "2019 11 12 18:15:12.000")!
        XCTAssertEqual(-3, self.controlDate.years(from: testDate7))
        
        //Over a year later, but less than a year in final comparison year
        let testDate8 = self.formatter.date(from: "2019 09 01 13:30:25.000")!
        XCTAssertEqual(-2,self.controlDate.years(from: testDate8))
        
        ///Over a year earlier, but less than a year in final comparison year
        let testDate9 = self.formatter.date(from: "2014 09 17 13:30:25.000")!
        XCTAssertEqual(1, self.controlDate.years(from: testDate9))
    }
    
    func testMonths() {
        //Under a month
        let testDate = self.formatter.date(from: "2016 09 12 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.months(from: testDate))
        
        //Exactly a month
        let testDate2 = self.formatter.date(from: "2016 10 16 13:30:25.000")!
        XCTAssertEqual(-1, self.controlDate.months(from: testDate2))
        
        //Year number later, still less than a year
        let testDate3 = self.formatter.date(from: "2017 08 16 13:30:25.000")!
        XCTAssertEqual(-11, self.controlDate.months(from: testDate3))
        
        //Year number earlier, still less than a year
        let testDate5 = self.formatter.date(from: "2015 10 16 13:30:25.000")!
        XCTAssertEqual(11, self.controlDate.months(from: testDate5))
        
        //Over a year earlier
        let testDate6 = self.formatter.date(from: "2014 09 16 13:30:25.000")!
        XCTAssertEqual(24, self.controlDate.months(from: testDate6))
        
        //Over a year later
        let testDate7 = self.formatter.date(from: "2019 10 12 18:15:12.000")!
        XCTAssertEqual(-36, self.controlDate.months(from: testDate7))
    }
    
    func testWeeks() {
        //Same week
        let testSameDate = self.formatter.date(from: "2016 09 12 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.weeks(from: testSameDate))
        
        //Same year
        let testDate = self.formatter.date(from: "2016 09 26 18:15:12.000")!
        XCTAssertEqual(-1, self.controlDate.weeks(from: testDate))
        
        //Earlier year
        let testDate2 = self.formatter.date(from: "2015 9 23 13:30:25.000")!
        XCTAssertEqual(51, self.controlDate.weeks(from: testDate2))
        
        //Later year
        let testDate3 = self.formatter.date(from: "2017 9 23 13:30:25.000")!
        XCTAssertEqual(-53, self.controlDate.weeks(from: testDate3))
    }
    
    func testDays() {
        //Same day
        let testSameDate = self.formatter.date(from: "2016 09 16 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.days(from: testSameDate))
        
        //Same year
        let testDate = self.formatter.date(from: "2016 09 17 18:15:12.000")!
        XCTAssertEqual(-1, self.controlDate.days(from: testDate))
        
        //Earlier year
        let testDate2 = self.formatter.date(from: "2015 9 23 13:30:25.000")!
        XCTAssertEqual(359, self.controlDate.days(from: testDate2)) //Would be 358, but leap year!
        
        //Later year
        let testDate3 = self.formatter.date(from: "2017 9 23 13:30:25.000")!
        XCTAssertEqual(-372, self.controlDate.days(from: testDate3))
    }
    
    func testHours() {
        //Same year
        let testDate = self.formatter.date(from: "2016 09 16 18:15:12.000")!
        XCTAssertEqual(-4, self.controlDate.hours(from: testDate))
        
        //Earlier year
        let testDate2 = self.formatter.date(from: "2016 9 16 10:30:25.000")!
        XCTAssertEqual(3, self.controlDate.hours(from: testDate2))
    }
    
    func testMinutes() {
        //Later
        let testDate = self.formatter.date(from: "2016 09 16 15:30:25.000")!
        XCTAssertEqual(-120, self.controlDate.minutes(from: testDate))
        
        //Earlier
        let testDate2 = self.formatter.date(from: "2016 9 16 10:30:25.000")!
        XCTAssertEqual(180, self.controlDate.minutes(from: testDate2))
    }
    
    func testSeconds() {
        //Same
        let testSameDate = self.formatter.date(from: "2016 09 16 13:30:25.000")!
        XCTAssertEqual(0, self.controlDate.seconds(from: testSameDate))
        
        //Later
        let testDate = self.formatter.date(from: "2016 09 16 15:30:25.000")!
        XCTAssertEqual(-7200, self.controlDate.seconds(from: testDate))
        
        //Earlier
        let testDate2 = self.formatter.date(from: "2016 9 16 10:30:25.000")!
        XCTAssertEqual(10800, self.controlDate.seconds(from: testDate2))
    }
    
    // MARK: Time From With Calendar
    
    func testYearsFromWithCalendar() {
        //Under a year
        let testDate = self.formatter.date(from: "2016 11 12 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.years(from: testDate, calendar: Calendar.autoupdatingCurrent))
        
        //Exactly a year
        let testDate2 = self.formatter.date(from: "2017 09 16 13:30:25.000")!
        XCTAssertEqual(-1, self.controlDate.years(from: testDate2, calendar: Calendar.autoupdatingCurrent))
        
        //Year number later, still less than a year
        let testDate3 = self.formatter.date(from: "2017 01 16 13:30:25.000")!
        XCTAssertEqual(0, self.controlDate.years(from: testDate3, calendar: Calendar.autoupdatingCurrent))
        
        //Year number earlier, still less than a year
        let testDate5 = self.formatter.date(from: "2015 11 16 13:30:25.000")!
        XCTAssertEqual(0, self.controlDate.years(from: testDate5, calendar: Calendar.autoupdatingCurrent))
        
        //Over a year earlier
        let testDate6 = self.formatter.date(from: "2014 09 16 13:30:25.000")!
        XCTAssertEqual(2, self.controlDate.years(from: testDate6, calendar: Calendar.autoupdatingCurrent))
        
        //Over a year later
        let testDate7 = self.formatter.date(from: "2019 11 12 18:15:12.000")!
        XCTAssertEqual(-3, self.controlDate.years(from: testDate7, calendar: Calendar.autoupdatingCurrent))
        
        //Over a year later, but less than a year in final comparison year
        let testDate8 = self.formatter.date(from: "2019 09 01 13:30:25.000")!
        XCTAssertEqual(-2,self.controlDate.years(from: testDate8, calendar: Calendar.autoupdatingCurrent))
        
        ///Over a year earlier, but less than a year in final comparison year
        let testDate9 = self.formatter.date(from: "2014 09 17 13:30:25.000")!
        XCTAssertEqual(1, self.controlDate.years(from: testDate9, calendar: Calendar.autoupdatingCurrent))
    }
    
    func testMonthsFromWithCalendar() {
        //Under a month
        let testDate = self.formatter.date(from: "2016 09 12 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.months(from: testDate, calendar: Calendar.autoupdatingCurrent))
        
        //Exactly a month
        let testDate2 = self.formatter.date(from: "2016 10 16 13:30:25.000")!
        XCTAssertEqual(-1, self.controlDate.months(from: testDate2, calendar: Calendar.autoupdatingCurrent))
        
        //Year number later, still less than a year
        let testDate3 = self.formatter.date(from: "2017 08 16 13:30:25.000")!
        XCTAssertEqual(-11, self.controlDate.months(from: testDate3, calendar: Calendar.autoupdatingCurrent))
        
        //Year number earlier, still less than a year
        let testDate5 = self.formatter.date(from: "2015 10 16 13:30:25.000")!
        XCTAssertEqual(11, self.controlDate.months(from: testDate5, calendar: Calendar.autoupdatingCurrent))
        
        //Over a year earlier
        let testDate6 = self.formatter.date(from: "2014 09 16 13:30:25.000")!
        XCTAssertEqual(24, self.controlDate.months(from: testDate6, calendar: Calendar.autoupdatingCurrent))
        
        //Over a year later
        let testDate7 = self.formatter.date(from: "2019 10 12 18:15:12.000")!
        XCTAssertEqual(-36, self.controlDate.months(from: testDate7, calendar: Calendar.autoupdatingCurrent))
    }
    
    func testWeeksFromWithCalendar() {
        //Same week
        let testSameDate = self.formatter.date(from: "2016 09 12 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.weeks(from: testSameDate, calendar: Calendar.autoupdatingCurrent))
        
        //Same year
        let testDate = self.formatter.date(from: "2016 09 26 18:15:12.000")!
        XCTAssertEqual(-1, self.controlDate.weeks(from: testDate, calendar: Calendar.autoupdatingCurrent))
        
        //Earlier year
        let testDate2 = self.formatter.date(from: "2015 9 23 13:30:25.000")!
        XCTAssertEqual(51, self.controlDate.weeks(from: testDate2, calendar: Calendar.autoupdatingCurrent))
        
        //Later year
        let testDate3 = self.formatter.date(from: "2017 9 23 13:30:25.000")!
        XCTAssertEqual(-53, self.controlDate.weeks(from: testDate3, calendar: Calendar.autoupdatingCurrent))
    }
    
    func testDaysFromWithCalendar() {
        //Same day
        let testSameDate = self.formatter.date(from: "2016 09 16 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.days(from: testSameDate, calendar: Calendar.autoupdatingCurrent))
        
        //Same year
        let testDate = self.formatter.date(from: "2016 09 17 18:15:12.000")!
        XCTAssertEqual(-1, self.controlDate.days(from: testDate, calendar: Calendar.autoupdatingCurrent))
        
        //Earlier year
        let testDate2 = self.formatter.date(from: "2015 9 23 13:30:25.000")!
        XCTAssertEqual(359, self.controlDate.days(from: testDate2, calendar: Calendar.autoupdatingCurrent)) //Would be 358, but leap year!
        
        //Later year
        let testDate3 = self.formatter.date(from: "2017 9 23 13:30:25.000")!
        XCTAssertEqual(-372, self.controlDate.days(from: testDate3, calendar: Calendar.autoupdatingCurrent))
    }
    
    
    // MARK: Earlier Than
    func testYearsEarlier() {
        //Under a year
        let testDate = self.formatter.date(from: "2016 11 12 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.yearsEarlier(than: testDate))
        
        //Exactly a year
        let testDate2 = self.formatter.date(from: "2017 09 16 13:30:25.000")!
        XCTAssertEqual(1, self.controlDate.yearsEarlier(than: testDate2))
        
        //Year number later, still less than a year
        let testDate3 = self.formatter.date(from: "2017 01 16 13:30:25.000")!
        XCTAssertEqual(0, self.controlDate.yearsEarlier(than: testDate3))
        
        //Year number earlier, still less than a year
        let testDate5 = self.formatter.date(from: "2015 11 16 13:30:25.000")!
        XCTAssertEqual(0, self.controlDate.yearsEarlier(than: testDate5))
        
        //Over a year earlier
        let testDate6 = self.formatter.date(from: "2018 09 16 13:30:25.000")!
        XCTAssertEqual(2, self.controlDate.yearsEarlier(than: testDate6))
        
        //Over a year earlier
        let testDate7 = self.formatter.date(from: "2013 09 16 13:15:12.000")!
        XCTAssertEqual(0, self.controlDate.yearsEarlier(than: testDate7))
        
        //Over a year later, but less than a year in final comparison year
        let testDate8 = self.formatter.date(from: "2019 09 01 13:30:25.000")!
        XCTAssertEqual(2,self.controlDate.yearsEarlier(than: testDate8))
        
        ///Over a year earlier, but less than a year in final comparison year
        let testDate9 = self.formatter.date(from: "2014 09 17 13:30:25.000")!
        XCTAssertEqual(0, self.controlDate.yearsEarlier(than: testDate9))
    }
    
    func testMonthsEarlier() {
        //Under a month
        let testDate = self.formatter.date(from: "2016 09 18 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.monthsEarlier(than: testDate))
        
        //Exactly a month
        let testDate2 = self.formatter.date(from: "2016 10 16 13:30:25.000")!
        XCTAssertEqual(1, self.controlDate.monthsEarlier(than: testDate2))
        
        //Year number later, still less than a year
        let testDate3 = self.formatter.date(from: "2017 08 16 13:30:25.000")!
        XCTAssertEqual(11, self.controlDate.monthsEarlier(than: testDate3))
        
        //Year number earlier, still less than a year
        let testDate5 = self.formatter.date(from: "2015 10 16 13:30:25.000")!
        XCTAssertEqual(0, self.controlDate.monthsEarlier(than: testDate5))
        
        //Over a year earlier
        let testDate6 = self.formatter.date(from: "2014 09 16 13:30:25.000")!
        XCTAssertEqual(0, self.controlDate.monthsEarlier(than: testDate6))
        
        //Over a year later
        let testDate7 = self.formatter.date(from: "2019 10 12 18:15:12.000")!
        XCTAssertEqual(36, self.controlDate.monthsEarlier(than: testDate7))
    }
    
    func testWeeksEarlier() {
        //Same week
        let testSameDate = self.formatter.date(from: "2016 09 12 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.weeksEarlier(than: testSameDate))
        
        //Same year
        let testDate = self.formatter.date(from: "2016 09 26 18:15:12.000")!
        XCTAssertEqual(1, self.controlDate.weeksEarlier(than: testDate))
        
        //Earlier year
        let testDate2 = self.formatter.date(from: "2015 9 23 13:30:25.000")!
        XCTAssertEqual(0, self.controlDate.weeksEarlier(than: testDate2))
        
        //Later year
        let testDate3 = self.formatter.date(from: "2017 9 23 13:30:25.000")!
        XCTAssertEqual(53, self.controlDate.weeksEarlier(than: testDate3))
    }
    
    func testDaysEarlier() {
        //Same day
        let testSameDate = self.formatter.date(from: "2016 09 16 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.daysEarlier(than: testSameDate))
        
        //Same year
        let testDate = self.formatter.date(from: "2016 09 17 18:15:12.000")!
        XCTAssertEqual(1, self.controlDate.daysEarlier(than: testDate))
        
        //Earlier year
        let testDate2 = self.formatter.date(from: "2015 9 23 13:30:25.000")!
        XCTAssertEqual(0, self.controlDate.daysEarlier(than: testDate2))
        
        //Later year
        let testDate3 = self.formatter.date(from: "2017 9 23 13:30:25.000")!
        XCTAssertEqual(372, self.controlDate.daysEarlier(than: testDate3))
    }
    
    func testHoursEarlier() {
        //Same year
        let testDate = self.formatter.date(from: "2016 09 16 18:15:12.000")!
        XCTAssertEqual(4, self.controlDate.hoursEarlier(than: testDate))
        
        //Earlier year
        let testDate2 = self.formatter.date(from: "2016 9 16 10:30:25.000")!
        XCTAssertEqual(0, self.controlDate.hoursEarlier(than: testDate2))
    }
    
    func testMinutesEarlier() {
        //Later
        let testDate = self.formatter.date(from: "2016 09 16 15:30:25.000")!
        XCTAssertEqual(120, self.controlDate.minutesEarlier(than: testDate))
        
        //Earlier
        let testDate2 = self.formatter.date(from: "2016 9 16 10:30:25.000")!
        XCTAssertEqual(0, self.controlDate.minutesEarlier(than: testDate2))
    }
    
    func testSecondsEarlier() {
        //Same
        let testSameDate = self.formatter.date(from: "2016 09 16 13:30:25.000")!
        XCTAssertEqual(0, self.controlDate.secondsEarlier(than: testSameDate))
        
        //Later
        let testDate = self.formatter.date(from: "2016 09 16 15:30:25.000")!
        XCTAssertEqual(7200, self.controlDate.secondsEarlier(than: testDate))
        
        //Earlier
        let testDate2 = self.formatter.date(from: "2016 9 16 10:30:25.000")!
        XCTAssertEqual(0, self.controlDate.secondsEarlier(than: testDate2))
    }
    
    // MARK: Later Than
    func testYearsLater() {
        //Under a year
        let testDate = self.formatter.date(from: "2016 11 12 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.yearsLater(than: testDate))
        
        //Exactly a year
        let testDate2 = self.formatter.date(from: "2015 09 16 13:30:25.000")!
        XCTAssertEqual(1, self.controlDate.yearsLater(than: testDate2))
        
        //Year number later, still less than a year
        let testDate3 = self.formatter.date(from: "2017 01 16 13:30:25.000")!
        XCTAssertEqual(0, self.controlDate.yearsLater(than: testDate3))
        
        //Year number earlier, still less than a year
        let testDate5 = self.formatter.date(from: "2015 11 16 13:30:25.000")!
        XCTAssertEqual(0, self.controlDate.yearsLater(than: testDate5))
        
        //Over a year earlier
        let testDate6 = self.formatter.date(from: "2014 09 16 13:30:25.000")!
        XCTAssertEqual(2, self.controlDate.yearsLater(than: testDate6))
        
        //Over a year later
        let testDate7 = self.formatter.date(from: "2019 11 12 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.yearsLater(than: testDate7))
        
        //Over a year later, but less than a year in final comparison year
        let testDate8 = self.formatter.date(from: "2019 09 01 13:30:25.000")!
        XCTAssertEqual(0,self.controlDate.yearsLater(than: testDate8))
        
        ///Over a year earlier, but less than a year in final comparison year
        let testDate9 = self.formatter.date(from: "2014 09 17 13:30:25.000")!
        XCTAssertEqual(1, self.controlDate.yearsLater(than: testDate9))
    }
    
    func testMonthsLater() {
        //Under a month
        let testDate = self.formatter.date(from: "2016 09 12 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.monthsLater(than: testDate))
        
        //Exactly a month
        let testDate2 = self.formatter.date(from: "2016 8 16 13:30:25.000")!
        XCTAssertEqual(1, self.controlDate.monthsLater(than: testDate2))
        
        //Year number later, still less than a year
        let testDate3 = self.formatter.date(from: "2015 11 16 13:30:25.000")!
        XCTAssertEqual(10, self.controlDate.monthsLater(than: testDate3))
        
        //Year number earlier, still less than a year
        let testDate5 = self.formatter.date(from: "2017 10 16 13:30:25.000")!
        XCTAssertEqual(0, self.controlDate.monthsLater(than: testDate5))
        
        //Over a year earlier
        let testDate6 = self.formatter.date(from: "2018 09 16 13:30:25.000")!
        XCTAssertEqual(0, self.controlDate.monthsLater(than: testDate6))
        
        //Over a year later
        let testDate7 = self.formatter.date(from: "2013 09 16 10:15:12.000")!
        XCTAssertEqual(36, self.controlDate.monthsLater(than: testDate7))
    }
    
    func testWeeksLater() {
        //Same week
        let testSameDate = self.formatter.date(from: "2016 09 12 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.weeksLater(than: testSameDate))
        
        //Same year
        let testDate = self.formatter.date(from: "2016 09 09 13:30:25.000")!
        XCTAssertEqual(1, self.controlDate.weeksLater(than: testDate))
        
        //Earlier year
        let testDate2 = self.formatter.date(from: "2015 9 23 13:30:25.000")!
        XCTAssertEqual(51, self.controlDate.weeksLater(than: testDate2))
        
        //Later year
        let testDate3 = self.formatter.date(from: "2017 9 23 13:30:25.000")!
        XCTAssertEqual(0, self.controlDate.weeksLater(than: testDate3))
    }
    
    func testDaysLater() {
        //Same day
        let testSameDate = self.formatter.date(from: "2016 09 16 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.daysLater(than: testSameDate))
        
        //Same year
        let testDate = self.formatter.date(from: "2016 09 14 18:15:12.000")!
        XCTAssertEqual(1, self.controlDate.daysLater(than: testDate))
        
        //Earlier year
        let testDate2 = self.formatter.date(from: "2015 9 23 13:30:25.000")!
        XCTAssertEqual(359, self.controlDate.daysLater(than: testDate2)) //Would be 358, but leap year!
        
        //Later year
        let testDate3 = self.formatter.date(from: "2017 9 23 13:30:25.000")!
        XCTAssertEqual(0, self.controlDate.daysLater(than: testDate3))
    }
    
    func testHoursLater() {
        //Same date
        let testSameDate = self.formatter.date(from: "2016 09 16 13:30:25.000")!
        XCTAssertEqual(0, self.controlDate.hoursLater(than: testSameDate))
        
        //Same year
        let testDate = self.formatter.date(from: "2016 09 16 10:25:12.000")!
        XCTAssertEqual(3, self.controlDate.hoursLater(than: testDate))
        
        //Earlier year
        let testDate2 = self.formatter.date(from: "2016 9 16 18:30:25.000")!
        XCTAssertEqual(0, self.controlDate.hoursLater(than: testDate2))
    }
    
    func testMinutesLater() {
        //Same date
        let testSameDate = self.formatter.date(from: "2016 09 16 13:30:25.000")!
        XCTAssertEqual(0, self.controlDate.hoursLater(than: testSameDate))
        
        //Later
        let testDate = self.formatter.date(from: "2016 09 16 15:30:25.000")!
        XCTAssertEqual(0, self.controlDate.minutesLater(than: testDate))
        
        //Earlier
        let testDate2 = self.formatter.date(from: "2016 9 16 10:30:25.000")!
        XCTAssertEqual(180, self.controlDate.minutesLater(than: testDate2))
    }
    
    func testSecondsLater() {
        //Same date
        let testSameDate = self.formatter.date(from: "2016 09 16 13:30:25.000")!
        XCTAssertEqual(0, self.controlDate.secondsLater(than: testSameDate))
        
        //Later
        let testDate = self.formatter.date(from: "2016 09 16 15:30:25.000")!
        XCTAssertEqual(0, self.controlDate.secondsLater(than: testDate))
        
        //Earlier
        let testDate2 = self.formatter.date(from: "2016 9 16 10:30:25.000")!
        XCTAssertEqual(10800, self.controlDate.secondsLater(than: testDate2))
    }
}
