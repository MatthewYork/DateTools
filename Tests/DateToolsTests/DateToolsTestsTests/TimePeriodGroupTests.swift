//
//  TimePeriodGroupTests.swift
//  DateToolsTests
//
//  Created by Grayson Webster on 8/19/16.
//  Copyright © 2016 Matthew York. All rights reserved.
//

import XCTest

class TimePeriodGroupTests : XCTestCase {
    
    var formatter: DateFormatter?
    var controlCollection: TimePeriodCollection?
    
    override func setUp() {
        super.up = nil
        //Initialize control TimePeriodChain
        self.controlCollection = TimePeriodCollection()
        //Initialize formatter
        self.formatter = DateFormatter()
        self.formatter?.dateFormat = "yyyy MM dd HH:mm:ss.SSS"
        //Create test TimePeriods that are 1 year long
        var firstPeriod: TimePeriod = TimePeriod(startDate: self.formatter.dateFromString("2014 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2015 11 05 18:15:12.000"))
        var secondPeriod: TimePeriod = TimePeriod(startDate: self.formatter.dateFromString("2015 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 11 05 18:15:12.000"))
        var thirdPeriod: TimePeriod = TimePeriod(startDate: self.formatter.dateFromString("2016 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2017 11 05 18:15:12.000"))
        var fourthPeriod: TimePeriod = TimePeriod(startDate: self.formatter.dateFromString("2015 4 05 18:15:12.000"), endDate: self.formatter.dateFromString("2017 4 05 18:15:12.000"))
        //Add test periods
        self.controlCollection.addTimePeriod(firstPeriod)
        self.controlCollection.addTimePeriod(secondPeriod)
        self.controlCollection.addTimePeriod(thirdPeriod)
        self.controlCollection.addTimePeriod(fourthPeriod)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: - Group Info
    func testDurationInYears() {
        XCTAssertEqual(3, self.controlCollection.durationInYears, "%s Failed", file: #function)
    }
    
    func testDurationInWeeks() {
        XCTAssertEqual(156, self.controlCollection.durationInWeeks, "%s Failed", file: #function)
    }
    
    func testDurationInDays() {
        XCTAssertEqual(1096, self.controlCollection.durationInDays, "%s Failed", file: #function)
    }
    
    func testDurationInHours() {
        XCTAssertEqual(26304, self.controlCollection.durationInHours, "%s Failed", file: #function)
    }
    
    func testDurationInMinutes() {
        XCTAssertEqual(1578240, self.controlCollection.durationInMinutes, "%s Failed", file: #function)
    }
    
    func testDurationInSeconds() {
        XCTAssertEqual(94694400, self.controlCollection.durationInSeconds, "%s Failed", file: #function)
    }
    
    // MARK: - Comparison
    func testHasSameCharacteristicsAs() {
        var collectionSame: TimePeriodCollection = TimePeriodCollection()
        var chain: TimePeriodChain = TimePeriodChain()
        //Create test TimePeriods to construct same as control
        //Add test periods
        collectionSame.addTimePeriod(firstPeriod)
        collectionSame.addTimePeriod(secondPeriod)
        collectionSame.addTimePeriod(thirdPeriod)
        collectionSame.addTimePeriod(fourthPeriod)
        chain.addTimePeriod(firstPeriod)
        chain.addTimePeriod(secondPeriod)
        chain.addTimePeriod(thirdPeriod)
        chain.addTimePeriod(fourthPeriod)
        //Test same as control
        XCTAssertTrue(self.controlCollection.hasSameCharacteristicsAs(collectionSame), "%s Failed", file: #function)
        //Test differnt chain
        XCTAssertFalse(self.controlCollection.hasSameCharacteristicsAs(chain), "%s Failed", file: #function)
        //Test alternate
        collectionSame.removeTimePeriodAtIndex(3)
        collectionSame.addTimePeriod(alternateFourthPeriod)
        XCTAssertTrue(self.controlCollection.hasSameCharacteristicsAs(collectionSame), "%s Failed", file: #function)
    }
    
}

