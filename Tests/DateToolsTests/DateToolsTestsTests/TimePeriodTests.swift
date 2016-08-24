//
//  TimePeriodTests.swift
//  DateToolsTests
//
//  Created by Grayson Webster on 8/19/16.
//  Copyright © 2016 Matthew York. All rights reserved.
//

import XCTest
@testable import DateToolsTests

class TimePeriodTests : XCTestCase {
    
    var formatter = DateFormatter()
    var controlTimePeriod = TimePeriod()
    
    override func setUp() {
        // ut setup code here. This method is called before the invocation of each test method in the class.
        //Create TimePeriod that is 2 years long
        self.formatter.dateFormat = "yyyy MM dd HH:mm:ss.SSS"
        self.controlTimePeriod.beginning = self.formatter.date(from: "2014 11 05 18:15:12.000")
        self.controlTimePeriod.end = self.formatter.date(from: "2016 11 05 18:15:12.000")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    // MARK: - Custom Init / Factory Methods
    func testBasicInitsAndFactoryMethods() {
        //Basic init
        // THIS SHOULD BE FAILING
        // FILL OUT INIT
        let testPeriodInit = TimePeriod(beginning: (self.controlTimePeriod.beginning)!, end: self.controlTimePeriod.end!)
        XCTAssertTrue(self.controlTimePeriod.equals(period: testPeriodInit) && self.controlTimePeriod.end!.equals(testPeriodInit.end!), "%s Failed", file: #function)
    }
    
    
    // MARK: - Time Period Information
    
    func testIsMoment() {
        //Is moment
        let testPeriod: TimePeriod = TimePeriod(beginning: self.controlTimePeriod.beginning!, end: self.controlTimePeriod.beginning!)
        XCTAssertTrue(testPeriod.isMoment(), "%s Failed", file: #function)
        //Is not moment
        XCTAssertFalse(self.controlTimePeriod.isMoment(), "%s Failed", file: #function)
    }
    
    func testDurationInYears() {
        XCTAssertEqual(2, self.controlTimePeriod.years, "%s Failed", file: #function)
    }
    
    func testDurationInWeeks() {
        XCTAssertEqual(104, self.controlTimePeriod.weeks, "%s Failed", file: #function)
    }
    
    func testDurationInDays() {
        XCTAssertEqual(731, self.controlTimePeriod.days, "%s Failed", file: #function)
    }
    
    func testDurationInHours() {
        let testPeriod = TimePeriod(beginning: self.controlTimePeriod.beginning!, end: self.controlTimePeriod.beginning!.add(4.hours))
        XCTAssertEqual(4, testPeriod.hours, "%s Failed", file: #function)
    }
    
    func testDurationInMinutes() {
        let testPeriod = TimePeriod(beginning: self.controlTimePeriod.beginning!, end: self.controlTimePeriod.beginning!.add(4.hours))
        XCTAssertEqual(240, testPeriod.minutes, "%s Failed", file: #function)
    }
    
    func testDurationInSeconds() {
        let testPeriod: TimePeriod = TimePeriod(beginning: self.controlTimePeriod.beginning!, end: self.controlTimePeriod.beginning!.add(4.hours))
        XCTAssertEqual(14400, testPeriod.seconds, "%s Failed", file: #function)
    }
    
    
    // MARK: - Time Period Relationship
    
    func testEquals() {
        //Same
        XCTAssertTrue(self.controlTimePeriod.equals(period: self.controlTimePeriod), "%s Failed", file: #function)
        //Different ending
        let differentEndPeriod = TimePeriod(beginning: self.controlTimePeriod.beginning!, end: self.controlTimePeriod.end!.add(1.years))
        XCTAssertFalse(self.controlTimePeriod.equals(period: differentEndPeriod), "%s Failed", file: #function)
        //Different beginning
        let differentStartPeriod = TimePeriod (beginning: self.controlTimePeriod.beginning!.subtract(1.years), end: self.controlTimePeriod.end!)
        XCTAssertFalse(self.controlTimePeriod.equals(period: differentStartPeriod), "%s Failed", file: #function)
        //Both endings different
        let differentStartAndEndPeriod = TimePeriod(beginning: self.controlTimePeriod.beginning!.subtract(1.weeks), end: self.controlTimePeriod.end!.subtract(1.weeks))
        XCTAssertFalse(self.controlTimePeriod.equals(period: differentStartAndEndPeriod), "%s Failed", file: #function)
    }
    
    func testInside() {
        //POSITIVE MATCHES
        //Test exact match
        //Test exact match
        let testTimePeriodExact = TimePeriod(beginning: self.formatter.date(from: "2014 11 05 18:15:12.000")!, end: self.formatter.date(from: "2016 11 05 18:15:12.000")!)
        XCTAssertTrue(testTimePeriodExact.inside(of: self.controlTimePeriod), "%s Failed", file: #function)
        //Test same start
        let testTimePeriodSameStart = TimePeriod(beginning: self.formatter.date(from: "2014 11 05 18:15:12.000")!, end: self.formatter.date(from: "2015 11 05 18:15:12.000")!)
        XCTAssertTrue(testTimePeriodSameStart.inside(of: self.controlTimePeriod), "%s Failed", file: #function)
        //Test same end
        let testTimePeriodSameEnd = TimePeriod(beginning: self.formatter.date(from: "2015 12 05 18:15:12.000")!, end: self.formatter.date(from: "2016 11 05 18:15:12.000")!)
        XCTAssertTrue(testTimePeriodSameEnd.inside(of: self.controlTimePeriod), "%s Failed", file: #function)
        //Test completely inside
        let testTimePeriodCompletelyInside = TimePeriod(beginning: self.formatter.date(from: "2015 12 05 18:15:12.000")!, end: self.formatter.date(from: "2016 04 05 18:15:12.000")!)
        XCTAssertTrue(testTimePeriodCompletelyInside.inside(of: self.controlTimePeriod), "%s Failed", file: #function)
        //NEGATIVE MATCHES
        //Test before
        let testTimePeriodBefore = TimePeriod(beginning: self.formatter.date(from: "2014 11 02 18:15:12.000")!, end: self.formatter.date(from: "2014 11 04 18:15:12.000")!)
        XCTAssertFalse(testTimePeriodBefore.inside(of: self.controlTimePeriod), "%s Failed", file: #function)
        //Test end same as start
        let testTimePeriodEndSameStart = TimePeriod(beginning: self.formatter.date(from: "2013 11 05 18:15:12.000")!, end: self.formatter.date(from: "2014 11 05 18:15:12.000")!)
        XCTAssertFalse(testTimePeriodEndSameStart.inside(of: self.controlTimePeriod), "%s Failed", file: #function)
        //Test end inside
        let testTimePeriodEndInside = TimePeriod(beginning: self.formatter.date(from: "2014 11 02 18:15:12.000")!, end: self.formatter.date(from: "2014 11 07 18:15:12.000")!)
        XCTAssertFalse(testTimePeriodEndInside.inside(of: self.controlTimePeriod), "%s Failed", file: #function)
        //Test start inside
        let testTimePeriodStartInside = TimePeriod(beginning: self.formatter.date(from: "2014 11 07 18:15:12.000")!, end: self.formatter.date(from: "2016 12 05 18:15:12.000")!)
        XCTAssertFalse(testTimePeriodStartInside.inside(of: self.controlTimePeriod), "%s Failed", file: #function)
        //Test start same as end
        let testTimePeriodStartSameEnd = TimePeriod(beginning: self.formatter.date(from: "2016 11 05 18:15:12.000")!, end: self.formatter.date(from: "2016 11 10 18:15:12.000")!)
        XCTAssertFalse(testTimePeriodStartSameEnd.inside(of: self.controlTimePeriod), "%s Failed", file: #function)
        //Test after
        let testTimePeriodAfter = TimePeriod(beginning: self.formatter.date(from: "2016 12 05 18:15:12.000")!, end: self.formatter.date(from: "2016 12 10 18:15:12.000")!)
        XCTAssertFalse(testTimePeriodAfter.inside(of: self.controlTimePeriod), "%s Failed", file: #function)
    }
    
    func testContainsInterval() {
        //POSITIVE MATCHES
        //Test exact match
        let testTimePeriodExact = TimePeriod(beginning: self.formatter.date(from: "2014 11 05 18:15:12.000")!, end: self.formatter.date(from: "2016 11 05 18:15:12.000")!)
        XCTAssertTrue(self.controlTimePeriod.contains(period: testTimePeriodExact), "%s Failed", file: #function)
        //Test same start
        let testTimePeriodSameStart = TimePeriod(beginning: self.formatter.date(from: "2014 11 05 18:15:12.000")!, end: self.formatter.date(from: "2015 11 05 18:15:12.000")!)
        XCTAssertTrue(self.controlTimePeriod.contains(period: testTimePeriodSameStart), "%s Failed", file: #function)
        //Test same end
        let testTimePeriodSameEnd = TimePeriod(beginning: self.formatter.date(from: "2015 12 05 18:15:12.000")!, end: self.formatter.date(from: "2016 11 05 18:15:12.000")!)
        XCTAssertTrue(self.controlTimePeriod.contains(period: testTimePeriodSameEnd), "%s Failed", file: #function)
        //Test completely inside
        let testTimePeriodCompletelyInside = TimePeriod(beginning: self.formatter.date(from: "2015 12 05 18:15:12.000")!, end: self.formatter.date(from: "2016 04 05 18:15:12.000")!)
        XCTAssertTrue(self.controlTimePeriod.contains(period: testTimePeriodCompletelyInside), "%s Failed", file: #function)
        //NEGATIVE MATCHES
        //Test before
        let testTimePeriodBefore = TimePeriod(beginning: self.formatter.date(from: "2014 11 02 18:15:12.000")!, end: self.formatter.date(from: "2014 11 04 18:15:12.000")!)
        XCTAssertFalse(self.controlTimePeriod.contains(period: testTimePeriodBefore), "%s Failed", file: #function)
        //Test end same as start
        let testTimePeriodEndSameStart = TimePeriod(beginning: self.formatter.date(from: "2013 11 05 18:15:12.000")!, end: self.formatter.date(from: "2014 11 05 18:15:12.000")!)
        XCTAssertFalse(self.controlTimePeriod.contains(period: testTimePeriodEndSameStart), "%s Failed", file: #function)
        //Test end inside
        let testTimePeriodEndInside = TimePeriod(beginning: self.formatter.date(from: "2014 11 02 18:15:12.000")!, end: self.formatter.date(from: "2014 11 07 18:15:12.000")!)
        XCTAssertFalse(self.controlTimePeriod.contains(period: testTimePeriodEndInside), "%s Failed", file: #function)
        //Test start inside
        let testTimePeriodStartInside = TimePeriod(beginning: self.formatter.date(from: "2014 11 07 18:15:12.000")!, end: self.formatter.date(from: "2016 12 05 18:15:12.000")!)
        XCTAssertFalse(self.controlTimePeriod.contains(period: testTimePeriodStartInside), "%s Failed", file: #function)
        //Test start same as end
        let testTimePeriodStartSameEnd = TimePeriod(beginning: self.formatter.date(from: "2016 11 05 18:15:12.000")!, end: self.formatter.date(from: "2016 11 10 18:15:12.000")!)
        XCTAssertFalse(self.controlTimePeriod.contains(period: testTimePeriodStartSameEnd), "%s Failed", file: #function)
        //Test after
        let testTimePeriodAfter = TimePeriod(beginning: self.formatter.date(from: "2016 12 05 18:15:12.000")!, end: self.formatter.date(from: "2016 12 10 18:15:12.000")!)
        XCTAssertFalse(self.controlTimePeriod.contains(period: testTimePeriodAfter), "%s Failed", file: #function)
    }
    
    func testOverlaps() {
        //POSITIVE MATCHES
        //Test exact match
        let testTimePeriodExact: TimePeriod = TimePeriod(beginning: self.formatter.date(from: "2014 11 05 18:15:12.000")!, end: self.formatter.date(from: "2016 11 05 18:15:12.000")!)
        XCTAssertTrue(self.controlTimePeriod.overlaps(with: testTimePeriodExact), "%s Failed", file: #function)
        //Test same start
        let testTimePeriodSameStart: TimePeriod = TimePeriod(beginning: self.formatter.date(from: "2014 11 05 18:15:12.000")!, end: self.formatter.date(from: "2015 11 05 18:15:12.000")!)
        XCTAssertTrue(self.controlTimePeriod.overlaps(with: testTimePeriodSameStart), "%s Failed", file: #function)
        //Test same end
        let testTimePeriodSameEnd: TimePeriod = TimePeriod(beginning: self.formatter.date(from: "2015 12 05 18:15:12.000")!, end: self.formatter.date(from: "2016 11 05 18:15:12.000")!)
        XCTAssertTrue(self.controlTimePeriod.overlaps(with: testTimePeriodSameEnd), "%s Failed", file: #function)
        //Test completely inside
        let testTimePeriodCompletelyInside: TimePeriod = TimePeriod(beginning: self.formatter.date(from: "2015 12 05 18:15:12.000")!, end: self.formatter.date(from: "2016 04 05 18:15:12.000")!)
        XCTAssertTrue(self.controlTimePeriod.overlaps(with: testTimePeriodCompletelyInside), "%s Failed", file: #function)
        //Test start inside
        let testTimePeriodStartInside: TimePeriod = TimePeriod(beginning: self.formatter.date(from: "2014 11 07 18:15:12.000")!, end: self.formatter.date(from: "2016 12 05 18:15:12.000")!)
        XCTAssertTrue(self.controlTimePeriod.overlaps(with: testTimePeriodStartInside), "%s Failed", file: #function)
        //Test end inside
        let testTimePeriodEndInside: TimePeriod = TimePeriod(beginning: self.formatter.date(from: "2014 11 02 18:15:12.000")!, end: self.formatter.date(from: "2014 11 07 18:15:12.000")!)
        XCTAssertTrue(self.controlTimePeriod.overlaps(with: testTimePeriodEndInside), "%s Failed", file: #function)
        //NEGATIVE MATCHES
        //Test before
        let testTimePeriodBefore: TimePeriod = TimePeriod(beginning: self.formatter.date(from: "2014 11 02 18:15:12.000")!, end: self.formatter.date(from: "2014 11 04 18:15:12.000")!)
        XCTAssertFalse(self.controlTimePeriod.overlaps(with: testTimePeriodBefore), "%s Failed", file: #function)
        //Test end same as start
        let testTimePeriodEndSameStart: TimePeriod = TimePeriod(beginning: self.formatter.date(from: "2013 11 05 18:15:12.000")!, end: self.formatter.date(from: "2014 11 05 18:15:12.000")!)
        XCTAssertFalse(self.controlTimePeriod.overlaps(with: testTimePeriodEndSameStart), "%s Failed", file: #function)
        //Test start same as end
        let testTimePeriodStartSameEnd: TimePeriod = TimePeriod(beginning: self.formatter.date(from: "2016 11 05 18:15:12.000")!, end: self.formatter.date(from: "2016 11 10 18:15:12.000")!)
        XCTAssertFalse(self.controlTimePeriod.overlaps(with: testTimePeriodStartSameEnd), "%s Failed", file: #function)
        //Test after
        let testTimePeriodAfter: TimePeriod = TimePeriod(beginning: self.formatter.date(from: "2016 12 05 18:15:12.000")!, end: self.formatter.date(from: "2016 12 10 18:15:12.000")!)
        XCTAssertFalse(self.controlTimePeriod.overlaps(with: testTimePeriodAfter), "%s Failed", file: #function)
    }
    
    func testIntersects() {
        //POSITIVE MATCHES
        //Test exact match
        let testTimePeriodExact = TimePeriod(beginning: self.formatter.date(from: "2014 11 05 18:15:12.000")!, end: self.formatter.date(from: "2016 11 05 18:15:12.000")!)
        XCTAssertTrue(self.controlTimePeriod.intersects(with: testTimePeriodExact), "%s Failed", file: #function)
        //Test same start
        let testTimePeriodSameStart = TimePeriod(beginning: self.formatter.date(from: "2014 11 05 18:15:12.000")!, end: self.formatter.date(from: "2015 11 05 18:15:12.000")!)
        XCTAssertTrue(self.controlTimePeriod.intersects(with: testTimePeriodSameStart), "%s Failed", file: #function)
        //Test same end
        let testTimePeriodSameEnd = TimePeriod(beginning: self.formatter.date(from: "2015 12 05 18:15:12.000")!, end: self.formatter.date(from: "2016 11 05 18:15:12.000")!)
        XCTAssertTrue(self.controlTimePeriod.intersects(with: testTimePeriodSameEnd), "%s Failed", file: #function)
        //Test completely inside
        let testTimePeriodCompletelyInside = TimePeriod(beginning: self.formatter.date(from: "2015 12 05 18:15:12.000")!, end: self.formatter.date(from: "2016 04 05 18:15:12.000")!)
        XCTAssertTrue(self.controlTimePeriod.intersects(with: testTimePeriodCompletelyInside), "%s Failed", file: #function)
        //Test start inside
        let testTimePeriodStartInside = TimePeriod(beginning: self.formatter.date(from: "2014 11 07 18:15:12.000")!, end: self.formatter.date(from: "2016 12 05 18:15:12.000")!)
        XCTAssertTrue(self.controlTimePeriod.intersects(with: testTimePeriodStartInside), "%s Failed", file: #function)
        //Test end inside
        let testTimePeriodEndInside = TimePeriod(beginning: self.formatter.date(from: "2014 11 02 18:15:12.000")!, end: self.formatter.date(from: "2014 11 07 18:15:12.000")!)
        XCTAssertTrue(self.controlTimePeriod.intersects(with: testTimePeriodEndInside), "%s Failed", file: #function)
        //Test end same as start
        let testTimePeriodEndSameStart = TimePeriod(beginning: self.formatter.date(from: "2013 11 05 18:15:12.000")!, end: self.formatter.date(from: "2014 11 05 18:15:12.000")!)
        XCTAssertTrue(self.controlTimePeriod.intersects(with: testTimePeriodEndSameStart), "%s Failed", file: #function)
        //Test start same as end
        let testTimePeriodStartSameEnd = TimePeriod(beginning: self.formatter.date(from: "2016 11 05 18:15:12.000")!, end: self.formatter.date(from: "2016 11 10 18:15:12.000")!)
        XCTAssertTrue(self.controlTimePeriod.intersects(with: testTimePeriodStartSameEnd), "%s Failed", file: #function)
        //NEGATIVE MATCHES
        //Test before
        let testTimePeriodBefore = TimePeriod(beginning: self.formatter.date(from: "2014 11 02 18:15:12.000")!, end: self.formatter.date(from: "2014 11 04 18:15:12.000")!)
        XCTAssertFalse(self.controlTimePeriod.intersects(with: testTimePeriodBefore), "%s Failed", file: #function)
        //Test after
        let testTimePeriodAfter = TimePeriod(beginning: self.formatter.date(from: "2016 12 05 18:15:12.000")!, end: self.formatter.date(from: "2016 12 10 18:15:12.000")!)
        XCTAssertFalse(self.controlTimePeriod.intersects(with: testTimePeriodAfter), "%s Failed", file: #function)
    }
    
    func testRelation() {
        //Test exact match
        let testTimePeriodExact = TimePeriod(beginning: self.formatter.date(from: "2014 11 05 18:15:12.000")!, end: self.formatter.date(from: "2016 11 05 18:15:12.000")!)
        XCTAssertEqual(TimePeriod.Relation.exactMatch, testTimePeriodExact.relation(to: self.controlTimePeriod), "%s Failed", file: #function)
        //Test same start
        let testTimePeriodSameStart = TimePeriod(beginning: self.formatter.date(from: "2014 11 05 18:15:12.000")!, end: self.formatter.date(from: "2015 11 05 18:15:12.000")!)
        XCTAssertEqual(TimePeriod.Relation.insideStartTouching, testTimePeriodSameStart.relation(to: self.controlTimePeriod), "%s Failed", file: #function)
        //Test same end
        let testTimePeriodSameEnd = TimePeriod(beginning: self.formatter.date(from: "2015 12 05 18:15:12.000")!, end: self.formatter.date(from: "2016 11 05 18:15:12.000")!)
        XCTAssertEqual(TimePeriod.Relation.insideEndTouching, testTimePeriodSameEnd.relation(to: self.controlTimePeriod), "%s Failed", file: #function)
        //Test completely inside
        let testTimePeriodCompletelyInside = TimePeriod(beginning: self.formatter.date(from: "2015 12 05 18:15:12.000")!, end: self.formatter.date(from: "2016 04 05 18:15:12.000")!)
        XCTAssertEqual(TimePeriod.Relation.inside, testTimePeriodCompletelyInside.relation(to: self.controlTimePeriod), "%s Failed", file: #function)
        //NEGATIVE MATCHES
        //Test before
        let testTimePeriodBefore = TimePeriod(beginning: self.formatter.date(from: "2014 11 02 18:15:12.000")!, end: self.formatter.date(from: "2014 11 04 18:15:12.000")!)
        XCTAssertEqual(TimePeriod.Relation.before, testTimePeriodBefore.relation(to: self.controlTimePeriod), "%s Failed", file: #function)
        //Test end same as start
        let testTimePeriodEndSameStart = TimePeriod(beginning: self.formatter.date(from: "2013 11 05 18:15:12.000")!, end: self.formatter.date(from: "2014 11 05 18:15:12.000")!)
        XCTAssertEqual(TimePeriod.Relation.endTouching, testTimePeriodEndSameStart.relation(to: self.controlTimePeriod), "%s Failed", file: #function)
        //Test end inside
        let testTimePeriodEndInside = TimePeriod(beginning: self.formatter.date(from: "2014 11 02 18:15:12.000")!, end: self.formatter.date(from: "2014 11 07 18:15:12.000")!)
        XCTAssertEqual(TimePeriod.Relation.endInside, testTimePeriodEndInside.relation(to: self.controlTimePeriod), "%s Failed", file: #function)
        //Test start inside
        let testTimePeriodStartInside = TimePeriod(beginning: self.formatter.date(from: "2014 11 07 18:15:12.000")!, end: self.formatter.date(from: "2016 12 05 18:15:12.000")!)
        XCTAssertEqual(TimePeriod.Relation.startInside, testTimePeriodStartInside.relation(to: self.controlTimePeriod), "%s Failed", file: #function)
        //Test start same as end
        let testTimePeriodStartSameEnd = TimePeriod(beginning: self.formatter.date(from: "2016 11 05 18:15:12.000")!, end: self.formatter.date(from: "2016 11 10 18:15:12.000")!)
        XCTAssertEqual(TimePeriod.Relation.startTouching, testTimePeriodStartSameEnd.relation(to: self.controlTimePeriod), "%s Failed", file: #function)
        //Test after
        let testTimePeriodAfter = TimePeriod(beginning: self.formatter.date(from: "2016 12 05 18:15:12.000")!, end: self.formatter.date(from: "2016 12 10 18:15:12.000")!)
        XCTAssertEqual(TimePeriod.Relation.after, testTimePeriodAfter.relation(to: self.controlTimePeriod), "%s Failed", file: #function)
    }
    
    func testHasGap() {
        //We are going to treat some of these as False=noGap and True=gap
        //No Gap Same
        XCTAssertFalse(self.controlTimePeriod.hasGap(between: self.controlTimePeriod), "%s Failed", file: #function)
        //No Gap End Inside
        let testPeriodNoGap = TimePeriod(beginning: self.controlTimePeriod.beginning! - 1.days, end: self.controlTimePeriod.end!.subtract(1.days))
        XCTAssertFalse(self.controlTimePeriod.hasGap(between: testPeriodNoGap), "%s Failed", file: #function)
        //Gap receiver early
        let testPeriodReceiverEarly = TimePeriod(beginning: self.controlTimePeriod.end!.add(1.years), duration: 1.weeks)
        XCTAssertTrue(self.controlTimePeriod.hasGap(between: testPeriodReceiverEarly), "%s Failed", file: #function)
        //Gap parameter early
        let testPeriodParameterEarly = TimePeriod(end: self.controlTimePeriod.beginning! - 1.years, duration: 1.weeks)
        XCTAssertTrue(self.controlTimePeriod.hasGap(between: testPeriodParameterEarly), "%s Failed", file: #function)
    }
    
    func testGap() {
        //Gap of 1 minute
        let testPeriodParameter1MinuteEarly = TimePeriod(end: self.controlTimePeriod.beginning! - 1.minutes, duration: 1.seconds)
        XCTAssertEqual(60, self.controlTimePeriod.gap(between: testPeriodParameter1MinuteEarly), "%s Failed", file: #function)
    }
    
    
    // MARK: - Date Relationships
    
    func testContainsDate() {
        let testDateBefore: Date = self.formatter.date(from: "2014 10 05 18:15:12.000")!
        let testDateBetween: Date = self.formatter.date(from: "2015 11 05 18:15:12.000")!
        let testDateAfter: Date = self.formatter.date(from: "2016 12 05 18:15:12.000")!
        //Test before
        XCTAssertFalse(self.controlTimePeriod.contains(date: testDateBefore, interval: TimePeriod.Interval.open), "%s Failed", file: #function)
        XCTAssertFalse(self.controlTimePeriod.contains(date: testDateBefore, interval: TimePeriod.Interval.closed), "%s Failed", file: #function)
        //Test on start date
        XCTAssertFalse(self.controlTimePeriod.contains(date: self.controlTimePeriod.beginning!, interval: TimePeriod.Interval.open), "%s Failed", file: #function)
        XCTAssertTrue(self.controlTimePeriod.contains(date: self.controlTimePeriod.beginning!, interval: TimePeriod.Interval.closed), "%s Failed", file: #function)
        //Test in middle
        XCTAssertTrue(self.controlTimePeriod.contains(date: testDateBetween, interval: TimePeriod.Interval.closed), "%s Failed", file: #function)
        XCTAssertTrue(self.controlTimePeriod.contains(date: testDateBetween, interval: TimePeriod.Interval.closed), "%s Failed", file: #function)
        //Test on end date
        XCTAssertFalse(self.controlTimePeriod.contains(date: self.controlTimePeriod.end!, interval: TimePeriod.Interval.open), "%s Failed", file: #function)
        XCTAssertTrue(self.controlTimePeriod.contains(date: self.controlTimePeriod.end!, interval: TimePeriod.Interval.closed), "%s Failed", file: #function)
        //Test after
        XCTAssertFalse(self.controlTimePeriod.contains(date: testDateAfter, interval: TimePeriod.Interval.open), "%s Failed", file: #function)
        XCTAssertFalse(self.controlTimePeriod.contains(date: testDateAfter, interval: TimePeriod.Interval.closed), "%s Failed", file: #function)
    }
    
    
    // MARK: - Period Manipulation
    // MARK: Shift Earlier
    
    func testShiftSecondEarlier() {
        let startEarlierSecond: Date = self.formatter.date(from: "2014 11 05 18:15:11.000")!
        let endEarlierSecond: Date = self.formatter.date(from: "2016 11 05 18:15:11.000")!
        //Second time period
        let testPeriod: TimePeriod = TimePeriod(beginning: startEarlierSecond, end: endEarlierSecond)
        let timeChunk = TimeChunk(size: .second, amount: 1)
        self.controlTimePeriod.shift(by: timeChunk)
        XCTAssertTrue(testPeriod.beginning!.equals(self.controlTimePeriod.beginning!) && testPeriod.end!.equals(self.controlTimePeriod.end!), "%s Failed", file: #function)
    }
    
    func testShiftMinuteEarlier() {
        let startEarlier: Date = self.formatter.date(from: "2014 11 05 18:14:12.000")!
        let endEarlier: Date = self.formatter.date(from: "2016 11 05 18:14:12.000")!
        let testPeriod: TimePeriod = TimePeriod(beginning: startEarlier, end: endEarlier)
        let timeChunk = TimeChunk(size: .minute, amount: 1)
        self.controlTimePeriod.shift(by: timeChunk)
        XCTAssertTrue(testPeriod.beginning!.equals(self.controlTimePeriod.beginning!) && testPeriod.end!.equals(self.controlTimePeriod.end!), "%s Failed", file: #function)
    }
    
}
