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
        XCTFail()
    }
    
    func testIsLater() {
        XCTFail()
    }
    
    func testIsLaterOrEqual() {
        XCTFail()
    }
    
    func testEarlier() {
        XCTFail()
    }
    
    func testEarlierOrEqual() {
        XCTFail()
    }
    
    // MARK: - Date Comparison
    func testYearsFrom() {
        XCTFail()
    }
    
    func testMonthsFrom() {
        XCTFail()
    }
    
    func testWeeksFrom() {
        XCTFail()
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
