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
        XCTAssertTrue(self.controlTimePeriod.equals(period: testPeriodInit) && self.controlTimePeriod.end!.equals(date: testPeriodInit.end!), "%s Failed", file: #function)
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
        var differentEndPeriod = TimePeriod(beginning: self.controlTimePeriod.beginning!, end: self.controlTimePeriod.end!.add(1.years))
        XCTAssertFalse(self.controlTimePeriod.equals(period: differentEndPeriod), "%s Failed", file: #function)
        //Different beginning
        var differentStartPeriod = TimePeriod (beginning: self.controlTimePeriod.beginning!.subtract(1.years), end: self.controlTimePeriod.end!)
        XCTAssertFalse(self.controlTimePeriod.equals(differentStartPeriod), "%s Failed", file: #function)
        //Both endings different
        var differentStartAndEndPeriod = TimePeriod(beginning: self.controlTimePeriod.beginning!.subtract(1.weeks), end: self.controlTimePeriod.end!.subtract(1.weeks))
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
    
    func testContains() {
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
        var testTimePeriodExact = TimePeriod(beginning: self.formatter.date(from: "2014 11 05 18:15:12.000")!, end: self.formatter.date(from: "2016 11 05 18:15:12.000")!)
        XCTAssertEqual(TimePeriod.Relation.exactMatch, testTimePeriodExact.relation(to period: self.controlTimePeriod), "%s Failed", file: #function)
        //Test same start
        var testTimePeriodSameStart = TimePeriod(beginning: self.formatter.date(from: "2014 11 05 18:15:12.000")!, end: self.formatter.date(from: "2015 11 05 18:15:12.000")!)
        XCTAssertEqual(TimePeriod.Relation.insideStartTouching, testTimePeriodSameStart.relation(to period: self.controlTimePeriod), "%s Failed", file: #function)
        //Test same end
        var testTimePeriodSameEnd = TimePeriod(beginning: self.formatter.date(from: "2015 12 05 18:15:12.000")!, end: self.formatter.date(from: "2016 11 05 18:15:12.000")!)
        XCTAssertEqual(TimePeriod.Relation.insideEndTouching, testTimePeriodSameEnd.relation(to period: self.controlTimePeriod), "%s Failed", file: #function)
        //Test completely inside
        var testTimePeriodCompletelyInside = TimePeriod(beginning: self.formatter.date(from: "2015 12 05 18:15:12.000")!, end: self.formatter.date(from: "2016 04 05 18:15:12.000")!)
        XCTAssertEqual(TimePeriod.Relation.inside, testTimePeriodCompletelyInside.relation(to period: self.controlTimePeriod), "%s Failed", file: #function)
        //NEGATIVE MATCHES
        //Test before
        var testTimePeriodBefore = TimePeriod(beginning: self.formatter.date(from: "2014 11 02 18:15:12.000")!, end: self.formatter.date(from: "2014 11 04 18:15:12.000")!)
        XCTAssertEqual(TimePeriod.Relation.before, testTimePeriodBefore.relation(to period: self.controlTimePeriod), "%s Failed", file: #function)
        //Test end same as start
        var testTimePeriodEndSameStart = TimePeriod(beginning: self.formatter.date(from: "2013 11 05 18:15:12.000")!, end: self.formatter.date(from: "2014 11 05 18:15:12.000")!)
        XCTAssertEqual(TimePeriod.Relation.endTouching, testTimePeriodEndSameStart.relation(to period: self.controlTimePeriod), "%s Failed", file: #function)
        //Test end inside
        var testTimePeriodEndInside = TimePeriod(beginning: self.formatter.date(from: "2014 11 02 18:15:12.000")!, end: self.formatter.date(from: "2014 11 07 18:15:12.000")!)
        XCTAssertEqual(TimePeriod.Relation.endInside, testTimePeriodEndInside.relation(to period: self.controlTimePeriod), "%s Failed", file: #function)
        //Test start inside
        var testTimePeriodStartInside = TimePeriod(beginning: self.formatter.date(from: "2014 11 07 18:15:12.000")!, end: self.formatter.date(from: "2016 12 05 18:15:12.000")!)
        XCTAssertEqual(TimePeriod.Relation.startInside, testTimePeriodStartInside.relation(to period: self.controlTimePeriod), "%s Failed", file: #function)
        //Test start same as end
        var testTimePeriodStartSameEnd = TimePeriod(beginning: self.formatter.date(from: "2016 11 05 18:15:12.000")!, end: self.formatter.date(from: "2016 11 10 18:15:12.000")!)
        XCTAssertEqual(TimePeriod.Relation.startTouching, testTimePeriodStartSameEnd.relation(to period: self.controlTimePeriod), "%s Failed", file: #function)
        //Test after
        var testTimePeriodAfter = TimePeriod(beginning: self.formatter.date(from: "2016 12 05 18:15:12.000")!, end: self.formatter.date(from: "2016 12 10 18:15:12.000")!)
        XCTAssertEqual(TimePeriod.Relation.after, testTimePeriodAfter.relation(to period: self.controlTimePeriod), "%s Failed", file: #function)
    }
    
}
