//
//  TimePeriodTests.swift
//  DateToolsTests
//
//  Created by Grayson Webster on 8/19/16.
//  Copyright © 2016 Matthew York. All rights reserved.
//

import XCTest

class DTTimePeriodTests : XCTestCase {
    
    var formatter: DateFormatter?
    var controlTimePeriod: DTTimePeriod?
    
    override func setUp() {
        super.up = null
        // ut setup code here. This method is called before the invocation of each test method in the class.
        self.controlTimePeriod = DTTimePeriod()
        //Create TimePeriod that is 2 years long
        self.formatter = DateFormatter()
        self.formatter?.dateFormat = "yyyy MM dd HH:mm:ss.SSS"
        self.controlTimePeriod.StartDate = self.formatter.dateFromString("2014 11 05 18:15:12.000")
        self.controlTimePeriod.EndDate = self.formatter.dateFromString("2016 11 05 18:15:12.000")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: - Custom Init / Factory Methods
    func testBasicInitsAndFactoryMethods() {
        //Basic init
        var testPeriodInit: DTTimePeriod = DTTimePeriod(startdate: self.controlTimePeriod.StartDate, endDate: self.controlTimePeriod.EndDate)
        XCTAssertTrue(self.controlTimePeriod.StartDate.isEqualToDate(testPeriodInit.StartDate) && self.controlTimePeriod.EndDate.isEqualToDate(testPeriodInit.EndDate), "%s Failed", file: #function)
        //Basic factory
        var testPeriodFactoryInit: DTTimePeriod = DTTimePeriod(startDate: self.controlTimePeriod.StartDate, endDate: self.controlTimePeriod.EndDate)
        XCTAssertTrue(self.controlTimePeriod.StartDate.isEqualToDate(testPeriodFactoryInit.StartDate) && self.controlTimePeriod.EndDate.isEqualToDate(testPeriodFactoryInit.EndDate), "%s Failed", file: #function)
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
        var testPeriodSecond: DTTimePeriod = DTTimePeriod(size: DTTimePeriodSizeSecond, startingAt: self.controlTimePeriod.StartDate)
        XCTAssertTrue(testPeriodSecond.StartDate.isEqualToDate(self.controlTimePeriod.StartDate) && testPeriodSecond.EndDate.isEqualToDate(startLaterSecond), "%s Failed", file: #function)
        //Minute time period
        var testPeriodMinute: DTTimePeriod = DTTimePeriod(size: DTTimePeriodSizeMinute, startingAt: self.controlTimePeriod.StartDate)
        XCTAssertTrue(testPeriodMinute.StartDate.isEqualToDate(self.controlTimePeriod.StartDate) && testPeriodMinute.EndDate.isEqualToDate(startLaterMinute), "%s Failed", file: #function)
        //Hour time period
        var testPeriodHour: DTTimePeriod = DTTimePeriod(size: DTTimePeriodSizeHour, startingAt: self.controlTimePeriod.StartDate)
        XCTAssertTrue(testPeriodHour.StartDate.isEqualToDate(self.controlTimePeriod.StartDate) && testPeriodHour.EndDate.isEqualToDate(startLaterHour), "%s Failed", file: #function)
        //Day time period
        var testPeriodDay: DTTimePeriod = DTTimePeriod(size: DTTimePeriodSizeDay, startingAt: self.controlTimePeriod.StartDate)
        XCTAssertTrue(testPeriodDay.StartDate.isEqualToDate(self.controlTimePeriod.StartDate) && testPeriodDay.EndDate.isEqualToDate(startLaterDay), "%s Failed", file: #function)
        //Week time period
        var testPeriodWeek: DTTimePeriod = DTTimePeriod(size: DTTimePeriodSizeWeek, startingAt: self.controlTimePeriod.StartDate)
        XCTAssertTrue(testPeriodWeek.StartDate.isEqualToDate(self.controlTimePeriod.StartDate) && testPeriodWeek.EndDate.isEqualToDate(startLaterWeek), "%s Failed", file: #function)
        //Month time period
        var testPeriodMonth: DTTimePeriod = DTTimePeriod(size: DTTimePeriodSizeMonth, startingAt: self.controlTimePeriod.StartDate)
        XCTAssertTrue(testPeriodMonth.StartDate.isEqualToDate(self.controlTimePeriod.StartDate) && testPeriodMonth.EndDate.isEqualToDate(startLaterMonth), "%s Failed", file: #function)
        //Year time period
        var testPeriodYear: DTTimePeriod = DTTimePeriod(size: DTTimePeriodSizeYear, startingAt: self.controlTimePeriod.StartDate)
        XCTAssertTrue(testPeriodYear.StartDate.isEqualToDate(self.controlTimePeriod.StartDate) && testPeriodYear.EndDate.isEqualToDate(startLaterYear), "%s Failed", file: #function)
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
        var testPeriodSecond: DTTimePeriod = DTTimePeriod(size: DTTimePeriodSizeSecond, endingAt: self.controlTimePeriod.EndDate)
        XCTAssertTrue(testPeriodSecond.StartDate.isEqualToDate(endEarlierSecond) && testPeriodSecond.EndDate.isEqualToDate(self.controlTimePeriod.EndDate), "%s Failed", file: #function)
        //Minute time period
        var testPeriodMinute: DTTimePeriod = DTTimePeriod(size: DTTimePeriodSizeMinute, endingAt: self.controlTimePeriod.EndDate)
        XCTAssertTrue(testPeriodMinute.StartDate.isEqualToDate(endEarlierMinute) && testPeriodMinute.EndDate.isEqualToDate(self.controlTimePeriod.EndDate), "%s Failed", file: #function)
        //Hour time period
        var testPeriodHour: DTTimePeriod = DTTimePeriod(size: DTTimePeriodSizeHour, endingAt: self.controlTimePeriod.EndDate)
        XCTAssertTrue(testPeriodHour.StartDate.isEqualToDate(endEarlierHour) && testPeriodHour.EndDate.isEqualToDate(self.controlTimePeriod.EndDate), "%s Failed", file: #function)
        //Day time period
        var testPeriodDay: DTTimePeriod = DTTimePeriod(size: DTTimePeriodSizeDay, endingAt: self.controlTimePeriod.EndDate)
        XCTAssertTrue(testPeriodDay.StartDate.isEqualToDate(endEarlierDay) && testPeriodDay.EndDate.isEqualToDate(self.controlTimePeriod.EndDate), "%s Failed", file: #function)
        //Week time period
        var testPeriodWeek: DTTimePeriod = DTTimePeriod(size: DTTimePeriodSizeWeek, endingAt: self.controlTimePeriod.EndDate)
        XCTAssertTrue(testPeriodWeek.StartDate.isEqualToDate(endEarlierWeek) && testPeriodWeek.EndDate.isEqualToDate(self.controlTimePeriod.EndDate), "%s Failed", file: #function)
        //Month time period
        var testPeriodMonth: DTTimePeriod = DTTimePeriod(size: DTTimePeriodSizeMonth, endingAt: self.controlTimePeriod.EndDate)
        XCTAssertTrue(testPeriodMonth.StartDate.isEqualToDate(endEarlierMonth) && testPeriodMonth.EndDate.isEqualToDate(self.controlTimePeriod.EndDate), "%s Failed", file: #function)
        //Year time period
        var testPeriodYear: DTTimePeriod = DTTimePeriod(size: DTTimePeriodSizeYear, endingAt: self.controlTimePeriod.EndDate)
        XCTAssertTrue(testPeriodYear.StartDate.isEqualToDate(endEarlierYear) && testPeriodYear.EndDate.isEqualToDate(self.controlTimePeriod.EndDate), "%s Failed", file: #function)
    }
    
    // MARK: - Time Period Information
    func testHasStartDate() {
        //Has start date
        XCTAssertTrue(self.controlTimePeriod.hasStartDate(), "%s Failed", file: #function)
        //Deosn't have start date
        var testPeriod: DTTimePeriod = DTTimePeriod(startDate: nil, endDate: self.controlTimePeriod.EndDate)
        XCTAssertFalse(testPeriod.hasStartDate(), "%s Failed", file: #function)
    }
    
    func testHasEndDate() {
        //Has end date
        XCTAssertTrue(self.controlTimePeriod.hasEndDate(), "%s Failed", file: #function)
        //Deosn't have end date
        var testPeriod: DTTimePeriod = DTTimePeriod(startDate: self.controlTimePeriod.StartDate, endDate: nil)
        XCTAssertFalse(testPeriod.hasEndDate(), "%s Failed", file: #function)
    }
    
    func testIsMoment() {
        //Is moment
        var testPeriod: DTTimePeriod = DTTimePeriod(startDate: self.controlTimePeriod.StartDate, endDate: self.controlTimePeriod.StartDate)
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
        var testPeriod: DTTimePeriod = DTTimePeriod(startDate: self.controlTimePeriod.StartDate, endDate: self.controlTimePeriod.StartDate.dateByAddingHours(4))
        XCTAssertEqual(4, testPeriod.durationInHours(), "%s Failed", file: #function)
    }
    
    func testDurationInMinutes() {
        var testPeriod: DTTimePeriod = DTTimePeriod(startDate: self.controlTimePeriod.StartDate, endDate: self.controlTimePeriod.StartDate.dateByAddingHours(4))
        XCTAssertEqual(240, testPeriod.durationInMinutes(), "%s Failed", file: #function)
    }
    
    func testDurationInSeconds() {
        var testPeriod: DTTimePeriod = DTTimePeriod(startDate: self.controlTimePeriod.StartDate, endDate: self.controlTimePeriod.StartDate.dateByAddingHours(4))
        XCTAssertEqual(14400, testPeriod.durationInSeconds(), "%s Failed", file: #function)
    }
    
    // MARK: - Time Period Relationship
    func testIsSamePeriod() {
        //Same
        XCTAssertTrue(self.controlTimePeriod.isEqualToPeriod(self.controlTimePeriod), "%s Failed", file: #function)
        //Different ending
        var differentEndPeriod: DTTimePeriod = DTTimePeriod(startDate: self.controlTimePeriod.StartDate, endDate: self.controlTimePeriod.EndDate.dateByAddingYears(1))
        XCTAssertFalse(self.controlTimePeriod.isEqualToPeriod(differentEndPeriod), "%s Failed", file: #function)
        //Different beginning
        var differentStartPeriod: DTTimePeriod = DTTimePeriod(startDate: self.controlTimePeriod.StartDate.dateBySubtractingYears(1), endDate: self.controlTimePeriod.EndDate)
        XCTAssertFalse(self.controlTimePeriod.isEqualToPeriod(differentStartPeriod), "%s Failed", file: #function)
        //Both endings different
        var differentStartAndEndPeriod: DTTimePeriod = DTTimePeriod(startDate: self.controlTimePeriod.StartDate.dateBySubtractingYears(1), endDate: self.controlTimePeriod.EndDate.dateBySubtractingWeeks(1))
        XCTAssertFalse(self.controlTimePeriod.isEqualToPeriod(differentStartAndEndPeriod), "%s Failed", file: #function)
    }
    
    func testIsInside() {
        //POSITIVE MATCHES
        //Test exact match
        var testTimePeriodExact: DTTimePeriod = DTTimePeriod(startDate: self.formatter.dateFromString("2014 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 11 05 18:15:12.000"))
        XCTAssertTrue(testTimePeriodExact.isInside(self.controlTimePeriod), "%s Failed", file: #function)
        //Test same start
        var testTimePeriodSameStart: DTTimePeriod = DTTimePeriod(startDate: self.formatter.dateFromString("2014 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2015 11 05 18:15:12.000"))
        XCTAssertTrue(testTimePeriodSameStart.isInside(self.controlTimePeriod), "%s Failed", file: #function)
        //Test same end
        var testTimePeriodSameEnd: DTTimePeriod = DTTimePeriod(startDate: self.formatter.dateFromString("2015 12 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 11 05 18:15:12.000"))
        XCTAssertTrue(testTimePeriodSameEnd.isInside(self.controlTimePeriod), "%s Failed", file: #function)
        //Test completely inside
        var testTimePeriodCompletelyInside: DTTimePeriod = DTTimePeriod(startDate: self.formatter.dateFromString("2015 12 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 04 05 18:15:12.000"))
        XCTAssertTrue(testTimePeriodCompletelyInside.isInside(self.controlTimePeriod), "%s Failed", file: #function)
        //NEGATIVE MATCHES
        //Test before
        var testTimePeriodBefore: DTTimePeriod = DTTimePeriod(startDate: self.formatter.dateFromString("2014 11 02 18:15:12.000"), endDate: self.formatter.dateFromString("2014 11 04 18:15:12.000"))
        XCTAssertFalse(testTimePeriodBefore.isInside(self.controlTimePeriod), "%s Failed", file: #function)
        //Test end same as start
        var testTimePeriodEndSameStart: DTTimePeriod = DTTimePeriod(startDate: self.formatter.dateFromString("2013 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2014 11 05 18:15:12.000"))
        XCTAssertFalse(testTimePeriodEndSameStart.isInside(self.controlTimePeriod), "%s Failed", file: #function)
        //Test end inside
        var testTimePeriodEndInside: DTTimePeriod = DTTimePeriod(startDate: self.formatter.dateFromString("2014 11 02 18:15:12.000"), endDate: self.formatter.dateFromString("2014 11 07 18:15:12.000"))
        XCTAssertFalse(testTimePeriodEndInside.isInside(self.controlTimePeriod), "%s Failed", file: #function)
        //Test start inside
        var testTimePeriodStartInside: DTTimePeriod = DTTimePeriod(startDate: self.formatter.dateFromString("2014 11 07 18:15:12.000"), endDate: self.formatter.dateFromString("2016 12 05 18:15:12.000"))
        XCTAssertFalse(testTimePeriodStartInside.isInside(self.controlTimePeriod), "%s Failed", file: #function)
        //Test start same as end
        var testTimePeriodStartSameEnd: DTTimePeriod = DTTimePeriod(startDate: self.formatter.dateFromString("2016 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 11 10 18:15:12.000"))
        XCTAssertFalse(testTimePeriodStartSameEnd.isInside(self.controlTimePeriod), "%s Failed", file: #function)
        //Test after
        var testTimePeriodAfter: DTTimePeriod = DTTimePeriod(startDate: self.formatter.dateFromString("2016 12 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 12 10 18:15:12.000"))
        XCTAssertFalse(testTimePeriodAfter.isInside(self.controlTimePeriod), "%s Failed", file: #function)
    }
    
    func testContains() {
        //POSITIVE MATCHES
        //Test exact match
        var testTimePeriodExact: DTTimePeriod = DTTimePeriod(startDate: self.formatter.dateFromString("2014 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 11 05 18:15:12.000"))
        XCTAssertTrue(self.controlTimePeriod.contains(testTimePeriodExact), "%s Failed", file: #function)
        //Test same start
        var testTimePeriodSameStart: DTTimePeriod = DTTimePeriod(startDate: self.formatter.dateFromString("2014 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2015 11 05 18:15:12.000"))
        XCTAssertTrue(self.controlTimePeriod.contains(testTimePeriodSameStart), "%s Failed", file: #function)
        //Test same end
        var testTimePeriodSameEnd: DTTimePeriod = DTTimePeriod(startDate: self.formatter.dateFromString("2015 12 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 11 05 18:15:12.000"))
        XCTAssertTrue(self.controlTimePeriod.contains(testTimePeriodSameEnd), "%s Failed", file: #function)
        //Test completely inside
        var testTimePeriodCompletelyInside: DTTimePeriod = DTTimePeriod(startDate: self.formatter.dateFromString("2015 12 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 04 05 18:15:12.000"))
        XCTAssertTrue(self.controlTimePeriod.contains(testTimePeriodCompletelyInside), "%s Failed", file: #function)
        //NEGATIVE MATCHES
        //Test before
        var testTimePeriodBefore: DTTimePeriod = DTTimePeriod(startDate: self.formatter.dateFromString("2014 11 02 18:15:12.000"), endDate: self.formatter.dateFromString("2014 11 04 18:15:12.000"))
        XCTAssertFalse(self.controlTimePeriod.contains(testTimePeriodBefore), "%s Failed", file: #function)
        //Test end same as start
        var testTimePeriodEndSameStart: DTTimePeriod = DTTimePeriod(startDate: self.formatter.dateFromString("2013 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2014 11 05 18:15:12.000"))
        XCTAssertFalse(self.controlTimePeriod.contains(testTimePeriodEndSameStart), "%s Failed", file: #function)
        //Test end inside
        var testTimePeriodEndInside: DTTimePeriod = DTTimePeriod(startDate: self.formatter.dateFromString("2014 11 02 18:15:12.000"), endDate: self.formatter.dateFromString("2014 11 07 18:15:12.000"))
        XCTAssertFalse(self.controlTimePeriod.contains(testTimePeriodEndInside), "%s Failed", file: #function)
        //Test start inside
        var testTimePeriodStartInside: DTTimePeriod = DTTimePeriod(startDate: self.formatter.dateFromString("2014 11 07 18:15:12.000"), endDate: self.formatter.dateFromString("2016 12 05 18:15:12.000"))
        XCTAssertFalse(self.controlTimePeriod.contains(testTimePeriodStartInside), "%s Failed", file: #function)
        //Test start same as end
        var testTimePeriodStartSameEnd: DTTimePeriod = DTTimePeriod(startDate: self.formatter.dateFromString("2016 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 11 10 18:15:12.000"))
        XCTAssertFalse(self.controlTimePeriod.contains(testTimePeriodStartSameEnd), "%s Failed", file: #function)
        //Test after
        var testTimePeriodAfter: DTTimePeriod = DTTimePeriod(startDate: self.formatter.dateFromString("2016 12 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 12 10 18:15:12.000"))
        XCTAssertFalse(self.controlTimePeriod.contains(testTimePeriodAfter), "%s Failed", file: #function)
    }
    
    func testOverlapsWith() {
        //POSITIVE MATCHES
        //Test exact match
        var testTimePeriodExact: DTTimePeriod = DTTimePeriod(startDate: self.formatter.dateFromString("2014 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 11 05 18:15:12.000"))
        XCTAssertTrue(self.controlTimePeriod.overlapsWith(testTimePeriodExact), "%s Failed", file: #function)
        //Test same start
        var testTimePeriodSameStart: DTTimePeriod = DTTimePeriod(startDate: self.formatter.dateFromString("2014 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2015 11 05 18:15:12.000"))
        XCTAssertTrue(self.controlTimePeriod.overlapsWith(testTimePeriodSameStart), "%s Failed", file: #function)
        //Test same end
        var testTimePeriodSameEnd: DTTimePeriod = DTTimePeriod(startDate: self.formatter.dateFromString("2015 12 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 11 05 18:15:12.000"))
        XCTAssertTrue(self.controlTimePeriod.overlapsWith(testTimePeriodSameEnd), "%s Failed", file: #function)
        //Test completely inside
        var testTimePeriodCompletelyInside: DTTimePeriod = DTTimePeriod(startDate: self.formatter.dateFromString("2015 12 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 04 05 18:15:12.000"))
        XCTAssertTrue(self.controlTimePeriod.overlapsWith(testTimePeriodCompletelyInside), "%s Failed", file: #function)
        //Test start inside
        var testTimePeriodStartInside: DTTimePeriod = DTTimePeriod(startDate: self.formatter.dateFromString("2014 11 07 18:15:12.000"), endDate: self.formatter.dateFromString("2016 12 05 18:15:12.000"))
        XCTAssertTrue(self.controlTimePeriod.overlapsWith(testTimePeriodStartInside), "%s Failed", file: #function)
        //Test end inside
        var testTimePeriodEndInside: DTTimePeriod = DTTimePeriod(startDate: self.formatter.dateFromString("2014 11 02 18:15:12.000"), endDate: self.formatter.dateFromString("2014 11 07 18:15:12.000"))
        XCTAssertTrue(self.controlTimePeriod.overlapsWith(testTimePeriodEndInside), "%s Failed", file: #function)
        //NEGATIVE MATCHES
        //Test before
        var testTimePeriodBefore: DTTimePeriod = DTTimePeriod(startDate: self.formatter.dateFromString("2014 11 02 18:15:12.000"), endDate: self.formatter.dateFromString("2014 11 04 18:15:12.000"))
        XCTAssertFalse(self.controlTimePeriod.overlapsWith(testTimePeriodBefore), "%s Failed", file: #function)
        //Test end same as start
        var testTimePeriodEndSameStart: DTTimePeriod = DTTimePeriod(startDate: self.formatter.dateFromString("2013 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2014 11 05 18:15:12.000"))
        XCTAssertFalse(self.controlTimePeriod.overlapsWith(testTimePeriodEndSameStart), "%s Failed", file: #function)
        //Test start same as end
        var testTimePeriodStartSameEnd: DTTimePeriod = DTTimePeriod(startDate: self.formatter.dateFromString("2016 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 11 10 18:15:12.000"))
        XCTAssertFalse(self.controlTimePeriod.overlapsWith(testTimePeriodStartSameEnd), "%s Failed", file: #function)
        //Test after
        var testTimePeriodAfter: DTTimePeriod = DTTimePeriod(startDate: self.formatter.dateFromString("2016 12 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 12 10 18:15:12.000"))
        XCTAssertFalse(self.controlTimePeriod.overlapsWith(testTimePeriodAfter), "%s Failed", file: #function)
    }
    
    func testIntersects() {
        //POSITIVE MATCHES
        //Test exact match
        var testTimePeriodExact: DTTimePeriod = DTTimePeriod(startDate: self.formatter.dateFromString("2014 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 11 05 18:15:12.000"))
        XCTAssertTrue(self.controlTimePeriod.intersects(testTimePeriodExact), "%s Failed", file: #function)
        //Test same start
        var testTimePeriodSameStart: DTTimePeriod = DTTimePeriod(startDate: self.formatter.dateFromString("2014 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2015 11 05 18:15:12.000"))
        XCTAssertTrue(self.controlTimePeriod.intersects(testTimePeriodSameStart), "%s Failed", file: #function)
        //Test same end
        var testTimePeriodSameEnd: DTTimePeriod = DTTimePeriod(startDate: self.formatter.dateFromString("2015 12 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 11 05 18:15:12.000"))
        XCTAssertTrue(self.controlTimePeriod.intersects(testTimePeriodSameEnd), "%s Failed", file: #function)
        //Test completely inside
        var testTimePeriodCompletelyInside: DTTimePeriod = DTTimePeriod(startDate: self.formatter.dateFromString("2015 12 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 04 05 18:15:12.000"))
        XCTAssertTrue(self.controlTimePeriod.intersects(testTimePeriodCompletelyInside), "%s Failed", file: #function)
        //Test start inside
        var testTimePeriodStartInside: DTTimePeriod = DTTimePeriod(startDate: self.formatter.dateFromString("2014 11 07 18:15:12.000"), endDate: self.formatter.dateFromString("2016 12 05 18:15:12.000"))
        XCTAssertTrue(self.controlTimePeriod.intersects(testTimePeriodStartInside), "%s Failed", file: #function)
        //Test end inside
        var testTimePeriodEndInside: DTTimePeriod = DTTimePeriod(startDate: self.formatter.dateFromString("2014 11 02 18:15:12.000"), endDate: self.formatter.dateFromString("2014 11 07 18:15:12.000"))
        XCTAssertTrue(self.controlTimePeriod.intersects(testTimePeriodEndInside), "%s Failed", file: #function)
        //Test end same as start
        var testTimePeriodEndSameStart: DTTimePeriod = DTTimePeriod(startDate: self.formatter.dateFromString("2013 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2014 11 05 18:15:12.000"))
        XCTAssertTrue(self.controlTimePeriod.intersects(testTimePeriodEndSameStart), "%s Failed", file: #function)
        //Test start same as end
        var testTimePeriodStartSameEnd: DTTimePeriod = DTTimePeriod(startDate: self.formatter.dateFromString("2016 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 11 10 18:15:12.000"))
        XCTAssertTrue(self.controlTimePeriod.intersects(testTimePeriodStartSameEnd), "%s Failed", file: #function)
        //NEGATIVE MATCHES
        //Test before
        var testTimePeriodBefore: DTTimePeriod = DTTimePeriod(startDate: self.formatter.dateFromString("2014 11 02 18:15:12.000"), endDate: self.formatter.dateFromString("2014 11 04 18:15:12.000"))
        XCTAssertFalse(self.controlTimePeriod.intersects(testTimePeriodBefore), "%s Failed", file: #function)
        //Test after
        var testTimePeriodAfter: DTTimePeriod = DTTimePeriod(startDate: self.formatter.dateFromString("2016 12 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 12 10 18:15:12.000"))
        XCTAssertFalse(self.controlTimePeriod.intersects(testTimePeriodAfter), "%s Failed", file: #function)
    }
    
    func testRelationToPeriod() {
        //Test exact match
        var testTimePeriodExact: DTTimePeriod = DTTimePeriod(startDate: self.formatter.dateFromString("2014 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 11 05 18:15:12.000"))
        XCTAssertEqual(DTTimePeriodRelationExactMatch, testTimePeriodExact.relationToPeriod(self.controlTimePeriod), "%s Failed", file: #function)
        //Test same start
        var testTimePeriodSameStart: DTTimePeriod = DTTimePeriod(startDate: self.formatter.dateFromString("2014 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2015 11 05 18:15:12.000"))
        XCTAssertEqual(DTTimePeriodRelationInsideStartTouching, testTimePeriodSameStart.relationToPeriod(self.controlTimePeriod), "%s Failed", file: #function)
        //Test same end
        var testTimePeriodSameEnd: DTTimePeriod = DTTimePeriod(startDate: self.formatter.dateFromString("2015 12 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 11 05 18:15:12.000"))
        XCTAssertEqual(DTTimePeriodRelationInsideEndTouching, testTimePeriodSameEnd.relationToPeriod(self.controlTimePeriod), "%s Failed", file: #function)
        //Test completely inside
        var testTimePeriodCompletelyInside: DTTimePeriod = DTTimePeriod(startDate: self.formatter.dateFromString("2015 12 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 04 05 18:15:12.000"))
        XCTAssertEqual(DTTimePeriodRelationInside, testTimePeriodCompletelyInside.relationToPeriod(self.controlTimePeriod), "%s Failed", file: #function)
        //NEGATIVE MATCHES
        //Test before
        var testTimePeriodBefore: DTTimePeriod = DTTimePeriod(startDate: self.formatter.dateFromString("2014 11 02 18:15:12.000"), endDate: self.formatter.dateFromString("2014 11 04 18:15:12.000"))
        XCTAssertEqual(DTTimePeriodRelationBefore, testTimePeriodBefore.relationToPeriod(self.controlTimePeriod), "%s Failed", file: #function)
        //Test end same as start
        var testTimePeriodEndSameStart: DTTimePeriod = DTTimePeriod(startDate: self.formatter.dateFromString("2013 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2014 11 05 18:15:12.000"))
        XCTAssertEqual(DTTimePeriodRelationEndTouching, testTimePeriodEndSameStart.relationToPeriod(self.controlTimePeriod), "%s Failed", file: #function)
        //Test end inside
        var testTimePeriodEndInside: DTTimePeriod = DTTimePeriod(startDate: self.formatter.dateFromString("2014 11 02 18:15:12.000"), endDate: self.formatter.dateFromString("2014 11 07 18:15:12.000"))
        XCTAssertEqual(DTTimePeriodRelationEndInside, testTimePeriodEndInside.relationToPeriod(self.controlTimePeriod), "%s Failed", file: #function)
        //Test start inside
        var testTimePeriodStartInside: DTTimePeriod = DTTimePeriod(startDate: self.formatter.dateFromString("2014 11 07 18:15:12.000"), endDate: self.formatter.dateFromString("2016 12 05 18:15:12.000"))
        XCTAssertEqual(DTTimePeriodRelationStartInside, testTimePeriodStartInside.relationToPeriod(self.controlTimePeriod), "%s Failed", file: #function)
        //Test start same as end
        var testTimePeriodStartSameEnd: DTTimePeriod = DTTimePeriod(startDate: self.formatter.dateFromString("2016 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 11 10 18:15:12.000"))
        XCTAssertEqual(DTTimePeriodRelationStartTouching, testTimePeriodStartSameEnd.relationToPeriod(self.controlTimePeriod), "%s Failed", file: #function)
        //Test after
        var testTimePeriodAfter: DTTimePeriod = DTTimePeriod(startDate: self.formatter.dateFromString("2016 12 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 12 10 18:15:12.000"))
        XCTAssertEqual(DTTimePeriodRelationAfter, testTimePeriodAfter.relationToPeriod(self.controlTimePeriod), "%s Failed", file: #function)
    }
    
    func testGapBetween() {
        //We are going to treat some of these as False=noGap and True=gap
        //No Gap Same
        XCTAssertFalse(self.controlTimePeriod.gapBetween(self.controlTimePeriod), "%s Failed", file: #function)
        //No Gap End Inside
        var testPeriodNoGap: DTTimePeriod = DTTimePeriod(startDate: self.controlTimePeriod.StartDate.dateBySubtractingDays(1), endDate: self.controlTimePeriod.EndDate.dateBySubtractingDays(1))
        XCTAssertFalse(self.controlTimePeriod.gapBetween(testPeriodNoGap), "%s Failed", file: #function)
        //Gap receiver early
        var testPeriodReceiverEarly: DTTimePeriod = DTTimePeriod(size: DTTimePeriodSizeWeek, startingAt: self.controlTimePeriod.EndDate.dateByAddingYears(1))
        XCTAssertTrue(self.controlTimePeriod.gapBetween(testPeriodReceiverEarly), "%s Failed", file: #function)
        //Gap parameter early
        var testPeriodParameterEarly: DTTimePeriod = DTTimePeriod(size: DTTimePeriodSizeWeek, endingAt: self.controlTimePeriod.StartDate.dateBySubtractingYears(1))
        XCTAssertTrue(self.controlTimePeriod.gapBetween(testPeriodParameterEarly), "%s Failed", file: #function)
        //Gap of 1 minute
        var testPeriodParameter1MinuteEarly: DTTimePeriod = DTTimePeriod(size: DTTimePeriodSizeSecond, endingAt: self.controlTimePeriod.StartDate.dateBySubtractingMinutes(1))
        XCTAssertEqual(60, self.controlTimePeriod.gapBetween(testPeriodParameter1MinuteEarly), "%s Failed", file: #function)
    }
    
    // MARK: - Date Relationships
    func testContaiDate() {
        var testDateBefore: Date = self.formatter!.date(from: "2014 10 05 18:15:12.000")!
        var testDateBetween: Date = self.formatter!.date(from: "2015 11 05 18:15:12.000")!
        var testDateAfter: Date = self.formatter!.date(from: "2016 12 05 18:15:12.000")!
        //Test before
        XCTAssertFalse(self.controlTimePeriod.contaiDate(testDateBefore, interval: DTTimePeriodIntervalOpen), "%s Failed", file: #function)
        XCTAssertFalse(self.controlTimePeriod.contaiDate(testDateBefore, interval: DTTimePeriodIntervalClosed), "%s Failed", file: #function)
        //Test on start date
        XCTAssertFalse(self.controlTimePeriod.contaiDate(self.controlTimePeriod.StartDate, interval: DTTimePeriodIntervalOpen), "%s Failed", file: #function)
        XCTAssertTrue(self.controlTimePeriod.contaiDate(self.controlTimePeriod.StartDate, interval: DTTimePeriodIntervalClosed), "%s Failed", file: #function)
        //Test in middle
        XCTAssertTrue(self.controlTimePeriod.contaiDate(testDateBetween, interval: DTTimePeriodIntervalClosed), "%s Failed", file: #function)
        XCTAssertTrue(self.controlTimePeriod.contaiDate(testDateBetween, interval: DTTimePeriodIntervalClosed), "%s Failed", file: #function)
        //Test on end date
        XCTAssertFalse(self.controlTimePeriod.contaiDate(self.controlTimePeriod.EndDate, interval: DTTimePeriodIntervalOpen), "%s Failed", file: #function)
        XCTAssertTrue(self.controlTimePeriod.contaiDate(self.controlTimePeriod.EndDate, interval: DTTimePeriodIntervalClosed), "%s Failed", file: #function)
        //Test after
        XCTAssertFalse(self.controlTimePeriod.contaiDate(testDateAfter, interval: DTTimePeriodIntervalOpen), "%s Failed", file: #function)
        XCTAssertFalse(self.controlTimePeriod.contaiDate(testDateAfter, interval: DTTimePeriodIntervalClosed), "%s Failed", file: #function)
    }
    
    // MARK: - Period Manipulation
    // MARK: Shift Earlier
    func testShiftSecondEarlier() {
        var startEarlierSecond: Date = self.formatter!.date(from: "2014 11 05 18:15:11.000")!
        var endEarlierSecond: Date = self.formatter!.date(from: "2016 11 05 18:15:11.000")!
        //Second time period
        var testPeriod: DTTimePeriod = DTTimePeriod(startDate: startEarlierSecond, endDate: endEarlierSecond)
        self.controlTimePeriod.shiftEarlierWithSize(DTTimePeriodSizeSecond)
        XCTAssertTrue(testPeriod.StartDate.isEqualToDate(self.controlTimePeriod.StartDate) && testPeriod.EndDate.isEqualToDate(self.controlTimePeriod.EndDate), "%s Failed", file: #function)
    }
    
    func testShiftMinuteEarlier() {
        var startEarlier: Date = self.formatter!.date(from: "2014 11 05 18:14:12.000")!
        var endEarlier: Date = self.formatter!.date(from: "2016 11 05 18:14:12.000")!
        var testPeriod: DTTimePeriod = DTTimePeriod(startDate: startEarlier, endDate: endEarlier)
        self.controlTimePeriod.shiftEarlierWithSize(DTTimePeriodSizeMinute)
        XCTAssertTrue(testPeriod.StartDate.isEqualToDate(self.controlTimePeriod.StartDate) && testPeriod.EndDate.isEqualToDate(self.controlTimePeriod.EndDate), "%s Failed", file: #function)
    }
    
    func testShiftHourEarlier() {
        var startEarlier: Date = self.formatter!.date(from: "2014 11 05 17:15:12.000")!
        var endEarlier: Date = self.formatter!.date(from: "2016 11 05 17:15:12.000")!
        var testPeriod: DTTimePeriod = DTTimePeriod(startDate: startEarlier, endDate: endEarlier)
        self.controlTimePeriod.shiftEarlierWithSize(DTTimePeriodSizeHour)
        XCTAssertTrue(testPeriod.StartDate.isEqualToDate(self.controlTimePeriod.StartDate) && testPeriod.EndDate.isEqualToDate(self.controlTimePeriod.EndDate), "%s Failed", file: #function)
    }
    
    func testShiftDayEarlier() {
        var startEarlier: Date = self.formatter!.date(from: "2014 11 04 18:15:12.000")!
        var endEarlier: Date = self.formatter!.date(from: "2016 11 04 18:15:12.000")!
        var testPeriod: DTTimePeriod = DTTimePeriod(startDate: startEarlier, endDate: endEarlier)
        self.controlTimePeriod.shiftEarlierWithSize(DTTimePeriodSizeDay)
        XCTAssertTrue(testPeriod.StartDate.isEqualToDate(self.controlTimePeriod.StartDate) && testPeriod.EndDate.isEqualToDate(self.controlTimePeriod.EndDate), "%s Failed", file: #function)
    }
    
    func testShiftWeekEarlier() {
        var startEarlier: Date = self.formatter!.date(from: "2014 10 29 18:15:12.000")!
        var endEarlier: Date = self.formatter!.date(from: "2016 10 29 18:15:12.000")!
        var testPeriod: DTTimePeriod = DTTimePeriod(startDate: startEarlier, endDate: endEarlier)
        self.controlTimePeriod.shiftEarlierWithSize(DTTimePeriodSizeWeek)
        XCTAssertTrue(testPeriod.StartDate.isEqualToDate(self.controlTimePeriod.StartDate) && testPeriod.EndDate.isEqualToDate(self.controlTimePeriod.EndDate), "%s Failed", file: #function)
    }
    
    func testShiftMonthEarlier() {
        var startEarlier: Date = self.formatter!.date(from: "2014 10 05 18:15:12.000")!
        var endEarlier: Date = self.formatter!.date(from: "2016 10 05 18:15:12.000")!
        var testPeriod: DTTimePeriod = DTTimePeriod(startDate: startEarlier, endDate: endEarlier)
        self.controlTimePeriod.shiftEarlierWithSize(DTTimePeriodSizeMonth)
        XCTAssertTrue(testPeriod.StartDate.isEqualToDate(self.controlTimePeriod.StartDate) && testPeriod.EndDate.isEqualToDate(self.controlTimePeriod.EndDate), "%s Failed", file: #function)
    }
    
    func testShiftYearEarlier() {
        var startEarlier: Date = self.formatter!.date(from: "2013 11 05 18:15:12.000")!
        var endEarlier: Date = self.formatter!.date(from: "2015 11 05 18:15:12.000")!
        var testPeriod: DTTimePeriod = DTTimePeriod(startDate: startEarlier, endDate: endEarlier)
        self.controlTimePeriod.shiftEarlierWithSize(DTTimePeriodSizeYear)
        XCTAssertTrue(testPeriod.StartDate.isEqualToDate(self.controlTimePeriod.StartDate) && testPeriod.EndDate.isEqualToDate(self.controlTimePeriod.EndDate), "%s Failed", file: #function)
    }
    
    // MARK: Shift Later
    func testShiftSecondLater() {
        var startLater: Date = self.formatter!.date(from: "2014 11 05 18:15:13.000")!
        var endLater: Date = self.formatter!.date(from: "2016 11 05 18:15:13.000")!
        //Second time period
        var testPeriod: DTTimePeriod = DTTimePeriod(startDate: startLater, endDate: endLater)
        self.controlTimePeriod.shiftLaterWithSize(DTTimePeriodSizeSecond)
        XCTAssertTrue(testPeriod.StartDate.isEqualToDate(self.controlTimePeriod.StartDate) && testPeriod.EndDate.isEqualToDate(self.controlTimePeriod.EndDate), "%s Failed", file: #function)
    }
    
    func testShiftMinuteLater() {
        var startLater: Date = self.formatter!.date(from: "2014 11 05 18:16:12.000")!
        var endLater: Date = self.formatter!.date(from: "2016 11 05 18:16:12.000")!
        var testPeriod: DTTimePeriod = DTTimePeriod(startDate: startLater, endDate: endLater)
        self.controlTimePeriod.shiftLaterWithSize(DTTimePeriodSizeMinute)
        XCTAssertTrue(testPeriod.StartDate.isEqualToDate(self.controlTimePeriod.StartDate) && testPeriod.EndDate.isEqualToDate(self.controlTimePeriod.EndDate), "%s Failed", file: #function)
    }
    
    func testShiftHourLater() {
        var startLater: Date = self.formatter!.date(from: "2014 11 05 19:15:12.000")!
        var endLater: Date = self.formatter!.date(from: "2016 11 05 19:15:12.000")!
        var testPeriod: DTTimePeriod = DTTimePeriod(startDate: startLater, endDate: endLater)
        self.controlTimePeriod.shiftLaterWithSize(DTTimePeriodSizeHour)
        XCTAssertTrue(testPeriod.StartDate.isEqualToDate(self.controlTimePeriod.StartDate) && testPeriod.EndDate.isEqualToDate(self.controlTimePeriod.EndDate), "%s Failed", file: #function)
    }
    
    func testShiftDayLater() {
        var startLater: Date = self.formatter!.date(from: "2014 11 06 18:15:12.000")!
        var endLater: Date = self.formatter!.date(from: "2016 11 06 18:15:12.000")!
        var testPeriod: DTTimePeriod = DTTimePeriod(startDate: startLater, endDate: endLater)
        self.controlTimePeriod.shiftLaterWithSize(DTTimePeriodSizeDay)
        XCTAssertTrue(testPeriod.StartDate.isEqualToDate(self.controlTimePeriod.StartDate) && testPeriod.EndDate.isEqualToDate(self.controlTimePeriod.EndDate), "%s Failed", file: #function)
    }
    
    func testShiftWeekLater() {
        var startLater: Date = self.formatter!.date(from: "2014 11 12 18:15:12.000")!
        var endLater: Date = self.formatter!.date(from: "2016 11 12 18:15:12.000")!
        var testPeriod: DTTimePeriod = DTTimePeriod(startDate: startLater, endDate: endLater)
        self.controlTimePeriod.shiftLaterWithSize(DTTimePeriodSizeWeek)
        XCTAssertTrue(testPeriod.StartDate.isEqualToDate(self.controlTimePeriod.StartDate) && testPeriod.EndDate.isEqualToDate(self.controlTimePeriod.EndDate), "%s Failed", file: #function)
    }
    
    func testShiftMonthLater() {
        var startLater: Date = self.formatter!.date(from: "2014 12 05 18:15:12.000")!
        var endLater: Date = self.formatter!.date(from: "2016 12 05 18:15:12.000")!
        var testPeriod: DTTimePeriod = DTTimePeriod(startDate: startLater, endDate: endLater)
        self.controlTimePeriod.shiftLaterWithSize(DTTimePeriodSizeMonth)
        XCTAssertTrue(testPeriod.StartDate.isEqualToDate(self.controlTimePeriod.StartDate) && testPeriod.EndDate.isEqualToDate(self.controlTimePeriod.EndDate), "%s Failed", file: #function)
    }
    
    func testShiftYearLater() {
        var startLater: Date = self.formatter!.date(from: "2015 11 05 18:15:12.000")!
        var endLater: Date = self.formatter!.date(from: "2017 11 05 18:15:12.000")!
        var testPeriod: DTTimePeriod = DTTimePeriod(startDate: startLater, endDate: endLater)
        self.controlTimePeriod.shiftLaterWithSize(DTTimePeriodSizeYear)
        XCTAssertTrue(testPeriod.StartDate.isEqualToDate(self.controlTimePeriod.StartDate) && testPeriod.EndDate.isEqualToDate(self.controlTimePeriod.EndDate), "%s Failed", file: #function)
    }
    
    // MARK: Lengthen / Shorten
    func testLengthenAnchorStart() {
        //Test dates
        var lengthenedEnd: Date = self.formatter!.date(from: "2016 11 05 18:15:14.000")!
        var testPeriod: DTTimePeriod = DTTimePeriod(startDate: self.controlTimePeriod.StartDate, endDate: lengthenedEnd)
        self.controlTimePeriod.lengthenWithAnchorDate(DTTimePeriodAnchorStart, size: DTTimePeriodSizeSecond, amount: 2)
        XCTAssertTrue(testPeriod.StartDate.isEqualToDate(self.controlTimePeriod.StartDate) && testPeriod.EndDate.isEqualToDate(self.controlTimePeriod.EndDate), "%s Failed", file: #function)
    }
    
    func testLengthenAnchorCenter() {
        //Test dates
        var lengthenedStart: Date = self.formatter!.date(from: "2014 11 05 18:15:11.000")!
        var lengthenedEnd: Date = self.formatter!.date(from: "2016 11 05 18:15:13.000")!
        var testPeriod: DTTimePeriod = DTTimePeriod(startDate: lengthenedStart, endDate: lengthenedEnd)
        self.controlTimePeriod.lengthenWithAnchorDate(DTTimePeriodAnchorCenter, size: DTTimePeriodSizeSecond, amount: 2)
        XCTAssertTrue(testPeriod.StartDate.isEqualToDate(self.controlTimePeriod.StartDate) && testPeriod.EndDate.isEqualToDate(self.controlTimePeriod.EndDate), "%s Failed", file: #function)
    }
    
    func testLengthenAnchorEnd() {
        //Test dates
        var lengthenedStart: Date = self.formatter!.date(from: "2014 11 05 18:15:10.000")!
        var testPeriod: DTTimePeriod = DTTimePeriod(startDate: lengthenedStart, endDate: self.controlTimePeriod.EndDate)
        self.controlTimePeriod.lengthenWithAnchorDate(DTTimePeriodAnchorEnd, size: DTTimePeriodSizeSecond, amount: 2)
        XCTAssertTrue(testPeriod.StartDate.isEqualToDate(self.controlTimePeriod.StartDate) && testPeriod.EndDate.isEqualToDate(self.controlTimePeriod.EndDate), "%s Failed", file: #function)
    }
    
    func testShortenAnchorStart() {
        //Test dates
        var shortenedEnd: Date = self.formatter!.date(from: "2016 11 05 18:15:10.000")!
        var testPeriod: DTTimePeriod = DTTimePeriod(startDate: self.controlTimePeriod.StartDate, endDate: shortenedEnd)
        self.controlTimePeriod.shortenWithAnchorDate(DTTimePeriodAnchorStart, size: DTTimePeriodSizeSecond, amount: 2)
        XCTAssertTrue(testPeriod.StartDate.isEqualToDate(self.controlTimePeriod.StartDate) && testPeriod.EndDate.isEqualToDate(self.controlTimePeriod.EndDate), "%s Failed", file: #function)
    }
    
    func testShortenAnchorCenter() {
        //Test dates
        var shortenedStart: Date = self.formatter!.date(from: "2014 11 05 18:15:13.000")!
        var shortenedEnd: Date = self.formatter!.date(from: "2016 11 05 18:15:11.000")!
        var testPeriod: DTTimePeriod = DTTimePeriod(startDate: shortenedStart, endDate: shortenedEnd)
        self.controlTimePeriod.shortenWithAnchorDate(DTTimePeriodAnchorCenter, size: DTTimePeriodSizeSecond, amount: 2)
        XCTAssertTrue(testPeriod.StartDate.isEqualToDate(self.controlTimePeriod.StartDate) && testPeriod.EndDate.isEqualToDate(self.controlTimePeriod.EndDate), "%s Failed", file: #function)
    }
    
    func testShortenAnchorEnd() {
        //Test dates
        var shortenedStart: Date = self.formatter!.date(from: "2014 11 05 18:15:14.000")!
        var testPeriod: DTTimePeriod = DTTimePeriod(startDate: shortenedStart, endDate: self.controlTimePeriod.EndDate)
        self.controlTimePeriod.shortenWithAnchorDate(DTTimePeriodAnchorEnd, size: DTTimePeriodSizeSecond, amount: 2)
        XCTAssertTrue(testPeriod.StartDate.isEqualToDate(self.controlTimePeriod.StartDate) && testPeriod.EndDate.isEqualToDate(self.controlTimePeriod.EndDate), "%s Failed", file: #function)
    }
    
}

