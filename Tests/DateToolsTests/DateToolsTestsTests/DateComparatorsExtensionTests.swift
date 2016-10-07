//
//  DateComparators.swift
//  DateToolsTests
//
//  Created by Matthew York on 8/29/16.
//  Copyright © 2016 Matthew York. All rights reserved.
//

import XCTest
@testable import DateToolsTests

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
    func testYearsFrom() {
        //Under a year
        let testDate = self.formatter.date(from: "2016 11 12 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.yearsFrom(testDate))
        
        //Exactly a year
        let testDate2 = self.formatter.date(from: "2017 09 16 13:30:25.000")!
        XCTAssertEqual(-1, self.controlDate.yearsFrom(testDate2))
        
        //Year number later, still less than a year
        let testDate3 = self.formatter.date(from: "2017 01 16 13:30:25.000")!
        XCTAssertEqual(0, self.controlDate.yearsFrom(testDate3))
        
        //Year number earlier, still less than a year
        let testDate5 = self.formatter.date(from: "2015 11 16 13:30:25.000")!
        XCTAssertEqual(0, self.controlDate.yearsFrom(testDate5))
        
        //Over a year earlier
        let testDate6 = self.formatter.date(from: "2014 09 16 13:30:25.000")!
        XCTAssertEqual(2, self.controlDate.yearsFrom(testDate6))
        
        //Over a year later
        let testDate7 = self.formatter.date(from: "2019 11 12 18:15:12.000")!
        XCTAssertEqual(-3, self.controlDate.yearsFrom(testDate7))
        
        //Over a year later, but less than a year in final comparison year
        let testDate8 = self.formatter.date(from: "2019 09 01 13:30:25.000")!
        XCTAssertEqual(-2,self.controlDate.yearsFrom(testDate8))
        
        ///Over a year earlier, but less than a year in final comparison year
        let testDate9 = self.formatter.date(from: "2014 09 17 13:30:25.000")!
        XCTAssertEqual(1, self.controlDate.yearsFrom(testDate9))
    }
    
    func testMonthsFrom() {
        //Under a month
        let testDate = self.formatter.date(from: "2016 09 12 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.monthsFrom(testDate))
        
        //Exactly a month
        let testDate2 = self.formatter.date(from: "2016 10 16 13:30:25.000")!
        XCTAssertEqual(-1, self.controlDate.monthsFrom(testDate2))
        
        //Year number later, still less than a year
        let testDate3 = self.formatter.date(from: "2017 08 16 13:30:25.000")!
        XCTAssertEqual(-11, self.controlDate.monthsFrom(testDate3))
        
        //Year number earlier, still less than a year
        let testDate5 = self.formatter.date(from: "2015 10 16 13:30:25.000")!
        XCTAssertEqual(11, self.controlDate.monthsFrom(testDate5))
        
        //Over a year earlier
        let testDate6 = self.formatter.date(from: "2014 09 16 13:30:25.000")!
        XCTAssertEqual(24, self.controlDate.monthsFrom(testDate6))
        
        //Over a year later
        let testDate7 = self.formatter.date(from: "2019 10 12 18:15:12.000")!
        XCTAssertEqual(-36, self.controlDate.monthsFrom(testDate7))
    }
    
    func testWeeksFrom() {
        //Same week
        let testSameDate = self.formatter.date(from: "2016 09 12 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.weeksFrom(testSameDate))
        
        //Same year
        let testDate = self.formatter.date(from: "2016 09 26 18:15:12.000")!
        XCTAssertEqual(-1, self.controlDate.weeksFrom(testDate))
        
        //Earlier year
        let testDate2 = self.formatter.date(from: "2015 9 23 13:30:25.000")!
        XCTAssertEqual(51, self.controlDate.weeksFrom(testDate2))
        
        //Later year
        let testDate3 = self.formatter.date(from: "2017 9 23 13:30:25.000")!
        XCTAssertEqual(-53, self.controlDate.weeksFrom(testDate3))
    }
    
    func testDaysFrom() {
        //Same day
        let testSameDate = self.formatter.date(from: "2016 09 16 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.daysFrom(testSameDate))
        
        //Same year
        let testDate = self.formatter.date(from: "2016 09 17 18:15:12.000")!
        XCTAssertEqual(-1, self.controlDate.daysFrom(testDate))
        
        //Earlier year
        let testDate2 = self.formatter.date(from: "2015 9 23 13:30:25.000")!
        XCTAssertEqual(359, self.controlDate.daysFrom(testDate2)) //Would be 358, but leap year!
        
        //Later year
        let testDate3 = self.formatter.date(from: "2017 9 23 13:30:25.000")!
        XCTAssertEqual(-372, self.controlDate.daysFrom(testDate3))
    }
    
    func testHoursFrom() {
        //Same year
        let testDate = self.formatter.date(from: "2016 09 16 18:15:12.000")!
        XCTAssertEqual(-4, self.controlDate.hoursFrom(testDate))
        
        //Earlier year
        let testDate2 = self.formatter.date(from: "2016 9 16 10:30:25.000")!
        XCTAssertEqual(3, self.controlDate.hoursFrom(testDate2))
    }
    
    func testMinutesFrom() {
        //Later
        let testDate = self.formatter.date(from: "2016 09 16 15:30:25.000")!
        XCTAssertEqual(-120, self.controlDate.minutesFrom(testDate))
        
        //Earlier
        let testDate2 = self.formatter.date(from: "2016 9 16 10:30:25.000")!
        XCTAssertEqual(180, self.controlDate.minutesFrom(testDate2))
    }
    
    func testSecondsFrom() {
        //Same
        let testSameDate = self.formatter.date(from: "2016 09 16 13:30:25.000")!
        XCTAssertEqual(0, self.controlDate.secondsFrom(testSameDate))
        
        //Later
        let testDate = self.formatter.date(from: "2016 09 16 15:30:25.000")!
        XCTAssertEqual(-7200, self.controlDate.secondsFrom(testDate))
        
        //Earlier
        let testDate2 = self.formatter.date(from: "2016 9 16 10:30:25.000")!
        XCTAssertEqual(10800, self.controlDate.secondsFrom(testDate2))
    }
    
    // MARK: Time From With Calendar
    
    func testYearsFromWithCalendar() {
        //Under a year
        let testDate = self.formatter.date(from: "2016 11 12 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.yearsFrom(testDate, calendar: Calendar.autoupdatingCurrent))
        
        //Exactly a year
        let testDate2 = self.formatter.date(from: "2017 09 16 13:30:25.000")!
        XCTAssertEqual(-1, self.controlDate.yearsFrom(testDate2, calendar: Calendar.autoupdatingCurrent))
        
        //Year number later, still less than a year
        let testDate3 = self.formatter.date(from: "2017 01 16 13:30:25.000")!
        XCTAssertEqual(0, self.controlDate.yearsFrom(testDate3, calendar: Calendar.autoupdatingCurrent))
        
        //Year number earlier, still less than a year
        let testDate5 = self.formatter.date(from: "2015 11 16 13:30:25.000")!
        XCTAssertEqual(0, self.controlDate.yearsFrom(testDate5, calendar: Calendar.autoupdatingCurrent))
        
        //Over a year earlier
        let testDate6 = self.formatter.date(from: "2014 09 16 13:30:25.000")!
        XCTAssertEqual(2, self.controlDate.yearsFrom(testDate6, calendar: Calendar.autoupdatingCurrent))
        
        //Over a year later
        let testDate7 = self.formatter.date(from: "2019 11 12 18:15:12.000")!
        XCTAssertEqual(-3, self.controlDate.yearsFrom(testDate7, calendar: Calendar.autoupdatingCurrent))
        
        //Over a year later, but less than a year in final comparison year
        let testDate8 = self.formatter.date(from: "2019 09 01 13:30:25.000")!
        XCTAssertEqual(-2,self.controlDate.yearsFrom(testDate8, calendar: Calendar.autoupdatingCurrent))
        
        ///Over a year earlier, but less than a year in final comparison year
        let testDate9 = self.formatter.date(from: "2014 09 17 13:30:25.000")!
        XCTAssertEqual(1, self.controlDate.yearsFrom(testDate9, calendar: Calendar.autoupdatingCurrent))
    }
    
    func testMonthsFromWithCalendar() {
        //Under a month
        let testDate = self.formatter.date(from: "2016 09 12 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.monthsFrom(testDate, calendar: Calendar.autoupdatingCurrent))
        
        //Exactly a month
        let testDate2 = self.formatter.date(from: "2016 10 16 13:30:25.000")!
        XCTAssertEqual(-1, self.controlDate.monthsFrom(testDate2, calendar: Calendar.autoupdatingCurrent))
        
        //Year number later, still less than a year
        let testDate3 = self.formatter.date(from: "2017 08 16 13:30:25.000")!
        XCTAssertEqual(-11, self.controlDate.monthsFrom(testDate3, calendar: Calendar.autoupdatingCurrent))
        
        //Year number earlier, still less than a year
        let testDate5 = self.formatter.date(from: "2015 10 16 13:30:25.000")!
        XCTAssertEqual(11, self.controlDate.monthsFrom(testDate5, calendar: Calendar.autoupdatingCurrent))
        
        //Over a year earlier
        let testDate6 = self.formatter.date(from: "2014 09 16 13:30:25.000")!
        XCTAssertEqual(24, self.controlDate.monthsFrom(testDate6, calendar: Calendar.autoupdatingCurrent))
        
        //Over a year later
        let testDate7 = self.formatter.date(from: "2019 10 12 18:15:12.000")!
        XCTAssertEqual(-36, self.controlDate.monthsFrom(testDate7, calendar: Calendar.autoupdatingCurrent))
    }
    
    func testWeeksFromWithCalendar() {
        //Same week
        let testSameDate = self.formatter.date(from: "2016 09 12 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.weeksFrom(testSameDate, calendar: Calendar.autoupdatingCurrent))
        
        //Same year
        let testDate = self.formatter.date(from: "2016 09 26 18:15:12.000")!
        XCTAssertEqual(-1, self.controlDate.weeksFrom(testDate, calendar: Calendar.autoupdatingCurrent))
        
        //Earlier year
        let testDate2 = self.formatter.date(from: "2015 9 23 13:30:25.000")!
        XCTAssertEqual(51, self.controlDate.weeksFrom(testDate2, calendar: Calendar.autoupdatingCurrent))
        
        //Later year
        let testDate3 = self.formatter.date(from: "2017 9 23 13:30:25.000")!
        XCTAssertEqual(-53, self.controlDate.weeksFrom(testDate3, calendar: Calendar.autoupdatingCurrent))
    }
    
    func testDaysFromWithCalendar() {
        //Same day
        let testSameDate = self.formatter.date(from: "2016 09 16 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.daysFrom(testSameDate, calendar: Calendar.autoupdatingCurrent))
        
        //Same year
        let testDate = self.formatter.date(from: "2016 09 17 18:15:12.000")!
        XCTAssertEqual(-1, self.controlDate.daysFrom(testDate, calendar: Calendar.autoupdatingCurrent))
        
        //Earlier year
        let testDate2 = self.formatter.date(from: "2015 9 23 13:30:25.000")!
        XCTAssertEqual(359, self.controlDate.daysFrom(testDate2, calendar: Calendar.autoupdatingCurrent)) //Would be 358, but leap year!
        
        //Later year
        let testDate3 = self.formatter.date(from: "2017 9 23 13:30:25.000")!
        XCTAssertEqual(-372, self.controlDate.daysFrom(testDate3, calendar: Calendar.autoupdatingCurrent))
    }
    
    
    // MARK: Earlier Than
    func testYearsEarlierThan() {
        //Under a year
        let testDate = self.formatter.date(from: "2016 11 12 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.yearsEarlierThan(testDate))
        
        //Exactly a year
        let testDate2 = self.formatter.date(from: "2017 09 16 13:30:25.000")!
        XCTAssertEqual(1, self.controlDate.yearsEarlierThan(testDate2))
        
        //Year number later, still less than a year
        let testDate3 = self.formatter.date(from: "2017 01 16 13:30:25.000")!
        XCTAssertEqual(0, self.controlDate.yearsEarlierThan(testDate3))
        
        //Year number earlier, still less than a year
        let testDate5 = self.formatter.date(from: "2015 11 16 13:30:25.000")!
        XCTAssertEqual(0, self.controlDate.yearsEarlierThan(testDate5))
        
        //Over a year earlier
        let testDate6 = self.formatter.date(from: "2018 09 16 13:30:25.000")!
        XCTAssertEqual(2, self.controlDate.yearsEarlierThan(testDate6))
        
        //Over a year earlier
        let testDate7 = self.formatter.date(from: "2013 09 16 13:15:12.000")!
        XCTAssertEqual(0, self.controlDate.yearsEarlierThan(testDate7))
        
        //Over a year later, but less than a year in final comparison year
        let testDate8 = self.formatter.date(from: "2019 09 01 13:30:25.000")!
        XCTAssertEqual(2,self.controlDate.yearsEarlierThan(testDate8))
        
        ///Over a year earlier, but less than a year in final comparison year
        let testDate9 = self.formatter.date(from: "2014 09 17 13:30:25.000")!
        XCTAssertEqual(0, self.controlDate.yearsEarlierThan(testDate9))
    }
    
    func testMonthsEarlierThan() {
        //Under a month
        let testDate = self.formatter.date(from: "2016 09 18 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.monthsEarlierThan(testDate))
        
        //Exactly a month
        let testDate2 = self.formatter.date(from: "2016 10 16 13:30:25.000")!
        XCTAssertEqual(1, self.controlDate.monthsEarlierThan(testDate2))
        
        //Year number later, still less than a year
        let testDate3 = self.formatter.date(from: "2017 08 16 13:30:25.000")!
        XCTAssertEqual(11, self.controlDate.monthsEarlierThan(testDate3))
        
        //Year number earlier, still less than a year
        let testDate5 = self.formatter.date(from: "2015 10 16 13:30:25.000")!
        XCTAssertEqual(0, self.controlDate.monthsEarlierThan(testDate5))
        
        //Over a year earlier
        let testDate6 = self.formatter.date(from: "2014 09 16 13:30:25.000")!
        XCTAssertEqual(0, self.controlDate.monthsEarlierThan(testDate6))
        
        //Over a year later
        let testDate7 = self.formatter.date(from: "2019 10 12 18:15:12.000")!
        XCTAssertEqual(36, self.controlDate.monthsEarlierThan(testDate7))
    }
    
    func testWeeksEarlierThan() {
        //Same week
        let testSameDate = self.formatter.date(from: "2016 09 12 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.weeksEarlierThan(testSameDate))
        
        //Same year
        let testDate = self.formatter.date(from: "2016 09 26 18:15:12.000")!
        XCTAssertEqual(1, self.controlDate.weeksEarlierThan(testDate))
        
        //Earlier year
        let testDate2 = self.formatter.date(from: "2015 9 23 13:30:25.000")!
        XCTAssertEqual(0, self.controlDate.weeksEarlierThan(testDate2))
        
        //Later year
        let testDate3 = self.formatter.date(from: "2017 9 23 13:30:25.000")!
        XCTAssertEqual(53, self.controlDate.weeksEarlierThan(testDate3))
    }
    
    func testDaysEarlierThan() {
        //Same day
        let testSameDate = self.formatter.date(from: "2016 09 16 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.daysEarlierThan(testSameDate))
        
        //Same year
        let testDate = self.formatter.date(from: "2016 09 17 18:15:12.000")!
        XCTAssertEqual(1, self.controlDate.daysEarlierThan(testDate))
        
        //Earlier year
        let testDate2 = self.formatter.date(from: "2015 9 23 13:30:25.000")!
        XCTAssertEqual(0, self.controlDate.daysEarlierThan(testDate2))
        
        //Later year
        let testDate3 = self.formatter.date(from: "2017 9 23 13:30:25.000")!
        XCTAssertEqual(372, self.controlDate.daysEarlierThan(testDate3))
    }
    
    func testHoursEarlierThan() {
        //Same year
        let testDate = self.formatter.date(from: "2016 09 16 18:15:12.000")!
        XCTAssertEqual(4, self.controlDate.hoursEarlierThan(testDate))
        
        //Earlier year
        let testDate2 = self.formatter.date(from: "2016 9 16 10:30:25.000")!
        XCTAssertEqual(0, self.controlDate.hoursEarlierThan(testDate2))
    }
    
    func testMinutesEarlierThan() {
        //Later
        let testDate = self.formatter.date(from: "2016 09 16 15:30:25.000")!
        XCTAssertEqual(120, self.controlDate.minutesEarlierThan(testDate))
        
        //Earlier
        let testDate2 = self.formatter.date(from: "2016 9 16 10:30:25.000")!
        XCTAssertEqual(0, self.controlDate.minutesEarlierThan(testDate2))
    }
    
    func testSecondsEarlierThan() {
        //Same
        let testSameDate = self.formatter.date(from: "2016 09 16 13:30:25.000")!
        XCTAssertEqual(0, self.controlDate.secondsEarlierThan(testSameDate))
        
        //Later
        let testDate = self.formatter.date(from: "2016 09 16 15:30:25.000")!
        XCTAssertEqual(7200, self.controlDate.secondsEarlierThan(testDate))
        
        //Earlier
        let testDate2 = self.formatter.date(from: "2016 9 16 10:30:25.000")!
        XCTAssertEqual(0, self.controlDate.secondsEarlierThan(testDate2))
    }
    
    // MARK: Later Than
    func testYearsLaterThan() {
        //Under a year
        let testDate = self.formatter.date(from: "2016 11 12 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.yearsLaterThan(testDate))
        
        //Exactly a year
        let testDate2 = self.formatter.date(from: "2015 09 16 13:30:25.000")!
        XCTAssertEqual(1, self.controlDate.yearsLaterThan(testDate2))
        
        //Year number later, still less than a year
        let testDate3 = self.formatter.date(from: "2017 01 16 13:30:25.000")!
        XCTAssertEqual(0, self.controlDate.yearsLaterThan(testDate3))
        
        //Year number earlier, still less than a year
        let testDate5 = self.formatter.date(from: "2015 11 16 13:30:25.000")!
        XCTAssertEqual(0, self.controlDate.yearsLaterThan(testDate5))
        
        //Over a year earlier
        let testDate6 = self.formatter.date(from: "2014 09 16 13:30:25.000")!
        XCTAssertEqual(2, self.controlDate.yearsLaterThan(testDate6))
        
        //Over a year later
        let testDate7 = self.formatter.date(from: "2019 11 12 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.yearsLaterThan(testDate7))
        
        //Over a year later, but less than a year in final comparison year
        let testDate8 = self.formatter.date(from: "2019 09 01 13:30:25.000")!
        XCTAssertEqual(0,self.controlDate.yearsLaterThan(testDate8))
        
        ///Over a year earlier, but less than a year in final comparison year
        let testDate9 = self.formatter.date(from: "2014 09 17 13:30:25.000")!
        XCTAssertEqual(1, self.controlDate.yearsLaterThan(testDate9))
    }
    
    func testMonthsLaterThan() {
        //Under a month
        let testDate = self.formatter.date(from: "2016 09 12 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.monthsLaterThan(testDate))
        
        //Exactly a month
        let testDate2 = self.formatter.date(from: "2016 8 16 13:30:25.000")!
        XCTAssertEqual(1, self.controlDate.monthsLaterThan(testDate2))
        
        //Year number later, still less than a year
        let testDate3 = self.formatter.date(from: "2015 11 16 13:30:25.000")!
        XCTAssertEqual(10, self.controlDate.monthsLaterThan(testDate3))
        
        //Year number earlier, still less than a year
        let testDate5 = self.formatter.date(from: "2017 10 16 13:30:25.000")!
        XCTAssertEqual(0, self.controlDate.monthsLaterThan(testDate5))
        
        //Over a year earlier
        let testDate6 = self.formatter.date(from: "2018 09 16 13:30:25.000")!
        XCTAssertEqual(0, self.controlDate.monthsLaterThan(testDate6))
        
        //Over a year later
        let testDate7 = self.formatter.date(from: "2013 09 16 10:15:12.000")!
        XCTAssertEqual(36, self.controlDate.monthsLaterThan(testDate7))
    }
    
    func testWeeksLaterThan() {
        //Same week
        let testSameDate = self.formatter.date(from: "2016 09 12 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.weeksLaterThan(testSameDate))
        
        //Same year
        let testDate = self.formatter.date(from: "2016 09 09 13:30:25.000")!
        XCTAssertEqual(1, self.controlDate.weeksLaterThan(testDate))
        
        //Earlier year
        let testDate2 = self.formatter.date(from: "2015 9 23 13:30:25.000")!
        XCTAssertEqual(51, self.controlDate.weeksLaterThan(testDate2))
        
        //Later year
        let testDate3 = self.formatter.date(from: "2017 9 23 13:30:25.000")!
        XCTAssertEqual(0, self.controlDate.weeksLaterThan(testDate3))
    }
    
    func testDaysLaterThan() {
        //Same day
        let testSameDate = self.formatter.date(from: "2016 09 16 18:15:12.000")!
        XCTAssertEqual(0, self.controlDate.daysLaterThan(testSameDate))
        
        //Same year
        let testDate = self.formatter.date(from: "2016 09 14 18:15:12.000")!
        XCTAssertEqual(1, self.controlDate.daysLaterThan(testDate))
        
        //Earlier year
        let testDate2 = self.formatter.date(from: "2015 9 23 13:30:25.000")!
        XCTAssertEqual(359, self.controlDate.daysLaterThan(testDate2)) //Would be 358, but leap year!
        
        //Later year
        let testDate3 = self.formatter.date(from: "2017 9 23 13:30:25.000")!
        XCTAssertEqual(0, self.controlDate.daysLaterThan(testDate3))
    }
    
    func testHoursLaterThan() {
        //Same date
        let testSameDate = self.formatter.date(from: "2016 09 16 13:30:25.000")!
        XCTAssertEqual(0, self.controlDate.hoursLaterThan(testSameDate))
        
        //Same year
        let testDate = self.formatter.date(from: "2016 09 16 10:25:12.000")!
        XCTAssertEqual(3, self.controlDate.hoursLaterThan(testDate))
        
        //Earlier year
        let testDate2 = self.formatter.date(from: "2016 9 16 18:30:25.000")!
        XCTAssertEqual(0, self.controlDate.hoursLaterThan(testDate2))
    }
    
    func testMinutesLaterThan() {
        //Same date
        let testSameDate = self.formatter.date(from: "2016 09 16 13:30:25.000")!
        XCTAssertEqual(0, self.controlDate.hoursLaterThan(testSameDate))
        
        //Later
        let testDate = self.formatter.date(from: "2016 09 16 15:30:25.000")!
        XCTAssertEqual(0, self.controlDate.minutesLaterThan(testDate))
        
        //Earlier
        let testDate2 = self.formatter.date(from: "2016 9 16 10:30:25.000")!
        XCTAssertEqual(180, self.controlDate.minutesLaterThan(testDate2))
    }
    
    func testSecondsLaterThan() {
        //Same date
        let testSameDate = self.formatter.date(from: "2016 09 16 13:30:25.000")!
        XCTAssertEqual(0, self.controlDate.secondsLaterThan(testSameDate))
        
        //Later
        let testDate = self.formatter.date(from: "2016 09 16 15:30:25.000")!
        XCTAssertEqual(0, self.controlDate.secondsLaterThan(testDate))
        
        //Earlier
        let testDate2 = self.formatter.date(from: "2016 9 16 10:30:25.000")!
        XCTAssertEqual(10800, self.controlDate.secondsLaterThan(testDate2))
    }
}
