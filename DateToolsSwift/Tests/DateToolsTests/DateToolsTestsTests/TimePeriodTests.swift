//
//  TimePeriodTests.swift
//  DateToolsTests
//
//  Created by Grayson Webster on 8/19/16.
//  Copyright © 2016 Matthew York. All rights reserved.
//

import XCTest
@testable import DateToolsSwift

class TimePeriodTests : XCTestCase {
    
    var formatter = DateFormatter()
    var controlTimePeriod = TimePeriod()
    
    override func setUp() {
        self.formatter.dateFormat = "yyyy MM dd HH:mm:ss.SSS"
        self.formatter.timeZone = TimeZone(abbreviation: "UTC")
        self.controlTimePeriod.beginning = self.formatter.date(from: "2014 11 05 18:15:12.000")
        self.controlTimePeriod.end = self.formatter.date(from: "2016 11 05 18:15:12.000")
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    // MARK: - Inits
    
    func testInits() {
        //Basic init
        let testPeriodInit = TimePeriod(beginning: (self.controlTimePeriod.beginning)!, end: self.controlTimePeriod.end!)
        XCTAssertTrue(self.controlTimePeriod.equals(testPeriodInit) && self.controlTimePeriod.end!.equals(testPeriodInit.end!))
    }
    
    // **Add more init tests**
    
    
    //MARK: - Operator Overloads
    
    func testEqualsOperator() {
        let testPeriod = TimePeriod(beginning: self.controlTimePeriod.beginning!, end: self.controlTimePeriod.end!)
        XCTAssertTrue(testPeriod == self.controlTimePeriod)
    }
    
    func testAdditionOperator() {
        let testPeriod = TimePeriod(beginning: self.controlTimePeriod.beginning!, end: self.controlTimePeriod.end!) + 86400
        let endDate = self.formatter.date(from: "2016 11 06 18:15:12.000")
        
        XCTAssertTrue(controlTimePeriod.beginning! == self.controlTimePeriod.beginning! && endDate == testPeriod.end!)
    }
    
    func testAdditionOperatorChunk() {
        let testPeriod = controlTimePeriod + 1.days
        let endDate = self.formatter.date(from: "2016 11 06 19:15:12.000") //Includes DST change
  
        XCTAssertTrue(controlTimePeriod.beginning! == self.controlTimePeriod.beginning! && endDate == testPeriod.end!)
    }
    
    func testSubtractionOperator() {
        let testPeriod = controlTimePeriod - 86400
        let endDate = self.formatter.date(from: "2016 11 04 18:15:12.000")
        
        XCTAssertTrue(controlTimePeriod.beginning! == self.controlTimePeriod.beginning! && endDate == testPeriod.end!)
    }
    
    func testSubtractionOperatorChunk() {
        let testPeriod = controlTimePeriod - 1.days
        let endDate = self.formatter.date(from: "2016 11 04 18:15:12.000")
        
        XCTAssertTrue(controlTimePeriod.beginning! == self.controlTimePeriod.beginning! && endDate == testPeriod.end!)
    }
    
    // MARK: - Time Period Information
    
    func testIsMoment() {
        //Is moment
        let testPeriod = TimePeriod(beginning: self.controlTimePeriod.beginning!, end: self.controlTimePeriod.beginning!)
        XCTAssertTrue(testPeriod.isMoment)
        //Is not moment
        XCTAssertFalse(self.controlTimePeriod.isMoment)
    }
    
    func testDurationInYears() {
        XCTAssertEqual(2, self.controlTimePeriod.years)
    }
    
    func testDurationInWeeks() {
        XCTAssertEqual(104, self.controlTimePeriod.weeks)
    }
    
    func testDurationInDays() {
        XCTAssertEqual(731, self.controlTimePeriod.days)
    }
    
    func testDurationInHours() {
        let testPeriod = TimePeriod(beginning: self.controlTimePeriod.beginning!, end: self.controlTimePeriod.beginning!.add(4.hours))
        XCTAssertEqual(4, testPeriod.hours)
    }
    
    func testDurationInMinutes() {
        let testPeriod = TimePeriod(beginning: self.controlTimePeriod.beginning!, end: self.controlTimePeriod.beginning!.add(4.hours))
        XCTAssertEqual(240, testPeriod.minutes)
    }
    
    func testDurationInSeconds() {
        let testPeriod = TimePeriod(beginning: self.controlTimePeriod.beginning!, end: self.controlTimePeriod.beginning!.add(4.hours))
        XCTAssertEqual(14400, testPeriod.seconds)
    }
    
    
    // MARK: - Time Period Relationship
    
    func testEquals() {
        //Same
        XCTAssertTrue(self.controlTimePeriod.equals(self.controlTimePeriod))
        //Different ending
        let differentEndPeriod = TimePeriod(beginning: self.controlTimePeriod.beginning!, end: self.controlTimePeriod.end!.add(1.years))
        XCTAssertFalse(self.controlTimePeriod.equals(differentEndPeriod))
        //Different beginning
        let differentStartPeriod = TimePeriod (beginning: self.controlTimePeriod.beginning!.subtract(1.years), end: self.controlTimePeriod.end!)
        XCTAssertFalse(self.controlTimePeriod.equals(differentStartPeriod))
        //Both endings different
        let differentStartAndEndPeriod = TimePeriod(beginning: self.controlTimePeriod.beginning!.subtract(1.weeks), end: self.controlTimePeriod.end!.subtract(1.weeks))
        XCTAssertFalse(self.controlTimePeriod.equals(differentStartAndEndPeriod))
    }
    
    func testInside() {
        //POSITIVE MATCHES
        //Test exact match
        //Test exact match
        let testTimePeriodExact = TimePeriod(beginning: self.formatter.date(from: "2014 11 05 18:15:12.000")!, end: self.formatter.date(from: "2016 11 05 18:15:12.000")!)
        XCTAssertTrue(testTimePeriodExact.isInside(of: self.controlTimePeriod))
        //Test same start
        let testTimePeriodSameStart = TimePeriod(beginning: self.formatter.date(from: "2014 11 05 18:15:12.000")!, end: self.formatter.date(from: "2015 11 05 18:15:12.000")!)
        XCTAssertTrue(testTimePeriodSameStart.isInside(of: self.controlTimePeriod))
        //Test same end
        let testTimePeriodSameEnd = TimePeriod(beginning: self.formatter.date(from: "2015 12 05 18:15:12.000")!, end: self.formatter.date(from: "2016 11 05 18:15:12.000")!)
        XCTAssertTrue(testTimePeriodSameEnd.isInside(of: self.controlTimePeriod))
        //Test completely inside
        let testTimePeriodCompletelyInside = TimePeriod(beginning: self.formatter.date(from: "2015 12 05 18:15:12.000")!, end: self.formatter.date(from: "2016 04 05 18:15:12.000")!)
        XCTAssertTrue(testTimePeriodCompletelyInside.isInside(of: self.controlTimePeriod))
        //NEGATIVE MATCHES
        //Test before
        let testTimePeriodBefore = TimePeriod(beginning: self.formatter.date(from: "2014 11 02 18:15:12.000")!, end: self.formatter.date(from: "2014 11 04 18:15:12.000")!)
        XCTAssertFalse(testTimePeriodBefore.isInside(of: self.controlTimePeriod))
        //Test end same as start
        let testTimePeriodEndSameStart = TimePeriod(beginning: self.formatter.date(from: "2013 11 05 18:15:12.000")!, end: self.formatter.date(from: "2014 11 05 18:15:12.000")!)
        XCTAssertFalse(testTimePeriodEndSameStart.isInside(of: self.controlTimePeriod))
        //Test end inside
        let testTimePeriodEndInside = TimePeriod(beginning: self.formatter.date(from: "2014 11 02 18:15:12.000")!, end: self.formatter.date(from: "2014 11 07 18:15:12.000")!)
        XCTAssertFalse(testTimePeriodEndInside.isInside(of: self.controlTimePeriod))
        //Test start inside
        let testTimePeriodStartInside = TimePeriod(beginning: self.formatter.date(from: "2014 11 07 18:15:12.000")!, end: self.formatter.date(from: "2016 12 05 18:15:12.000")!)
        XCTAssertFalse(testTimePeriodStartInside.isInside(of: self.controlTimePeriod))
        //Test start same as end
        let testTimePeriodStartSameEnd = TimePeriod(beginning: self.formatter.date(from: "2016 11 05 18:15:12.000")!, end: self.formatter.date(from: "2016 11 10 18:15:12.000")!)
        XCTAssertFalse(testTimePeriodStartSameEnd.isInside(of: self.controlTimePeriod))
        //Test after
        let testTimePeriodAfter = TimePeriod(beginning: self.formatter.date(from: "2016 12 05 18:15:12.000")!, end: self.formatter.date(from: "2016 12 10 18:15:12.000")!)
        XCTAssertFalse(testTimePeriodAfter.isInside(of: self.controlTimePeriod))
    }
    
    func testContainsInterval() {
        //POSITIVE MATCHES
        //Test exact match
        let testTimePeriodExact = TimePeriod(beginning: self.formatter.date(from: "2014 11 05 18:15:12.000")!, end: self.formatter.date(from: "2016 11 05 18:15:12.000")!)
        XCTAssertTrue(self.controlTimePeriod.contains(testTimePeriodExact))
        //Test same start
        let testTimePeriodSameStart = TimePeriod(beginning: self.formatter.date(from: "2014 11 05 18:15:12.000")!, end: self.formatter.date(from: "2015 11 05 18:15:12.000")!)
        XCTAssertTrue(self.controlTimePeriod.contains(testTimePeriodSameStart))
        //Test same end
        let testTimePeriodSameEnd = TimePeriod(beginning: self.formatter.date(from: "2015 12 05 18:15:12.000")!, end: self.formatter.date(from: "2016 11 05 18:15:12.000")!)
        XCTAssertTrue(self.controlTimePeriod.contains(testTimePeriodSameEnd))
        //Test completely inside
        let testTimePeriodCompletelyInside = TimePeriod(beginning: self.formatter.date(from: "2015 12 05 18:15:12.000")!, end: self.formatter.date(from: "2016 04 05 18:15:12.000")!)
        XCTAssertTrue(self.controlTimePeriod.contains(testTimePeriodCompletelyInside))
        //NEGATIVE MATCHES
        //Test before
        let testTimePeriodBefore = TimePeriod(beginning: self.formatter.date(from: "2014 11 02 18:15:12.000")!, end: self.formatter.date(from: "2014 11 04 18:15:12.000")!)
        XCTAssertFalse(self.controlTimePeriod.contains(testTimePeriodBefore))
        //Test end same as start
        let testTimePeriodEndSameStart = TimePeriod(beginning: self.formatter.date(from: "2013 11 05 18:15:12.000")!, end: self.formatter.date(from: "2014 11 05 18:15:12.000")!)
        XCTAssertFalse(self.controlTimePeriod.contains(testTimePeriodEndSameStart))
        //Test end inside
        let testTimePeriodEndInside = TimePeriod(beginning: self.formatter.date(from: "2014 11 02 18:15:12.000")!, end: self.formatter.date(from: "2014 11 07 18:15:12.000")!)
        XCTAssertFalse(self.controlTimePeriod.contains(testTimePeriodEndInside))
        //Test start inside
        let testTimePeriodStartInside = TimePeriod(beginning: self.formatter.date(from: "2014 11 07 18:15:12.000")!, end: self.formatter.date(from: "2016 12 05 18:15:12.000")!)
        XCTAssertFalse(self.controlTimePeriod.contains(testTimePeriodStartInside))
        //Test start same as end
        let testTimePeriodStartSameEnd = TimePeriod(beginning: self.formatter.date(from: "2016 11 05 18:15:12.000")!, end: self.formatter.date(from: "2016 11 10 18:15:12.000")!)
        XCTAssertFalse(self.controlTimePeriod.contains(testTimePeriodStartSameEnd))
        //Test after
        let testTimePeriodAfter = TimePeriod(beginning: self.formatter.date(from: "2016 12 05 18:15:12.000")!, end: self.formatter.date(from: "2016 12 10 18:15:12.000")!)
        XCTAssertFalse(self.controlTimePeriod.contains(testTimePeriodAfter))
    }
    
    func testOverlaps() {
        //POSITIVE MATCHES
        //Test exact match
        let testTimePeriodExact = TimePeriod(beginning: self.formatter.date(from: "2014 11 05 18:15:12.000")!, end: self.formatter.date(from: "2016 11 05 18:15:12.000")!)
        XCTAssertTrue(self.controlTimePeriod.overlaps(with: testTimePeriodExact))
        //Test same start
        let testTimePeriodSameStart = TimePeriod(beginning: self.formatter.date(from: "2014 11 05 18:15:12.000")!, end: self.formatter.date(from: "2015 11 05 18:15:12.000")!)
        XCTAssertTrue(self.controlTimePeriod.overlaps(with: testTimePeriodSameStart))
        //Test same end
        let testTimePeriodSameEnd = TimePeriod(beginning: self.formatter.date(from: "2015 12 05 18:15:12.000")!, end: self.formatter.date(from: "2016 11 05 18:15:12.000")!)
        XCTAssertTrue(self.controlTimePeriod.overlaps(with: testTimePeriodSameEnd))
        //Test completely inside
        let testTimePeriodCompletelyInside = TimePeriod(beginning: self.formatter.date(from: "2015 12 05 18:15:12.000")!, end: self.formatter.date(from: "2016 04 05 18:15:12.000")!)
        XCTAssertTrue(self.controlTimePeriod.overlaps(with: testTimePeriodCompletelyInside))
        //Test start inside
        let testTimePeriodStartInside = TimePeriod(beginning: self.formatter.date(from: "2014 11 07 18:15:12.000")!, end: self.formatter.date(from: "2016 12 05 18:15:12.000")!)
        XCTAssertTrue(self.controlTimePeriod.overlaps(with: testTimePeriodStartInside))
        //Test end inside
        let testTimePeriodEndInside = TimePeriod(beginning: self.formatter.date(from: "2014 11 02 18:15:12.000")!, end: self.formatter.date(from: "2014 11 07 18:15:12.000")!)
        XCTAssertTrue(self.controlTimePeriod.overlaps(with: testTimePeriodEndInside))
        //NEGATIVE MATCHES
        //Test before
        let testTimePeriodBefore = TimePeriod(beginning: self.formatter.date(from: "2014 11 02 18:15:12.000")!, end: self.formatter.date(from: "2014 11 04 18:15:12.000")!)
        XCTAssertFalse(self.controlTimePeriod.overlaps(with: testTimePeriodBefore))
        //Test end same as start
        let testTimePeriodEndSameStart = TimePeriod(beginning: self.formatter.date(from: "2013 11 05 18:15:12.000")!, end: self.formatter.date(from: "2014 11 05 18:15:12.000")!)
        XCTAssertFalse(self.controlTimePeriod.overlaps(with: testTimePeriodEndSameStart))
        //Test start same as end
        let testTimePeriodStartSameEnd = TimePeriod(beginning: self.formatter.date(from: "2016 11 05 18:15:12.000")!, end: self.formatter.date(from: "2016 11 10 18:15:12.000")!)
        XCTAssertFalse(self.controlTimePeriod.overlaps(with: testTimePeriodStartSameEnd))
        //Test after
        let testTimePeriodAfter = TimePeriod(beginning: self.formatter.date(from: "2016 12 05 18:15:12.000")!, end: self.formatter.date(from: "2016 12 10 18:15:12.000")!)
        XCTAssertFalse(self.controlTimePeriod.overlaps(with: testTimePeriodAfter))
    }
    
    func testIntersects() {
        //POSITIVE MATCHES
        //Test exact match
        let testTimePeriodExact = TimePeriod(beginning: self.formatter.date(from: "2014 11 05 18:15:12.000")!, end: self.formatter.date(from: "2016 11 05 18:15:12.000")!)
        XCTAssertTrue(self.controlTimePeriod.intersects(with: testTimePeriodExact))
        //Test same start
        let testTimePeriodSameStart = TimePeriod(beginning: self.formatter.date(from: "2014 11 05 18:15:12.000")!, end: self.formatter.date(from: "2015 11 05 18:15:12.000")!)
        XCTAssertTrue(self.controlTimePeriod.intersects(with: testTimePeriodSameStart))
        //Test same end
        let testTimePeriodSameEnd = TimePeriod(beginning: self.formatter.date(from: "2015 12 05 18:15:12.000")!, end: self.formatter.date(from: "2016 11 05 18:15:12.000")!)
        XCTAssertTrue(self.controlTimePeriod.intersects(with: testTimePeriodSameEnd))
        //Test completely inside
        let testTimePeriodCompletelyInside = TimePeriod(beginning: self.formatter.date(from: "2015 12 05 18:15:12.000")!, end: self.formatter.date(from: "2016 04 05 18:15:12.000")!)
        XCTAssertTrue(self.controlTimePeriod.intersects(with: testTimePeriodCompletelyInside))
        //Test start inside
        let testTimePeriodStartInside = TimePeriod(beginning: self.formatter.date(from: "2014 11 07 18:15:12.000")!, end: self.formatter.date(from: "2016 12 05 18:15:12.000")!)
        XCTAssertTrue(self.controlTimePeriod.intersects(with: testTimePeriodStartInside))
        //Test end inside
        let testTimePeriodEndInside = TimePeriod(beginning: self.formatter.date(from: "2014 11 02 18:15:12.000")!, end: self.formatter.date(from: "2014 11 07 18:15:12.000")!)
        XCTAssertTrue(self.controlTimePeriod.intersects(with: testTimePeriodEndInside))
        //Test end same as start
        let testTimePeriodEndSameStart = TimePeriod(beginning: self.formatter.date(from: "2013 11 05 18:15:12.000")!, end: self.formatter.date(from: "2014 11 05 18:15:12.000")!)
        XCTAssertTrue(self.controlTimePeriod.intersects(with: testTimePeriodEndSameStart))
        //Test start same as end
        let testTimePeriodStartSameEnd = TimePeriod(beginning: self.formatter.date(from: "2016 11 05 18:15:12.000")!, end: self.formatter.date(from: "2016 11 10 18:15:12.000")!)
        XCTAssertTrue(self.controlTimePeriod.intersects(with: testTimePeriodStartSameEnd))
        //NEGATIVE MATCHES
        //Test before
        let testTimePeriodBefore = TimePeriod(beginning: self.formatter.date(from: "2014 11 02 18:15:12.000")!, end: self.formatter.date(from: "2014 11 04 18:15:12.000")!)
        XCTAssertFalse(self.controlTimePeriod.intersects(with: testTimePeriodBefore))
        //Test after
        let testTimePeriodAfter = TimePeriod(beginning: self.formatter.date(from: "2016 12 05 18:15:12.000")!, end: self.formatter.date(from: "2016 12 10 18:15:12.000")!)
        XCTAssertFalse(self.controlTimePeriod.intersects(with: testTimePeriodAfter))
    }
    
    func testRelation() {
        //Test exact match
        let testTimePeriodExact = TimePeriod(beginning: self.formatter.date(from: "2014 11 05 18:15:12.000")!, end: self.formatter.date(from: "2016 11 05 18:15:12.000")!)
        XCTAssertEqual(Relation.exactMatch, testTimePeriodExact.relation(to: self.controlTimePeriod))
        //Test same start
        let testTimePeriodSameStart = TimePeriod(beginning: self.formatter.date(from: "2014 11 05 18:15:12.000")!, end: self.formatter.date(from: "2015 11 05 18:15:12.000")!)
        XCTAssertEqual(Relation.insideStartTouching, testTimePeriodSameStart.relation(to: self.controlTimePeriod))
        //Test same end
        let testTimePeriodSameEnd = TimePeriod(beginning: self.formatter.date(from: "2015 12 05 18:15:12.000")!, end: self.formatter.date(from: "2016 11 05 18:15:12.000")!)
        XCTAssertEqual(Relation.insideEndTouching, testTimePeriodSameEnd.relation(to: self.controlTimePeriod))
        //Test completely inside
        let testTimePeriodCompletelyInside = TimePeriod(beginning: self.formatter.date(from: "2015 12 05 18:15:12.000")!, end: self.formatter.date(from: "2016 04 05 18:15:12.000")!)
        XCTAssertEqual(Relation.inside, testTimePeriodCompletelyInside.relation(to: self.controlTimePeriod))
        //NEGATIVE MATCHES
        //Test before
        let testTimePeriodBefore = TimePeriod(beginning: self.formatter.date(from: "2014 11 02 18:15:12.000")!, end: self.formatter.date(from: "2014 11 04 18:15:12.000")!)
        XCTAssertEqual(Relation.before, testTimePeriodBefore.relation(to: self.controlTimePeriod))
        //Test end same as start
        let testTimePeriodEndSameStart = TimePeriod(beginning: self.formatter.date(from: "2013 11 05 18:15:12.000")!, end: self.formatter.date(from: "2014 11 05 18:15:12.000")!)
        XCTAssertEqual(Relation.endTouching, testTimePeriodEndSameStart.relation(to: self.controlTimePeriod))
        //Test end inside
        let testTimePeriodEndInside = TimePeriod(beginning: self.formatter.date(from: "2014 11 02 18:15:12.000")!, end: self.formatter.date(from: "2014 11 07 18:15:12.000")!)
        XCTAssertEqual(Relation.endInside, testTimePeriodEndInside.relation(to: self.controlTimePeriod))
        //Test start inside
        let testTimePeriodStartInside = TimePeriod(beginning: self.formatter.date(from: "2014 11 07 18:15:12.000")!, end: self.formatter.date(from: "2016 12 05 18:15:12.000")!)
        XCTAssertEqual(Relation.startInside, testTimePeriodStartInside.relation(to: self.controlTimePeriod))
        //Test start same as end
        let testTimePeriodStartSameEnd = TimePeriod(beginning: self.formatter.date(from: "2016 11 05 18:15:12.000")!, end: self.formatter.date(from: "2016 11 10 18:15:12.000")!)
        XCTAssertEqual(Relation.startTouching, testTimePeriodStartSameEnd.relation(to: self.controlTimePeriod))
        //Test after
        let testTimePeriodAfter = TimePeriod(beginning: self.formatter.date(from: "2016 12 05 18:15:12.000")!, end: self.formatter.date(from: "2016 12 10 18:15:12.000")!)
        XCTAssertEqual(Relation.after, testTimePeriodAfter.relation(to: self.controlTimePeriod))
    }
    
    func testHasGap() {
        //We are going to treat some of these as False=noGap and True=gap
        //No Gap Same
        XCTAssertFalse(self.controlTimePeriod.hasGap(between: self.controlTimePeriod))
        //No Gap End Inside
        let testPeriodNoGap = TimePeriod(beginning: self.controlTimePeriod.beginning! - 1.days, end: self.controlTimePeriod.end!.subtract(1.days))
        XCTAssertFalse(self.controlTimePeriod.hasGap(between: testPeriodNoGap))
        //Gap receiver early
        let testPeriodReceiverEarly = TimePeriod(beginning: self.controlTimePeriod.end!.add(1.years), chunk: 1.weeks)
        XCTAssertTrue(self.controlTimePeriod.hasGap(between: testPeriodReceiverEarly))
        //Gap parameter early
        let testPeriodParameterEarly = TimePeriod(end: self.controlTimePeriod.beginning! - 1.years, chunk: 1.weeks)
        XCTAssertTrue(self.controlTimePeriod.hasGap(between: testPeriodParameterEarly))
    }
    
    func testGap() {
        //Gap of 1 minute
        let testPeriodParameter1MinuteEarly = TimePeriod(end: self.controlTimePeriod.beginning! - 1.minutes, chunk: 1.seconds)
        XCTAssertEqual(60, self.controlTimePeriod.gap(between: testPeriodParameter1MinuteEarly))
    }
    
    
    // MARK: - Date Relationships
    
    func testContainsDate() {
        let testDateBefore = self.formatter.date(from: "2014 10 05 18:15:12.000")!
        let testDateBetween = self.formatter.date(from: "2015 11 05 18:15:12.000")!
        let testDateAfter = self.formatter.date(from: "2016 12 05 18:15:12.000")!
        // Test before
        XCTAssertFalse(self.controlTimePeriod.contains(testDateBefore, interval: Interval.open))
        XCTAssertFalse(self.controlTimePeriod.contains(testDateBefore, interval: Interval.closed))
        // Test on start date
        XCTAssertFalse(self.controlTimePeriod.contains(self.controlTimePeriod.beginning!, interval: Interval.open))
        XCTAssertTrue(self.controlTimePeriod.contains(self.controlTimePeriod.beginning!, interval: Interval.closed))
        // Test in middle
        XCTAssertTrue(self.controlTimePeriod.contains(testDateBetween, interval: Interval.closed))
        XCTAssertTrue(self.controlTimePeriod.contains(testDateBetween, interval: Interval.closed))
        // Test on end date
        XCTAssertFalse(self.controlTimePeriod.contains(self.controlTimePeriod.end!, interval: Interval.open))
        XCTAssertTrue(self.controlTimePeriod.contains(self.controlTimePeriod.end!, interval: Interval.closed))
        // Test after
        XCTAssertFalse(self.controlTimePeriod.contains(testDateAfter, interval: Interval.open))
        XCTAssertFalse(self.controlTimePeriod.contains(testDateAfter, interval: Interval.closed))
    }
    
    
    // MARK: - Period Manipulation
    // MARK: Shift Earlier by Time Interval
    
    func testShiftSecondEarlierInterval() {
        let startEarlierSecond = self.formatter.date(from: "2014 11 05 18:15:11.000")!
        let endEarlierSecond = self.formatter.date(from: "2016 11 05 18:15:11.000")!
        //Second time period
        let testPeriod = TimePeriod(beginning: startEarlierSecond, end: endEarlierSecond)
        self.controlTimePeriod.shift(by: -1)
        XCTAssertTrue(testPeriod == self.controlTimePeriod)
    }
    
    func testShiftMinuteEarlierInterval() {
        let startEarlier = self.formatter.date(from: "2014 11 05 18:14:12.000")!
        let endEarlier = self.formatter.date(from: "2016 11 05 18:14:12.000")!
        let testPeriod = TimePeriod(beginning: startEarlier, end: endEarlier)
        self.controlTimePeriod.shift(by: -Constants.SecondsInMinute)
        XCTAssertTrue(testPeriod == self.controlTimePeriod)
    }
    
    func testShiftHourEarlierInterval() {
        let startEarlier = self.formatter.date(from: "2014 11 05 17:15:12.000")!
        let endEarlier = self.formatter.date(from: "2016 11 05 17:15:12.000")!
        let testPeriod = TimePeriod(beginning: startEarlier, end: endEarlier)
        self.controlTimePeriod.shift(by: -Constants.SecondsInHour)
        XCTAssertTrue(testPeriod == self.controlTimePeriod)
    }
    
    func testShiftDayEarlierInterval() {
        let startEarlier = self.formatter.date(from: "2014 11 04 18:15:12.000")!
        let endEarlier = self.formatter.date(from: "2016 11 04 18:15:12.000")!
        let testPeriod = TimePeriod(beginning: startEarlier, end: endEarlier)
        self.controlTimePeriod.shift(by: -Constants.SecondsInDay)
        XCTAssertTrue(testPeriod == self.controlTimePeriod)
    }
    
    func testShiftWeekEarlierInterval() {
        let startEarlier = self.formatter.date(from: "2014 10 29 18:15:12.000")!
        let endEarlier = self.formatter.date(from: "2016 10 29 18:15:12.000")!
        let testPeriod = TimePeriod(beginning: startEarlier, end: endEarlier)
        self.controlTimePeriod.shift(by: -Constants.SecondsInWeek)
        XCTAssertTrue(testPeriod == self.controlTimePeriod)
    }
    
    func testShiftMonthEarlierInterval() {
        let startEarlier = self.formatter.date(from: "2014 10 05 18:15:12.000")!
        let endEarlier = self.formatter.date(from: "2016 10 05 18:15:12.000")!
        let testPeriod = TimePeriod(beginning: startEarlier, end: endEarlier)
        self.controlTimePeriod.shift(by: -Constants.SecondsInMonth31)
        XCTAssertTrue(testPeriod == self.controlTimePeriod)
    }
    
    func testShiftYearEarlierInterval() {
        let startEarlier = self.formatter.date(from: "2013 11 04 18:15:12.000")!
        let endEarlier = self.formatter.date(from: "2015 11 05 18:15:12.000")!
        let testPeriod = TimePeriod(beginning: startEarlier, end: endEarlier)
        self.controlTimePeriod.shift(by: -Constants.SecondsInLeapYear) // note: a leap year is subtracted from both beginning and end
        XCTAssertTrue(testPeriod == self.controlTimePeriod)
    }
    
    // MARK: Shift Earlier by Time Chunk
    
    func testShiftSecondEarlierChunk() {
        let startEarlierSecond = self.formatter.date(from: "2014 11 05 18:15:11.000")!
        let endEarlierSecond = self.formatter.date(from: "2016 11 05 18:15:11.000")!
        //Second time period
        let testPeriod = TimePeriod(beginning: startEarlierSecond, end: endEarlierSecond)
        self.controlTimePeriod.shift(by: -1.seconds)
        XCTAssertTrue(testPeriod == self.controlTimePeriod)
    }
    
    func testShiftMinuteEarlierChunk() {
        let startEarlier = self.formatter.date(from: "2014 11 05 18:14:12.000")!
        let endEarlier = self.formatter.date(from: "2016 11 05 18:14:12.000")!
        let testPeriod = TimePeriod(beginning: startEarlier, end: endEarlier)
        self.controlTimePeriod.shift(by: -1.minutes)
        XCTAssertTrue(testPeriod == self.controlTimePeriod)
    }
    
    func testShiftHourEarlierChunk() {
        let startEarlier = self.formatter.date(from: "2014 11 05 17:15:12.000")!
        let endEarlier = self.formatter.date(from: "2016 11 05 17:15:12.000")!
        let testPeriod = TimePeriod(beginning: startEarlier, end: endEarlier)
        self.controlTimePeriod.shift(by: -1.hours)
        XCTAssertTrue(testPeriod == self.controlTimePeriod)
    }
    
    func testShiftDayEarlierChunk() {
        let startEarlier = self.formatter.date(from: "2014 11 04 18:15:12.000")!
        let endEarlier = self.formatter.date(from: "2016 11 04 18:15:12.000")!
        let testPeriod = TimePeriod(beginning: startEarlier, end: endEarlier)
        self.controlTimePeriod.shift(by: -1.days)
        XCTAssertTrue(testPeriod == self.controlTimePeriod)
    }
    
    func testShiftWeekEarlierChunk() {
        let startEarlier = self.formatter.date(from: "2014 10 29 17:15:12.000")!
        let endEarlier = self.formatter.date(from: "2016 10 29 18:15:12.000")!
        let testPeriod = TimePeriod(beginning: startEarlier, end: endEarlier)
        self.controlTimePeriod.shift(by: -1.weeks)
        XCTAssertTrue(testPeriod == self.controlTimePeriod)
    }
    
    func testShiftMonthEarlierChunk() {
        let startEarlier = self.formatter.date(from: "2014 10 05 17:15:12.000")!
        let endEarlier = self.formatter.date(from: "2016 10 05 18:15:12.000")!
        let testPeriod = TimePeriod(beginning: startEarlier, end: endEarlier)
        self.controlTimePeriod.shift(by: -1.months)
        XCTAssertTrue(testPeriod == controlTimePeriod)
    }
    
    func testShiftYearEarlierChunk() {
        let startEarlier = self.formatter.date(from: "2013 11 05 18:15:12.000")!
        let endEarlier = self.formatter.date(from: "2015 11 05 19:15:12.000")!
        let testPeriod = TimePeriod(beginning: startEarlier, end: endEarlier)
        self.controlTimePeriod.shift(by: -1.years)
        XCTAssertTrue(testPeriod == self.controlTimePeriod)
    }
    
    
    // MARK: Shift Later by Interval
    
    func testShiftSecondLaterInterval() {
        let startLater = self.formatter.date(from: "2014 11 05 18:15:13.000")!
        let endLater = self.formatter.date(from: "2016 11 05 18:15:13.000")!
        let testPeriod = TimePeriod(beginning: startLater, end: endLater)
        self.controlTimePeriod.shift(by: 1)
        XCTAssertTrue(testPeriod == self.controlTimePeriod)
    }
    
    func testShiftMinuteLaterInterval() {
        let startLater = self.formatter.date(from: "2014 11 05 18:16:12.000")!
        let endLater = self.formatter.date(from: "2016 11 05 18:16:12.000")!
        let testPeriod = TimePeriod(beginning: startLater, end: endLater)
        self.controlTimePeriod.shift(by: Constants.SecondsInMinute)
        XCTAssertTrue(testPeriod == self.controlTimePeriod)
    }
    
    func testShiftHourLaterInterval() {
        let startLater = self.formatter.date(from: "2014 11 05 19:15:12.000")!
        let endLater = self.formatter.date(from: "2016 11 05 19:15:12.000")!
        let testPeriod = TimePeriod(beginning: startLater, end: endLater)
        self.controlTimePeriod.shift(by: Constants.SecondsInHour)
        XCTAssertTrue(testPeriod == self.controlTimePeriod)
    }
    
    func testShiftDayLaterInterval() {
        let startLater = self.formatter.date(from: "2014 11 06 18:15:12.000")!
        let endLater = self.formatter.date(from: "2016 11 06 18:15:12.000")!
        let testPeriod = TimePeriod(beginning: startLater, end: endLater)
        self.controlTimePeriod.shift(by: Constants.SecondsInDay) //Will not take into account daylight savings
        XCTAssertTrue(testPeriod == self.controlTimePeriod)
    }
    
    func testShiftWeekLaterInterval() {
        let startLater = self.formatter.date(from: "2014 11 12 18:15:12.000")!
        let endLater = self.formatter.date(from: "2016 11 12 18:15:12.000")!
        let testPeriod = TimePeriod(beginning: startLater, end: endLater)
        self.controlTimePeriod.shift(by: Constants.SecondsInWeek) //Will not take into account daylight savings
        XCTAssertTrue(testPeriod == self.controlTimePeriod)
    }
    
    func testShiftMonthLaterInterval() {
        let startLater = self.formatter.date(from: "2014 12 05 18:15:12.000")!
        let endLater = self.formatter.date(from: "2016 12 05 18:15:12.000")!
        let testPeriod = TimePeriod(beginning: startLater, end: endLater)
        self.controlTimePeriod.shift(by: Constants.SecondsInMonth30) //Will not take into account daylight savings
        XCTAssertTrue(testPeriod == self.controlTimePeriod)
    }
    
    func testShiftYearLaterInterval() {
        let startLater = self.formatter.date(from: "2015 11 05 18:15:12.000")!
        let endLater = self.formatter.date(from: "2017 11 05 18:15:12.000")!
        let testPeriod = TimePeriod(beginning: startLater, end: endLater)
        self.controlTimePeriod.shift(by: Constants.SecondsInYear) //Will not take into account daylight savings or leap year
        XCTAssertTrue(testPeriod == self.controlTimePeriod)
    }
    
    // MARK: Shift Later by Chunk
    
    func testShiftSecondLaterChunk() {
        let startLater = self.formatter.date(from: "2014 11 05 18:15:13.000")!
        let endLater = self.formatter.date(from: "2016 11 05 18:15:13.000")!
        //Second time period
        let testPeriod = TimePeriod(beginning: startLater, end: endLater)
        self.controlTimePeriod.shift(by: 1.seconds)
        XCTAssertTrue(testPeriod == self.controlTimePeriod)
    }
    
    func testShiftMinuteLaterChunk() {
        let startLater = self.formatter.date(from: "2014 11 05 18:16:12.000")!
        let endLater = self.formatter.date(from: "2016 11 05 18:16:12.000")!
        let testPeriod = TimePeriod(beginning: startLater, end: endLater)
        self.controlTimePeriod.shift(by: 1.minutes)
        XCTAssertTrue(testPeriod == self.controlTimePeriod)
    }
    
    func testShiftHourLaterChunk() {
        let startLater = self.formatter.date(from: "2014 11 05 19:15:12.000")!
        let endLater = self.formatter.date(from: "2016 11 05 19:15:12.000")!
        let testPeriod = TimePeriod(beginning: startLater, end: endLater)
        self.controlTimePeriod.shift(by: 1.hours)
        XCTAssertTrue(testPeriod == self.controlTimePeriod)
    }
    
    func testShiftDayLaterChunk() {
        let startLater = self.formatter.date(from: "2014 11 06 18:15:12.000")!
        let endLater = self.formatter.date(from: "2016 11 06 19:15:12.000")!
        let testPeriod = TimePeriod(beginning: startLater, end: endLater)
        self.controlTimePeriod.shift(by: 1.days)
        XCTAssertTrue(testPeriod == self.controlTimePeriod)
    }
    
    func testShiftWeekLaterChunk() {
        let startLater = self.formatter.date(from: "2014 11 12 18:15:12.000")!
        let endLater = self.formatter.date(from: "2016 11 12 19:15:12.000")!
        let testPeriod = TimePeriod(beginning: startLater, end: endLater)
        self.controlTimePeriod.shift(by: 1.weeks)
        XCTAssertTrue(testPeriod == self.controlTimePeriod)
    }
    
    func testShiftMonthLaterChunk() {
        let startLater = self.formatter.date(from: "2014 12 05 18:15:12.000")!
        let endLater = self.formatter.date(from: "2016 12 05 19:15:12.000")!
        let testPeriod = TimePeriod(beginning: startLater, end: endLater)
        self.controlTimePeriod.shift(by: 1.months)
        XCTAssertTrue(testPeriod == self.controlTimePeriod)
    }
    
    func testShiftYearLaterChunk() {
        let startLater = self.formatter.date(from: "2015 11 05 18:15:12.000")!
        let endLater = self.formatter.date(from: "2017 11 05 19:15:12.000")!
        let testPeriod = TimePeriod(beginning: startLater, end: endLater)
        self.controlTimePeriod.shift(by: 1.years)
        XCTAssertTrue(testPeriod == self.controlTimePeriod)
    }
    
    
    // MARK: Lengthen / Shorten by Interval
    
    func testLengthenAnchorBeginningInterval() {
        //Test dates
        let lengthenedEnd = self.formatter.date(from: "2016 11 05 18:15:14.000")!
        let testPeriod = TimePeriod(beginning: self.controlTimePeriod.beginning!, end: lengthenedEnd)
        self.controlTimePeriod.lengthen(by: 2, at: Anchor.beginning)
        XCTAssertTrue(testPeriod == self.controlTimePeriod)
    }
    
    func testLengthenAnchorCenterInterval() {
        //Test dates
        let lengthenedStart = self.formatter.date(from: "2014 11 05 18:15:11.000")!
        let lengthenedEnd = self.formatter.date(from: "2016 11 05 18:15:13.000")!
        let testPeriod = TimePeriod(beginning: lengthenedStart, end: lengthenedEnd)
        self.controlTimePeriod.lengthen(by: 2, at: Anchor.center)
        XCTAssertTrue(testPeriod == self.controlTimePeriod)
    }
    
    func testLengthenAnchorEndInterval() {
        //Test dates
        let lengthenedStart = self.formatter.date(from: "2014 11 05 18:15:10.000")!
        let testPeriod = TimePeriod(beginning: lengthenedStart, end: self.controlTimePeriod.end!)
        self.controlTimePeriod.lengthen(by: 2, at: Anchor.end)
        XCTAssertTrue(testPeriod == self.controlTimePeriod)
    }
    
    func testShortenAnchorStartInterval() {
        //Test dates
        let shortenedEnd = self.formatter.date(from: "2016 11 05 18:15:10.000")!
        let testPeriod = TimePeriod(beginning: self.controlTimePeriod.beginning!, end: shortenedEnd)
        self.controlTimePeriod.shorten(by: 2, at: Anchor.beginning)
        XCTAssertTrue(testPeriod == self.controlTimePeriod)
    }
    
    func testShortenAnchorCenterInterval() {
        //Test dates
        let shortenedStart = self.formatter.date(from: "2014 11 05 18:15:13.000")!
        let shortenedEnd = self.formatter.date(from: "2016 11 05 18:15:11.000")!
        let testPeriod = TimePeriod(beginning: shortenedStart, end: shortenedEnd)
        self.controlTimePeriod.shorten(by: 2, at: Anchor.center)
        XCTAssertTrue(testPeriod == self.controlTimePeriod)
    }
    
    func testShortenAnchorEndInterval() {
        //Test dates
        let shortenedStart = self.formatter.date(from: "2014 11 05 18:15:14.000")!
        let testPeriod = TimePeriod(beginning: shortenedStart, end: self.controlTimePeriod.end!)
        self.controlTimePeriod.shorten(by: 2, at: Anchor.end)
        XCTAssertTrue(testPeriod == self.controlTimePeriod)
    }
    
    
    // MARK: Lengthen / Shorten by Chunk
    
    func testLengthenAnchorBeginningChunk() {
        //Test dates
        let lengthenedEnd = self.formatter.date(from: "2016 11 05 18:15:14.000")!
        let testPeriod = TimePeriod(beginning: self.controlTimePeriod.beginning!, end: lengthenedEnd)
        self.controlTimePeriod.lengthen(by: 2.seconds, at: Anchor.beginning)
        XCTAssertTrue(testPeriod == self.controlTimePeriod)
    }
    
    func testLengthenAnchorEndChunk() {
        //Test dates
        let lengthenedStart = self.formatter.date(from: "2014 11 05 18:15:10.000")!
        let testPeriod = TimePeriod(beginning: lengthenedStart, end: self.controlTimePeriod.end!)
        self.controlTimePeriod.lengthen(by: 2.seconds, at: Anchor.end)
        XCTAssertTrue(testPeriod == self.controlTimePeriod)
    }
    
    func testShortenAnchorStartChunk() {
        //Test dates
        let shortenedEnd = self.formatter.date(from: "2016 11 05 18:15:10.000")!
        let testPeriod = TimePeriod(beginning: self.controlTimePeriod.beginning!, end: shortenedEnd)
        self.controlTimePeriod.shorten(by: 2.seconds, at: Anchor.beginning)
        XCTAssertTrue(testPeriod == self.controlTimePeriod)
    }
    
    func testShortenAnchorEndChunk() {
        //Test dates
        let shortenedStart = self.formatter.date(from: "2014 11 05 18:15:14.000")!
        let testPeriod = TimePeriod(beginning: shortenedStart, end: self.controlTimePeriod.end!)
        self.controlTimePeriod.shorten(by: 2.seconds, at: Anchor.end)
        XCTAssertTrue(testPeriod == self.controlTimePeriod)
    }
    
    
}
