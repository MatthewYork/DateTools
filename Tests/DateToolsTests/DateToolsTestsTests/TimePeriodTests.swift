//
//  TimePeriodTests.swift
//  DateToolsTests
//
//  Created by Grayson Webster on 8/19/16.
//  Copyright © 2016 Matthew York. All rights reserved.
//

import XCTest

class TimePeriodTests : XCTestCase {
    
    var formatter: DateFormatter?
    var controlTimePeriod: TimePeriod?
    
    override func setUp() {
        super.up = null
        // ut setup code here. This method is called before the invocation of each test method in the class.
        self.controlTimePeriod = TimePeriod()
        //Create TimePeriod that is 2 years long
        self.formatter = DateFormatter()
        self.formatter?.dateFormat = "yyyy MM dd HH:mm:ss.SSS"
        self.controlTimePeriod.startDate = self.formatter.dateFromString("2014 11 05 18:15:12.000")
        self.controlTimePeriod.endDate = self.formatter.dateFromString("2016 11 05 18:15:12.000")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: - Custom Init / Factory Methods
    func testBasicInitsAndFactoryMethods() {
        //Basic init
        var testPeriodInit: TimePeriod = TimePeriod(startDate: self.controlTimePeriod.startDate, endDate: self.controlTimePeriod.endDate)
        XCTAssertTrue(self.controlTimePeriod.startDate.isEqualToDate(testPeriodInit.startDate) && self.controlTimePeriod.endDate.isEqualToDate(testPeriodInit.endDate), "%s Failed", file: #function)
        //Basic factory
        var testPeriodFactoryInit: TimePeriod = TimePeriod(startDate: self.controlTimePeriod.startDate, endDate: self.controlTimePeriod.endDate)
        XCTAssertTrue(self.controlTimePeriod.startDate.isEqualToDate(testPeriodFactoryInit.startDate) && self.controlTimePeriod.endDate.isEqualToDate(testPeriodFactoryInit.endDate), "%s Failed", file: #function)
    }
    
    func testFactoryStartingAt() {
        //Test dates
        var startLaterSecond: Date = self.formatter!.date(from: "2014 11 05 18:15:13.000")!
        var startLaterMinute: Date = self.formatter!.date(from: "2014 11 05 18:16:12.000")!
        var startLaterHour: Date = self.formatter!.date(from: "2014 11 05 19:15:12.000")!
        var startLaterDay: Date = self.formatter!.date(from: "2014 11 06 18:15:12.000")!
        var startLaterWeek: Date = self.formatter!.date(from: "2014 11 12 18:15:12.000")!
        var startLaterMonth: Date = self.formatter!.date(from: "2014 12 05 18:15:12.000")!
        var startLaterYear: Date = self.formatter!.date(from: "2015 11 05 18:15:12.000")!
        //Starting At
        //Second time period
        var testPeriodSecond: TimePeriod = TimePeriod(size: TimePeriodSizeSecond, startingAt: self.controlTimePeriod.startDate)
        XCTAssertTrue(testPeriodSecond.startDate.isEqualToDate(self.controlTimePeriod.startDate) && testPeriodSecond.endDate.isEqualToDate(startLaterSecond), "%s Failed", file: #function)
        //Minute time period
        var testPeriodMinute: TimePeriod = TimePeriod(size: TimePeriodSizeMinute, startingAt: self.controlTimePeriod.startDate)
        XCTAssertTrue(testPeriodMinute.startDate.isEqualToDate(self.controlTimePeriod.startDate) && testPeriodMinute.endDate.isEqualToDate(startLaterMinute), "%s Failed", file: #function)
        //Hour time period
        var testPeriodHour: TimePeriod = TimePeriod(size: TimePeriodSizeHour, startingAt: self.controlTimePeriod.startDate)
        XCTAssertTrue(testPeriodHour.startDate.isEqualToDate(self.controlTimePeriod.startDate) && testPeriodHour.endDate.isEqualToDate(startLaterHour), "%s Failed", file: #function)
        //Day time period
        var testPeriodDay: TimePeriod = TimePeriod(size: TimePeriodSizeDay, startingAt: self.controlTimePeriod.startDate)
        XCTAssertTrue(testPeriodDay.startDate.isEqualToDate(self.controlTimePeriod.startDate) && testPeriodDay.endDate.isEqualToDate(startLaterDay), "%s Failed", file: #function)
        //Week time period
        var testPeriodWeek: TimePeriod = TimePeriod(size: TimePeriodSizeWeek, startingAt: self.controlTimePeriod.startDate)
        XCTAssertTrue(testPeriodWeek.startDate.isEqualToDate(self.controlTimePeriod.startDate) && testPeriodWeek.endDate.isEqualToDate(startLaterWeek), "%s Failed", file: #function)
        //Month time period
        var testPeriodMonth: TimePeriod = TimePeriod(size: TimePeriodSizeMonth, startingAt: self.controlTimePeriod.startDate)
        XCTAssertTrue(testPeriodMonth.startDate.isEqualToDate(self.controlTimePeriod.startDate) && testPeriodMonth.endDate.isEqualToDate(startLaterMonth), "%s Failed", file: #function)
        //Year time period
        var testPeriodYear: TimePeriod = TimePeriod(size: TimePeriodSizeYear, startingAt: self.controlTimePeriod.startDate)
        XCTAssertTrue(testPeriodYear.startDate.isEqualToDate(self.controlTimePeriod.startDate) && testPeriodYear.endDate.isEqualToDate(startLaterYear), "%s Failed", file: #function)
    }
    
    func testFactoryEndingAt() {
        //Test End dates
        var endEarlierSecond: Date = self.formatter!.date(from: "2016 11 05 18:15:11.000")!
        var endEarlierMinute: Date = self.formatter!.date(from: "2016 11 05 18:14:12.000")!
        var endEarlierHour: Date = self.formatter!.date(from: "2016 11 05 17:15:12.000")!
        var endEarlierDay: Date = self.formatter!.date(from: "2016 11 04 18:15:12.000")!
        var endEarlierWeek: Date = self.formatter!.date(from: "2016 10 29 18:15:12.000")!
        var endEarlierMonth: Date = self.formatter!.date(from: "2016 10 05 18:15:12.000")!
        var endEarlierYear: Date = self.formatter!.date(from: "2015 11 05 18:15:12.000")!
        //Ending At
        //Second time period
        var testPeriodSecond: TimePeriod = TimePeriod(size: TimePeriodSizeSecond, endingAt: self.controlTimePeriod.endDate)
        XCTAssertTrue(testPeriodSecond.startDate.isEqualToDate(endEarlierSecond) && testPeriodSecond.endDate.isEqualToDate(self.controlTimePeriod.endDate), "%s Failed", file: #function)
        //Minute time period
        var testPeriodMinute: TimePeriod = TimePeriod(size: TimePeriodSizeMinute, endingAt: self.controlTimePeriod.endDate)
        XCTAssertTrue(testPeriodMinute.startDate.isEqualToDate(endEarlierMinute) && testPeriodMinute.endDate.isEqualToDate(self.controlTimePeriod.endDate), "%s Failed", file: #function)
        //Hour time period
        var testPeriodHour: TimePeriod = TimePeriod(size: TimePeriodSizeHour, endingAt: self.controlTimePeriod.endDate)
        XCTAssertTrue(testPeriodHour.startDate.isEqualToDate(endEarlierHour) && testPeriodHour.endDate.isEqualToDate(self.controlTimePeriod.endDate), "%s Failed", file: #function)
        //Day time period
        var testPeriodDay: TimePeriod = TimePeriod(size: TimePeriodSizeDay, endingAt: self.controlTimePeriod.endDate)
        XCTAssertTrue(testPeriodDay.startDate.isEqualToDate(endEarlierDay) && testPeriodDay.endDate.isEqualToDate(self.controlTimePeriod.endDate), "%s Failed", file: #function)
        //Week time period
        var testPeriodWeek: TimePeriod = TimePeriod(size: TimePeriodSizeWeek, endingAt: self.controlTimePeriod.endDate)
        XCTAssertTrue(testPeriodWeek.startDate.isEqualToDate(endEarlierWeek) && testPeriodWeek.endDate.isEqualToDate(self.controlTimePeriod.endDate), "%s Failed", file: #function)
        //Month time period
        var testPeriodMonth: TimePeriod = TimePeriod(size: TimePeriodSizeMonth, endingAt: self.controlTimePeriod.endDate)
        XCTAssertTrue(testPeriodMonth.startDate.isEqualToDate(endEarlierMonth) && testPeriodMonth.endDate.isEqualToDate(self.controlTimePeriod.endDate), "%s Failed", file: #function)
        //Year time period
        var testPeriodYear: TimePeriod = TimePeriod(size: TimePeriodSizeYear, endingAt: self.controlTimePeriod.endDate)
        XCTAssertTrue(testPeriodYear.startDate.isEqualToDate(endEarlierYear) && testPeriodYear.endDate.isEqualToDate(self.controlTimePeriod.endDate), "%s Failed", file: #function)
    }
    
    // MARK: - Time Period Information
    func testHasstartDate() {
        //Has start date
        XCTAssertTrue(self.controlTimePeriod.hasstartDate(), "%s Failed", file: #function)
        //Deosn't have start date
        var testPeriod: TimePeriod = TimePeriod(startDate: nil, endDate: self.controlTimePeriod.endDate)
        XCTAssertFalse(testPeriod.hasstartDate(), "%s Failed", file: #function)
    }
    
    func testHasendDate() {
        //Has end date
        XCTAssertTrue(self.controlTimePeriod.hasendDate(), "%s Failed", file: #function)
        //Deosn't have end date
        var testPeriod: TimePeriod = TimePeriod(startDate: self.controlTimePeriod.startDate, endDate: nil)
        XCTAssertFalse(testPeriod.hasendDate(), "%s Failed", file: #function)
    }
    
    func testIsMoment() {
        //Is moment
        var testPeriod: TimePeriod = TimePeriod(startDate: self.controlTimePeriod.startDate, endDate: self.controlTimePeriod.startDate)
        XCTAssertTrue(testPeriod.isMoment, "%s Failed", file: #function)
        //Is not moment
        XCTAssertFalse(self.controlTimePeriod.isMoment, "%s Failed", file: #function)
    }
    
    func testDurationInYears() {
        XCTAssertEqual(2, self.controlTimePeriod.durationInYears(), "%s Failed", file: #function)
    }
    
    func testDurationInWeeks() {
        XCTAssertEqual(104, self.controlTimePeriod.durationInWeeks(), "%s Failed", file: #function)
    }
    
    func testDurationInDays() {
        XCTAssertEqual(731, self.controlTimePeriod.durationInDays(), "%s Failed", file: #function)
    }
    
    func testDurationInHours() {
        var testPeriod: TimePeriod = TimePeriod(startDate: self.controlTimePeriod.startDate, endDate: self.controlTimePeriod.startDate.dateByAddingHours(4))
        XCTAssertEqual(4, testPeriod.durationInHours(), "%s Failed", file: #function)
    }
    
    func testDurationInMinutes() {
        var testPeriod: TimePeriod = TimePeriod(startDate: self.controlTimePeriod.startDate, endDate: self.controlTimePeriod.startDate.dateByAddingHours(4))
        XCTAssertEqual(240, testPeriod.durationInMinutes(), "%s Failed", file: #function)
    }
    
    func testDurationInSeconds() {
        var testPeriod: TimePeriod = TimePeriod(startDate: self.controlTimePeriod.startDate, endDate: self.controlTimePeriod.startDate.dateByAddingHours(4))
        XCTAssertEqual(14400, testPeriod.durationInSeconds(), "%s Failed", file: #function)
    }
    
    // MARK: - Time Period Relationship
    func testIsSamePeriod() {
        //Same
        XCTAssertTrue(self.controlTimePeriod.isEqualToPeriod(self.controlTimePeriod), "%s Failed", file: #function)
        //Different ending
        var differentEndPeriod: TimePeriod = TimePeriod(startDate: self.controlTimePeriod.startDate, endDate: self.controlTimePeriod.endDate.dateByAddingYears(1))
        XCTAssertFalse(self.controlTimePeriod.isEqualToPeriod(differentEndPeriod), "%s Failed", file: #function)
        //Different beginning
        var differentStartPeriod: TimePeriod = TimePeriod(startDate: self.controlTimePeriod.startDate.dateBySubtractingYears(1), endDate: self.controlTimePeriod.endDate)
        XCTAssertFalse(self.controlTimePeriod.isEqualToPeriod(differentStartPeriod), "%s Failed", file: #function)
        //Both endings different
        var differentStartAndEndPeriod: TimePeriod = TimePeriod(startDate: self.controlTimePeriod.startDate.dateBySubtractingYears(1), endDate: self.controlTimePeriod.endDate.dateBySubtractingWeeks(1))
        XCTAssertFalse(self.controlTimePeriod.isEqualToPeriod(differentStartAndEndPeriod), "%s Failed", file: #function)
    }
    
    func testIsInside() {
        //POSITIVE MATCHES
        //Test exact match
        var testTimePeriodExact: TimePeriod = TimePeriod(startDate: self.formatter.dateFromString("2014 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 11 05 18:15:12.000"))
        XCTAssertTrue(testTimePeriodExact.isInside(self.controlTimePeriod), "%s Failed", file: #function)
        //Test same start
        var testTimePeriodSameStart: TimePeriod = TimePeriod(startDate: self.formatter.dateFromString("2014 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2015 11 05 18:15:12.000"))
        XCTAssertTrue(testTimePeriodSameStart.isInside(self.controlTimePeriod), "%s Failed", file: #function)
        //Test same end
        var testTimePeriodSameEnd: TimePeriod = TimePeriod(startDate: self.formatter.dateFromString("2015 12 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 11 05 18:15:12.000"))
        XCTAssertTrue(testTimePeriodSameEnd.isInside(self.controlTimePeriod), "%s Failed", file: #function)
        //Test completely inside
        var testTimePeriodCompletelyInside: TimePeriod = TimePeriod(startDate: self.formatter.dateFromString("2015 12 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 04 05 18:15:12.000"))
        XCTAssertTrue(testTimePeriodCompletelyInside.isInside(self.controlTimePeriod), "%s Failed", file: #function)
        //NEGATIVE MATCHES
        //Test before
        var testTimePeriodBefore: TimePeriod = TimePeriod(startDate: self.formatter.dateFromString("2014 11 02 18:15:12.000"), endDate: self.formatter.dateFromString("2014 11 04 18:15:12.000"))
        XCTAssertFalse(testTimePeriodBefore.isInside(self.controlTimePeriod), "%s Failed", file: #function)
        //Test end same as start
        var testTimePeriodEndSameStart: TimePeriod = TimePeriod(startDate: self.formatter.dateFromString("2013 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2014 11 05 18:15:12.000"))
        XCTAssertFalse(testTimePeriodEndSameStart.isInside(self.controlTimePeriod), "%s Failed", file: #function)
        //Test end inside
        var testTimePeriodEndInside: TimePeriod = TimePeriod(startDate: self.formatter.dateFromString("2014 11 02 18:15:12.000"), endDate: self.formatter.dateFromString("2014 11 07 18:15:12.000"))
        XCTAssertFalse(testTimePeriodEndInside.isInside(self.controlTimePeriod), "%s Failed", file: #function)
        //Test start inside
        var testTimePeriodStartInside: TimePeriod = TimePeriod(startDate: self.formatter.dateFromString("2014 11 07 18:15:12.000"), endDate: self.formatter.dateFromString("2016 12 05 18:15:12.000"))
        XCTAssertFalse(testTimePeriodStartInside.isInside(self.controlTimePeriod), "%s Failed", file: #function)
        //Test start same as end
        var testTimePeriodStartSameEnd: TimePeriod = TimePeriod(startDate: self.formatter.dateFromString("2016 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 11 10 18:15:12.000"))
        XCTAssertFalse(testTimePeriodStartSameEnd.isInside(self.controlTimePeriod), "%s Failed", file: #function)
        //Test after
        var testTimePeriodAfter: TimePeriod = TimePeriod(startDate: self.formatter.dateFromString("2016 12 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 12 10 18:15:12.000"))
        XCTAssertFalse(testTimePeriodAfter.isInside(self.controlTimePeriod), "%s Failed", file: #function)
    }
    
    func testContains() {
        //POSITIVE MATCHES
        //Test exact match
        var testTimePeriodExact: TimePeriod = TimePeriod(startDate: self.formatter.dateFromString("2014 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 11 05 18:15:12.000"))
        XCTAssertTrue(self.controlTimePeriod.contains(testTimePeriodExact), "%s Failed", file: #function)
        //Test same start
        var testTimePeriodSameStart: TimePeriod = TimePeriod(startDate: self.formatter.dateFromString("2014 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2015 11 05 18:15:12.000"))
        XCTAssertTrue(self.controlTimePeriod.contains(testTimePeriodSameStart), "%s Failed", file: #function)
        //Test same end
        var testTimePeriodSameEnd: TimePeriod = TimePeriod(startDate: self.formatter.dateFromString("2015 12 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 11 05 18:15:12.000"))
        XCTAssertTrue(self.controlTimePeriod.contains(testTimePeriodSameEnd), "%s Failed", file: #function)
        //Test completely inside
        var testTimePeriodCompletelyInside: TimePeriod = TimePeriod(startDate: self.formatter.dateFromString("2015 12 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 04 05 18:15:12.000"))
        XCTAssertTrue(self.controlTimePeriod.contains(testTimePeriodCompletelyInside), "%s Failed", file: #function)
        //NEGATIVE MATCHES
        //Test before
        var testTimePeriodBefore: TimePeriod = TimePeriod(startDate: self.formatter.dateFromString("2014 11 02 18:15:12.000"), endDate: self.formatter.dateFromString("2014 11 04 18:15:12.000"))
        XCTAssertFalse(self.controlTimePeriod.contains(testTimePeriodBefore), "%s Failed", file: #function)
        //Test end same as start
        var testTimePeriodEndSameStart: TimePeriod = TimePeriod(startDate: self.formatter.dateFromString("2013 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2014 11 05 18:15:12.000"))
        XCTAssertFalse(self.controlTimePeriod.contains(testTimePeriodEndSameStart), "%s Failed", file: #function)
        //Test end inside
        var testTimePeriodEndInside: TimePeriod = TimePeriod(startDate: self.formatter.dateFromString("2014 11 02 18:15:12.000"), endDate: self.formatter.dateFromString("2014 11 07 18:15:12.000"))
        XCTAssertFalse(self.controlTimePeriod.contains(testTimePeriodEndInside), "%s Failed", file: #function)
        //Test start inside
        var testTimePeriodStartInside: TimePeriod = TimePeriod(startDate: self.formatter.dateFromString("2014 11 07 18:15:12.000"), endDate: self.formatter.dateFromString("2016 12 05 18:15:12.000"))
        XCTAssertFalse(self.controlTimePeriod.contains(testTimePeriodStartInside), "%s Failed", file: #function)
        //Test start same as end
        var testTimePeriodStartSameEnd: TimePeriod = TimePeriod(startDate: self.formatter.dateFromString("2016 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 11 10 18:15:12.000"))
        XCTAssertFalse(self.controlTimePeriod.contains(testTimePeriodStartSameEnd), "%s Failed", file: #function)
        //Test after
        var testTimePeriodAfter: TimePeriod = TimePeriod(startDate: self.formatter.dateFromString("2016 12 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 12 10 18:15:12.000"))
        XCTAssertFalse(self.controlTimePeriod.contains(testTimePeriodAfter), "%s Failed", file: #function)
    }
    
    func testOverlapsWith() {
        //POSITIVE MATCHES
        //Test exact match
        var testTimePeriodExact: TimePeriod = TimePeriod(startDate: self.formatter.dateFromString("2014 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 11 05 18:15:12.000"))
        XCTAssertTrue(self.controlTimePeriod.overlapsWith(testTimePeriodExact), "%s Failed", file: #function)
        //Test same start
        var testTimePeriodSameStart: TimePeriod = TimePeriod(startDate: self.formatter.dateFromString("2014 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2015 11 05 18:15:12.000"))
        XCTAssertTrue(self.controlTimePeriod.overlapsWith(testTimePeriodSameStart), "%s Failed", file: #function)
        //Test same end
        var testTimePeriodSameEnd: TimePeriod = TimePeriod(startDate: self.formatter.dateFromString("2015 12 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 11 05 18:15:12.000"))
        XCTAssertTrue(self.controlTimePeriod.overlapsWith(testTimePeriodSameEnd), "%s Failed", file: #function)
        //Test completely inside
        var testTimePeriodCompletelyInside: TimePeriod = TimePeriod(startDate: self.formatter.dateFromString("2015 12 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 04 05 18:15:12.000"))
        XCTAssertTrue(self.controlTimePeriod.overlapsWith(testTimePeriodCompletelyInside), "%s Failed", file: #function)
        //Test start inside
        var testTimePeriodStartInside: TimePeriod = TimePeriod(startDate: self.formatter.dateFromString("2014 11 07 18:15:12.000"), endDate: self.formatter.dateFromString("2016 12 05 18:15:12.000"))
        XCTAssertTrue(self.controlTimePeriod.overlapsWith(testTimePeriodStartInside), "%s Failed", file: #function)
        //Test end inside
        var testTimePeriodEndInside: TimePeriod = TimePeriod(startDate: self.formatter.dateFromString("2014 11 02 18:15:12.000"), endDate: self.formatter.dateFromString("2014 11 07 18:15:12.000"))
        XCTAssertTrue(self.controlTimePeriod.overlapsWith(testTimePeriodEndInside), "%s Failed", file: #function)
        //NEGATIVE MATCHES
        //Test before
        var testTimePeriodBefore: TimePeriod = TimePeriod(startDate: self.formatter.dateFromString("2014 11 02 18:15:12.000"), endDate: self.formatter.dateFromString("2014 11 04 18:15:12.000"))
        XCTAssertFalse(self.controlTimePeriod.overlapsWith(testTimePeriodBefore), "%s Failed", file: #function)
        //Test end same as start
        var testTimePeriodEndSameStart: TimePeriod = TimePeriod(startDate: self.formatter.dateFromString("2013 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2014 11 05 18:15:12.000"))
        XCTAssertFalse(self.controlTimePeriod.overlapsWith(testTimePeriodEndSameStart), "%s Failed", file: #function)
        //Test start same as end
        var testTimePeriodStartSameEnd: TimePeriod = TimePeriod(startDate: self.formatter.dateFromString("2016 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 11 10 18:15:12.000"))
        XCTAssertFalse(self.controlTimePeriod.overlapsWith(testTimePeriodStartSameEnd), "%s Failed", file: #function)
        //Test after
        var testTimePeriodAfter: TimePeriod = TimePeriod(startDate: self.formatter.dateFromString("2016 12 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 12 10 18:15:12.000"))
        XCTAssertFalse(self.controlTimePeriod.overlapsWith(testTimePeriodAfter), "%s Failed", file: #function)
    }
    
    func testIntersects() {
        //POSITIVE MATCHES
        //Test exact match
        var testTimePeriodExact: TimePeriod = TimePeriod(startDate: self.formatter.dateFromString("2014 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 11 05 18:15:12.000"))
        XCTAssertTrue(self.controlTimePeriod.intersects(testTimePeriodExact), "%s Failed", file: #function)
        //Test same start
        var testTimePeriodSameStart: TimePeriod = TimePeriod(startDate: self.formatter.dateFromString("2014 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2015 11 05 18:15:12.000"))
        XCTAssertTrue(self.controlTimePeriod.intersects(testTimePeriodSameStart), "%s Failed", file: #function)
        //Test same end
        var testTimePeriodSameEnd: TimePeriod = TimePeriod(startDate: self.formatter.dateFromString("2015 12 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 11 05 18:15:12.000"))
        XCTAssertTrue(self.controlTimePeriod.intersects(testTimePeriodSameEnd), "%s Failed", file: #function)
        //Test completely inside
        var testTimePeriodCompletelyInside: TimePeriod = TimePeriod(startDate: self.formatter.dateFromString("2015 12 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 04 05 18:15:12.000"))
        XCTAssertTrue(self.controlTimePeriod.intersects(testTimePeriodCompletelyInside), "%s Failed", file: #function)
        //Test start inside
        var testTimePeriodStartInside: TimePeriod = TimePeriod(startDate: self.formatter.dateFromString("2014 11 07 18:15:12.000"), endDate: self.formatter.dateFromString("2016 12 05 18:15:12.000"))
        XCTAssertTrue(self.controlTimePeriod.intersects(testTimePeriodStartInside), "%s Failed", file: #function)
        //Test end inside
        var testTimePeriodEndInside: TimePeriod = TimePeriod(startDate: self.formatter.dateFromString("2014 11 02 18:15:12.000"), endDate: self.formatter.dateFromString("2014 11 07 18:15:12.000"))
        XCTAssertTrue(self.controlTimePeriod.intersects(testTimePeriodEndInside), "%s Failed", file: #function)
        //Test end same as start
        var testTimePeriodEndSameStart: TimePeriod = TimePeriod(startDate: self.formatter.dateFromString("2013 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2014 11 05 18:15:12.000"))
        XCTAssertTrue(self.controlTimePeriod.intersects(testTimePeriodEndSameStart), "%s Failed", file: #function)
        //Test start same as end
        var testTimePeriodStartSameEnd: TimePeriod = TimePeriod(startDate: self.formatter.dateFromString("2016 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 11 10 18:15:12.000"))
        XCTAssertTrue(self.controlTimePeriod.intersects(testTimePeriodStartSameEnd), "%s Failed", file: #function)
        //NEGATIVE MATCHES
        //Test before
        var testTimePeriodBefore: TimePeriod = TimePeriod(startDate: self.formatter.dateFromString("2014 11 02 18:15:12.000"), endDate: self.formatter.dateFromString("2014 11 04 18:15:12.000"))
        XCTAssertFalse(self.controlTimePeriod.intersects(testTimePeriodBefore), "%s Failed", file: #function)
        //Test after
        var testTimePeriodAfter: TimePeriod = TimePeriod(startDate: self.formatter.dateFromString("2016 12 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 12 10 18:15:12.000"))
        XCTAssertFalse(self.controlTimePeriod.intersects(testTimePeriodAfter), "%s Failed", file: #function)
    }
    
    func testRelationToPeriod() {
        //Test exact match
        var testTimePeriodExact: TimePeriod = TimePeriod(startDate: self.formatter.dateFromString("2014 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 11 05 18:15:12.000"))
        XCTAssertEqual(TimePeriodRelationExactMatch, testTimePeriodExact.relationToPeriod(self.controlTimePeriod), "%s Failed", file: #function)
        //Test same start
        var testTimePeriodSameStart: TimePeriod = TimePeriod(startDate: self.formatter.dateFromString("2014 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2015 11 05 18:15:12.000"))
        XCTAssertEqual(TimePeriodRelationInsideStartTouching, testTimePeriodSameStart.relationToPeriod(self.controlTimePeriod), "%s Failed", file: #function)
        //Test same end
        var testTimePeriodSameEnd: TimePeriod = TimePeriod(startDate: self.formatter.dateFromString("2015 12 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 11 05 18:15:12.000"))
        XCTAssertEqual(TimePeriodRelationInsideEndTouching, testTimePeriodSameEnd.relationToPeriod(self.controlTimePeriod), "%s Failed", file: #function)
        //Test completely inside
        var testTimePeriodCompletelyInside: TimePeriod = TimePeriod(startDate: self.formatter.dateFromString("2015 12 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 04 05 18:15:12.000"))
        XCTAssertEqual(TimePeriodRelationInside, testTimePeriodCompletelyInside.relationToPeriod(self.controlTimePeriod), "%s Failed", file: #function)
        //NEGATIVE MATCHES
        //Test before
        var testTimePeriodBefore: TimePeriod = TimePeriod(startDate: self.formatter.dateFromString("2014 11 02 18:15:12.000"), endDate: self.formatter.dateFromString("2014 11 04 18:15:12.000"))
        XCTAssertEqual(TimePeriodRelationBefore, testTimePeriodBefore.relationToPeriod(self.controlTimePeriod), "%s Failed", file: #function)
        //Test end same as start
        var testTimePeriodEndSameStart: TimePeriod = TimePeriod(startDate: self.formatter.dateFromString("2013 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2014 11 05 18:15:12.000"))
        XCTAssertEqual(TimePeriodRelationEndTouching, testTimePeriodEndSameStart.relationToPeriod(self.controlTimePeriod), "%s Failed", file: #function)
        //Test end inside
        var testTimePeriodEndInside: TimePeriod = TimePeriod(startDate: self.formatter.dateFromString("2014 11 02 18:15:12.000"), endDate: self.formatter.dateFromString("2014 11 07 18:15:12.000"))
        XCTAssertEqual(TimePeriodRelationEndInside, testTimePeriodEndInside.relationToPeriod(self.controlTimePeriod), "%s Failed", file: #function)
        //Test start inside
        var testTimePeriodStartInside: TimePeriod = TimePeriod(startDate: self.formatter.dateFromString("2014 11 07 18:15:12.000"), endDate: self.formatter.dateFromString("2016 12 05 18:15:12.000"))
        XCTAssertEqual(TimePeriodRelationStartInside, testTimePeriodStartInside.relationToPeriod(self.controlTimePeriod), "%s Failed", file: #function)
        //Test start same as end
        var testTimePeriodStartSameEnd: TimePeriod = TimePeriod(startDate: self.formatter.dateFromString("2016 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 11 10 18:15:12.000"))
        XCTAssertEqual(TimePeriodRelationStartTouching, testTimePeriodStartSameEnd.relationToPeriod(self.controlTimePeriod), "%s Failed", file: #function)
        //Test after
        var testTimePeriodAfter: TimePeriod = TimePeriod(startDate: self.formatter.dateFromString("2016 12 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 12 10 18:15:12.000"))
        XCTAssertEqual(TimePeriodRelationAfter, testTimePeriodAfter.relationToPeriod(self.controlTimePeriod), "%s Failed", file: #function)
    }
    
    func testGapBetween() {
        //We are going to treat some of these as False=noGap and True=gap
        //No Gap Same
        XCTAssertFalse(self.controlTimePeriod.gapBetween(self.controlTimePeriod), "%s Failed", file: #function)
        //No Gap End Inside
        var testPeriodNoGap: TimePeriod = TimePeriod(startDate: self.controlTimePeriod.startDate.dateBySubtractingDays(1), endDate: self.controlTimePeriod.endDate.dateBySubtractingDays(1))
        XCTAssertFalse(self.controlTimePeriod.gapBetween(testPeriodNoGap), "%s Failed", file: #function)
        //Gap receiver early
        var testPeriodReceiverEarly: TimePeriod = TimePeriod(size: TimePeriodSizeWeek, startingAt: self.controlTimePeriod.endDate.dateByAddingYears(1))
        XCTAssertTrue(self.controlTimePeriod.gapBetween(testPeriodReceiverEarly), "%s Failed", file: #function)
        //Gap parameter early
        var testPeriodParameterEarly: TimePeriod = TimePeriod(size: TimePeriodSizeWeek, endingAt: self.controlTimePeriod.startDate.dateBySubtractingYears(1))
        XCTAssertTrue(self.controlTimePeriod.gapBetween(testPeriodParameterEarly), "%s Failed", file: #function)
        //Gap of 1 minute
        var testPeriodParameter1MinuteEarly: TimePeriod = TimePeriod(size: TimePeriodSizeSecond, endingAt: self.controlTimePeriod.startDate.dateBySubtractingMinutes(1))
        XCTAssertEqual(60, self.controlTimePeriod.gapBetween(testPeriodParameter1MinuteEarly), "%s Failed", file: #function)
    }
    
    // MARK: - Date Relationships
    func testContaiDate() {
        var testDateBefore: Date = self.formatter!.date(from: "2014 10 05 18:15:12.000")!
        var testDateBetween: Date = self.formatter!.date(from: "2015 11 05 18:15:12.000")!
        var testDateAfter: Date = self.formatter!.date(from: "2016 12 05 18:15:12.000")!
        //Test before
        XCTAssertFalse(self.controlTimePeriod.contaiDate(testDateBefore, interval: TimePeriodIntervalOpen), "%s Failed", file: #function)
        XCTAssertFalse(self.controlTimePeriod.contaiDate(testDateBefore, interval: TimePeriodIntervalClosed), "%s Failed", file: #function)
        //Test on start date
        XCTAssertFalse(self.controlTimePeriod.contaiDate(self.controlTimePeriod.startDate, interval: TimePeriodIntervalOpen), "%s Failed", file: #function)
        XCTAssertTrue(self.controlTimePeriod.contaiDate(self.controlTimePeriod.startDate, interval: TimePeriodIntervalClosed), "%s Failed", file: #function)
        //Test in middle
        XCTAssertTrue(self.controlTimePeriod.contaiDate(testDateBetween, interval: TimePeriodIntervalClosed), "%s Failed", file: #function)
        XCTAssertTrue(self.controlTimePeriod.contaiDate(testDateBetween, interval: TimePeriodIntervalClosed), "%s Failed", file: #function)
        //Test on end date
        XCTAssertFalse(self.controlTimePeriod.contaiDate(self.controlTimePeriod.endDate, interval: TimePeriodIntervalOpen), "%s Failed", file: #function)
        XCTAssertTrue(self.controlTimePeriod.contaiDate(self.controlTimePeriod.endDate, interval: TimePeriodIntervalClosed), "%s Failed", file: #function)
        //Test after
        XCTAssertFalse(self.controlTimePeriod.contaiDate(testDateAfter, interval: TimePeriodIntervalOpen), "%s Failed", file: #function)
        XCTAssertFalse(self.controlTimePeriod.contaiDate(testDateAfter, interval: TimePeriodIntervalClosed), "%s Failed", file: #function)
    }
    
    // MARK: - Period Manipulation
    // MARK: Shift Earlier
    func testShiftSecondEarlier() {
        var startEarlierSecond: Date = self.formatter!.date(from: "2014 11 05 18:15:11.000")!
        var endEarlierSecond: Date = self.formatter!.date(from: "2016 11 05 18:15:11.000")!
        //Second time period
        var testPeriod: TimePeriod = TimePeriod(startDate: startEarlierSecond, endDate: endEarlierSecond)
        self.controlTimePeriod.shiftEarlierWithSize(TimePeriodSizeSecond)
        XCTAssertTrue(testPeriod.startDate.isEqualToDate(self.controlTimePeriod.startDate) && testPeriod.endDate.isEqualToDate(self.controlTimePeriod.endDate), "%s Failed", file: #function)
    }
    
    func testShiftMinuteEarlier() {
        var startEarlier: Date = self.formatter!.date(from: "2014 11 05 18:14:12.000")!
        var endEarlier: Date = self.formatter!.date(from: "2016 11 05 18:14:12.000")!
        var testPeriod: TimePeriod = TimePeriod(startDate: startEarlier, endDate: endEarlier)
        self.controlTimePeriod.shiftEarlierWithSize(TimePeriodSizeMinute)
        XCTAssertTrue(testPeriod.startDate.isEqualToDate(self.controlTimePeriod.startDate) && testPeriod.endDate.isEqualToDate(self.controlTimePeriod.endDate), "%s Failed", file: #function)
    }
    
    func testShiftHourEarlier() {
        var startEarlier: Date = self.formatter!.date(from: "2014 11 05 17:15:12.000")!
        var endEarlier: Date = self.formatter!.date(from: "2016 11 05 17:15:12.000")!
        var testPeriod: TimePeriod = TimePeriod(startDate: startEarlier, endDate: endEarlier)
        self.controlTimePeriod.shiftEarlierWithSize(TimePeriodSizeHour)
        XCTAssertTrue(testPeriod.startDate.isEqualToDate(self.controlTimePeriod.startDate) && testPeriod.endDate.isEqualToDate(self.controlTimePeriod.endDate), "%s Failed", file: #function)
    }
    
    func testShiftDayEarlier() {
        var startEarlier: Date = self.formatter!.date(from: "2014 11 04 18:15:12.000")!
        var endEarlier: Date = self.formatter!.date(from: "2016 11 04 18:15:12.000")!
        var testPeriod: TimePeriod = TimePeriod(startDate: startEarlier, endDate: endEarlier)
        self.controlTimePeriod.shiftEarlierWithSize(TimePeriodSizeDay)
        XCTAssertTrue(testPeriod.startDate.isEqualToDate(self.controlTimePeriod.startDate) && testPeriod.endDate.isEqualToDate(self.controlTimePeriod.endDate), "%s Failed", file: #function)
    }
    
    func testShiftWeekEarlier() {
        var startEarlier: Date = self.formatter!.date(from: "2014 10 29 18:15:12.000")!
        var endEarlier: Date = self.formatter!.date(from: "2016 10 29 18:15:12.000")!
        var testPeriod: TimePeriod = TimePeriod(startDate: startEarlier, endDate: endEarlier)
        self.controlTimePeriod.shiftEarlierWithSize(TimePeriodSizeWeek)
        XCTAssertTrue(testPeriod.startDate.isEqualToDate(self.controlTimePeriod.startDate) && testPeriod.endDate.isEqualToDate(self.controlTimePeriod.endDate), "%s Failed", file: #function)
    }
    
    func testShiftMonthEarlier() {
        var startEarlier: Date = self.formatter!.date(from: "2014 10 05 18:15:12.000")!
        var endEarlier: Date = self.formatter!.date(from: "2016 10 05 18:15:12.000")!
        var testPeriod: TimePeriod = TimePeriod(startDate: startEarlier, endDate: endEarlier)
        self.controlTimePeriod.shiftEarlierWithSize(TimePeriodSizeMonth)
        XCTAssertTrue(testPeriod.startDate.isEqualToDate(self.controlTimePeriod.startDate) && testPeriod.endDate.isEqualToDate(self.controlTimePeriod.endDate), "%s Failed", file: #function)
    }
    
    func testShiftYearEarlier() {
        var startEarlier: Date = self.formatter!.date(from: "2013 11 05 18:15:12.000")!
        var endEarlier: Date = self.formatter!.date(from: "2015 11 05 18:15:12.000")!
        var testPeriod: TimePeriod = TimePeriod(startDate: startEarlier, endDate: endEarlier)
        self.controlTimePeriod.shiftEarlierWithSize(TimePeriodSizeYear)
        XCTAssertTrue(testPeriod.startDate.isEqualToDate(self.controlTimePeriod.startDate) && testPeriod.endDate.isEqualToDate(self.controlTimePeriod.endDate), "%s Failed", file: #function)
    }
    
    // MARK: Shift Later
    func testShiftSecondLater() {
        var startLater: Date = self.formatter!.date(from: "2014 11 05 18:15:13.000")!
        var endLater: Date = self.formatter!.date(from: "2016 11 05 18:15:13.000")!
        //Second time period
        var testPeriod: TimePeriod = TimePeriod(startDate: startLater, endDate: endLater)
        self.controlTimePeriod.shiftLaterWithSize(TimePeriodSizeSecond)
        XCTAssertTrue(testPeriod.startDate.isEqualToDate(self.controlTimePeriod.startDate) && testPeriod.endDate.isEqualToDate(self.controlTimePeriod.endDate), "%s Failed", file: #function)
    }
    
    func testShiftMinuteLater() {
        var startLater: Date = self.formatter!.date(from: "2014 11 05 18:16:12.000")!
        var endLater: Date = self.formatter!.date(from: "2016 11 05 18:16:12.000")!
        var testPeriod: TimePeriod = TimePeriod(startDate: startLater, endDate: endLater)
        self.controlTimePeriod.shiftLaterWithSize(TimePeriodSizeMinute)
        XCTAssertTrue(testPeriod.startDate.isEqualToDate(self.controlTimePeriod.startDate) && testPeriod.endDate.isEqualToDate(self.controlTimePeriod.endDate), "%s Failed", file: #function)
    }
    
    func testShiftHourLater() {
        var startLater: Date = self.formatter!.date(from: "2014 11 05 19:15:12.000")!
        var endLater: Date = self.formatter!.date(from: "2016 11 05 19:15:12.000")!
        var testPeriod: TimePeriod = TimePeriod(startDate: startLater, endDate: endLater)
        self.controlTimePeriod.shiftLaterWithSize(TimePeriodSizeHour)
        XCTAssertTrue(testPeriod.startDate.isEqualToDate(self.controlTimePeriod.startDate) && testPeriod.endDate.isEqualToDate(self.controlTimePeriod.endDate), "%s Failed", file: #function)
    }
    
    func testShiftDayLater() {
        var startLater: Date = self.formatter!.date(from: "2014 11 06 18:15:12.000")!
        var endLater: Date = self.formatter!.date(from: "2016 11 06 18:15:12.000")!
        var testPeriod: TimePeriod = TimePeriod(startDate: startLater, endDate: endLater)
        self.controlTimePeriod.shiftLaterWithSize(TimePeriodSizeDay)
        XCTAssertTrue(testPeriod.startDate.isEqualToDate(self.controlTimePeriod.startDate) && testPeriod.endDate.isEqualToDate(self.controlTimePeriod.endDate), "%s Failed", file: #function)
    }
    
    func testShiftWeekLater() {
        var startLater: Date = self.formatter!.date(from: "2014 11 12 18:15:12.000")!
        var endLater: Date = self.formatter!.date(from: "2016 11 12 18:15:12.000")!
        var testPeriod: TimePeriod = TimePeriod(startDate: startLater, endDate: endLater)
        self.controlTimePeriod.shiftLaterWithSize(TimePeriodSizeWeek)
        XCTAssertTrue(testPeriod.startDate.isEqualToDate(self.controlTimePeriod.startDate) && testPeriod.endDate.isEqualToDate(self.controlTimePeriod.endDate), "%s Failed", file: #function)
    }
    
    func testShiftMonthLater() {
        var startLater: Date = self.formatter!.date(from: "2014 12 05 18:15:12.000")!
        var endLater: Date = self.formatter!.date(from: "2016 12 05 18:15:12.000")!
        var testPeriod: TimePeriod = TimePeriod(startDate: startLater, endDate: endLater)
        self.controlTimePeriod.shiftLaterWithSize(TimePeriodSizeMonth)
        XCTAssertTrue(testPeriod.startDate.isEqualToDate(self.controlTimePeriod.startDate) && testPeriod.endDate.isEqualToDate(self.controlTimePeriod.endDate), "%s Failed", file: #function)
    }
    
    func testShiftYearLater() {
        var startLater: Date = self.formatter!.date(from: "2015 11 05 18:15:12.000")!
        var endLater: Date = self.formatter!.date(from: "2017 11 05 18:15:12.000")!
        var testPeriod: TimePeriod = TimePeriod(startDate: startLater, endDate: endLater)
        self.controlTimePeriod.shiftLaterWithSize(TimePeriodSizeYear)
        XCTAssertTrue(testPeriod.startDate.isEqualToDate(self.controlTimePeriod.startDate) && testPeriod.endDate.isEqualToDate(self.controlTimePeriod.endDate), "%s Failed", file: #function)
    }
    
    // MARK: Lengthen / Shorten
    func testLengthenAnchorStart() {
        //Test dates
        var lengthenedEnd: Date = self.formatter!.date(from: "2016 11 05 18:15:14.000")!
        var testPeriod: TimePeriod = TimePeriod(startDate: self.controlTimePeriod.startDate, endDate: lengthenedEnd)
        self.controlTimePeriod.lengthenWithAnchorDate(TimePeriodAnchorStart, size: TimePeriodSizeSecond, amount: 2)
        XCTAssertTrue(testPeriod.startDate.isEqualToDate(self.controlTimePeriod.startDate) && testPeriod.endDate.isEqualToDate(self.controlTimePeriod.endDate), "%s Failed", file: #function)
    }
    
    func testLengthenAnchorCenter() {
        //Test dates
        var lengthenedStart: Date = self.formatter!.date(from: "2014 11 05 18:15:11.000")!
        var lengthenedEnd: Date = self.formatter!.date(from: "2016 11 05 18:15:13.000")!
        var testPeriod: TimePeriod = TimePeriod(startDate: lengthenedStart, endDate: lengthenedEnd)
        self.controlTimePeriod.lengthenWithAnchorDate(TimePeriodAnchorCenter, size: TimePeriodSizeSecond, amount: 2)
        XCTAssertTrue(testPeriod.startDate.isEqualToDate(self.controlTimePeriod.startDate) && testPeriod.endDate.isEqualToDate(self.controlTimePeriod.endDate), "%s Failed", file: #function)
    }
    
    func testLengthenAnchorEnd() {
        //Test dates
        var lengthenedStart: Date = self.formatter!.date(from: "2014 11 05 18:15:10.000")!
        var testPeriod: TimePeriod = TimePeriod(startDate: lengthenedStart, endDate: self.controlTimePeriod.endDate)
        self.controlTimePeriod.lengthenWithAnchorDate(TimePeriodAnchorEnd, size: TimePeriodSizeSecond, amount: 2)
        XCTAssertTrue(testPeriod.startDate.isEqualToDate(self.controlTimePeriod.startDate) && testPeriod.endDate.isEqualToDate(self.controlTimePeriod.endDate), "%s Failed", file: #function)
    }
    
    func testShortenAnchorStart() {
        //Test dates
        var shortenedEnd: Date = self.formatter!.date(from: "2016 11 05 18:15:10.000")!
        var testPeriod: TimePeriod = TimePeriod(startDate: self.controlTimePeriod.startDate, endDate: shortenedEnd)
        self.controlTimePeriod.shortenWithAnchorDate(TimePeriodAnchorStart, size: TimePeriodSizeSecond, amount: 2)
        XCTAssertTrue(testPeriod.startDate.isEqualToDate(self.controlTimePeriod.startDate) && testPeriod.endDate.isEqualToDate(self.controlTimePeriod.endDate), "%s Failed", file: #function)
    }
    
    func testShortenAnchorCenter() {
        //Test dates
        var shortenedStart: Date = self.formatter!.date(from: "2014 11 05 18:15:13.000")!
        var shortenedEnd: Date = self.formatter!.date(from: "2016 11 05 18:15:11.000")!
        var testPeriod: TimePeriod = TimePeriod(startDate: shortenedStart, endDate: shortenedEnd)
        self.controlTimePeriod.shortenWithAnchorDate(TimePeriodAnchorCenter, size: TimePeriodSizeSecond, amount: 2)
        XCTAssertTrue(testPeriod.startDate.isEqualToDate(self.controlTimePeriod.startDate) && testPeriod.endDate.isEqualToDate(self.controlTimePeriod.endDate), "%s Failed", file: #function)
    }
    
    func testShortenAnchorEnd() {
        //Test dates
        var shortenedStart: Date = self.formatter!.date(from: "2014 11 05 18:15:14.000")!
        var testPeriod: TimePeriod = TimePeriod(startDate: shortenedStart, endDate: self.controlTimePeriod.endDate)
        self.controlTimePeriod.shortenWithAnchorDate(TimePeriodAnchorEnd, size: TimePeriodSizeSecond, amount: 2)
        XCTAssertTrue(testPeriod.startDate.isEqualToDate(self.controlTimePeriod.startDate) && testPeriod.endDate.isEqualToDate(self.controlTimePeriod.endDate), "%s Failed", file: #function)
    }
    
}

