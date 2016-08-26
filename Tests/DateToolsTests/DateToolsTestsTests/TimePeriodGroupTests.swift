//
//  TimePeriodGroupTests.swift
//  DateToolsTests
//
//  Created by Grayson Webster on 8/19/16.
//  Copyright © 2016 Matthew York. All rights reserved.
//

import XCTest
@testable import DateToolsTests


class TimePeriodGroupTests : XCTestCase {
    
    var formatter = DateFormatter()
    var controlCollection = TimePeriodCollection()
    var firstPeriod = TimePeriod()
    var secondPeriod = TimePeriod()
    var thirdPeriod = TimePeriod()
    var fourthPeriod = TimePeriod()
    
    override func setUp() {
        //Initialize control TimePeriodChain
        self.controlCollection = TimePeriodCollection()
        //Initialize formatter
        self.formatter.dateFormat = "yyyy MM dd HH:mm:ss.SSS"
        //Create test TimePeriods that are 1 year long
        firstPeriod = TimePeriod(beginning: self.formatter.date(from: "2014 11 05 18:15:12.000")!, end: self.formatter.date(from: "2015 11 05 18:15:12.000")!)
        secondPeriod = TimePeriod(beginning: self.formatter.date(from: "2015 11 05 18:15:12.000")!, end: self.formatter.date(from: "2016 11 05 18:15:12.000")!)
        thirdPeriod = TimePeriod(beginning: self.formatter.date(from: "2016 11 05 18:15:12.000")!, end: self.formatter.date(from: "2017 11 05 18:15:12.000")!)
        fourthPeriod = TimePeriod(beginning: self.formatter.date(from: "2015 4 05 18:15:12.000")!, end: self.formatter.date(from: "2017 4 05 18:15:12.000")!)
        //Add test periods
        self.controlCollection.add(firstPeriod)
        self.controlCollection.add(secondPeriod)
        self.controlCollection.add(thirdPeriod)
        self.controlCollection.add(fourthPeriod)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: - Group Info
    func testDurationInWeeks() {
        XCTAssertEqual(156, self.controlCollection.durationInWeeks)
    }
    
    func testDurationInDays() {
        XCTAssertEqual(1096, self.controlCollection.durationInDays)
    }
    
    func testDurationInHours() {
        XCTAssertEqual(26304, self.controlCollection.durationInHours)
    }
    
    func testDurationInMinutes() {
        XCTAssertEqual(1578240, self.controlCollection.durationInMinutes)
    }
    
    func testDurationInSeconds() {
        XCTAssertEqual(94694400, self.controlCollection.durationInSeconds)
    }
    
    // MARK: - Comparison
    func testHasSameCharacteristicsAs() {
        var collectionSame: TimePeriodCollection = TimePeriodCollection()
        var chain: TimePeriodChain = TimePeriodChain()
        //Create test TimePeriods to construct same as control
        //Add test periods
        collectionSame.add(firstPeriod)
        collectionSame.add(secondPeriod)
        collectionSame.add(thirdPeriod)
        collectionSame.add(fourthPeriod)
        chain.add(firstPeriod)
        chain.add(secondPeriod)
        chain.add(thirdPeriod)
        chain.add(fourthPeriod)
        //Test same as control
        XCTAssertTrue(self.controlCollection.hasSameCharacteristicsAs(collectionSame))
        //Test differnt chain
        XCTAssertFalse(self.controlCollection.hasSameCharacteristicsAs(chain))
        //Test alternate
        collectionSame.removeTimePeriodAtIndex(3)
        collectionSame.addTimePeriod(alternateFourthPeriod)
        XCTAssertTrue(self.controlCollection.hasSameCharacteristicsAs(collectionSame))
    }
    
}

