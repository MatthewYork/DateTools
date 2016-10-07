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
        XCTFail()
    }
    
    func testHoursFrom() {
        XCTFail()
    }
    
    func testMinutesFrom() {
        XCTFail()
    }
    
    func testSecondsFrom() {
        XCTFail()
    }
    
    // MARK: Time From With Calendar
    
    func testYearsFromWithCalendar() {
        XCTFail()
    }
    
    func testMonthsFromWithCalendar() {
        XCTFail()
    }
    
    func testWeeksFromWithCalendar() {
        XCTFail()
    }
    
    func testDaysFromWithCalendar() {
        XCTFail()
    }
    
    // MARK: Time Until
    
    func testYearsUntil() {
        XCTFail()
    }
    
    func testMonthsUntil() {
        XCTFail()
    }
    
    func testWeeksUntil() {
        XCTFail()
    }
    
    func testDaysUntil() {
        XCTFail()
    }
    
    func testHoursUntil() {
        XCTFail()
    }
    
    func testMinutesUntil() {
        XCTFail()
    }
    
    func testSecondsUntil() {
        XCTFail()
    }
    
    // MARK: Time Ago
    
    func testYearsAgo() {
        XCTFail()
    }
    
    func testMonthsAgo() {
        XCTFail()
    }
    
    func testWeeksAgo() {
        XCTFail()
    }
    
    func testDaysAgo() {
        XCTFail()
    }
    
    func testHoursAgo() {
        XCTFail()
    }
    
    func testMinutesAgo() {
        XCTFail()
    }
    
    func testSecondsAgo() {
        XCTFail()
    }
    
    // MARK: Earlier Than
    func testYearsEarlierThan() {
        XCTFail()
    }
    
    func testMonthsEarlierThan() {
        XCTFail()
    }
    
    func testWeeksEarlierThan() {
        XCTFail()
    }
    
    func testDaysEarlierThan() {
        XCTFail()
    }
    
    func testHoursEarlierThan() {
        XCTFail()
    }
    
    func testMinutesEarlierThan() {
        XCTFail()
    }
    
    func testSecondsEarlierThan() {
        XCTFail()
    }
    
    // MARK: Later Than
    func testYearsLaterThan() {
        XCTFail()
    }
    
    func testMonthsLaterThan() {
        XCTFail()
    }
    
    func testWeeksLaterThan() {
        XCTFail()
    }
    
    func testDaysLaterThan() {
        XCTFail()
    }
    
    func testHoursLaterThan() {
        XCTFail()
    }
    
    func testMinutesLaterThan() {
        XCTFail()
    }
    
    func testSecondsLaterThan() {
        XCTFail()
    }
}
