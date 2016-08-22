//
//  TimePeriodCollectionTests.swift
//  DateToolsTests
//
//  Created by Grayson Webster on 8/19/16.
//  Copyright © 2016 Matthew York. All rights reserved.
//

import XCTest
@testable import DateToolsTests


class TimePeriodChainTests : XCTestCase {
    
    var formatter: DateFormatter?
    var controlChain: TimePeriodChain?
    
    override func setUp() {
        super.up = nil
        //Initialize control TimePeriodChain
        self.controlChain = TimePeriodChain()
        //Initialize formatter
        self.formatter = DateFormatter()
        self.formatter?.dateFormat = "yyyy MM dd HH:mm:ss.SSS"
        //Create test TimePeriods that are 1 year long
        var firstPeriod: TimePeriod = TimePeriod(startDate: self.formatter.dateFromString("2014 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2015 11 05 18:15:12.000"))
        var secondPeriod: TimePeriod = TimePeriod(startDate: self.formatter.dateFromString("2015 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 11 05 18:15:12.000"))
        var thirdPeriod: TimePeriod = TimePeriod(startDate: self.formatter.dateFromString("2016 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2017 11 05 18:15:12.000"))
        var fourthPeriod: TimePeriod = TimePeriod(startDate: self.formatter.dateFromString("2015 4 05 18:15:12.000"), endDate: self.formatter.dateFromString("2017 4 05 18:15:12.000"))
        //Add test periods
        self.controlChain.addTimePeriod(firstPeriod)
        self.controlChain.addTimePeriod(secondPeriod)
        self.controlChain.addTimePeriod(thirdPeriod)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: - Custom Init / Factory Chain
    func testInitsAndFactories() {
        var initCompareChain: TimePeriodChain = TimePeriodChain()
        var factoryCompareChain: TimePeriodChain = TimePeriodChain.chain()
        XCTAssertTrue(initCompareChain.isEqualToChain(factoryCompareChain), "%s Failed", file: #function)
    }
    
    // MARK: - Chain Existence Manipulation
    func testAddTimePeriod() {
        //Create test chain
        var testChain: TimePeriodChain = TimePeriodChain.chain()
        testChain.addTimePeriod(TimePeriod(startDate: self.formatter.dateFromString("2014 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2015 11 05 18:15:12.000")))
        testChain.addTimePeriod(TimePeriod(startDate: self.formatter.dateFromString("2015 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 11 05 18:15:12.000")))
        testChain.addTimePeriod(TimePeriod(startDate: self.formatter.dateFromString("2016 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2017 11 05 18:15:12.000")))
        //Check equal
        XCTAssertTrue(self.controlChain.isEqualToChain(testChain), "%s Failed", file: #function)
    }
    
    func testInsertTimePeriod() {
        //Create test chain
        var testChain: TimePeriodChain = TimePeriodChain.chain()
        testChain.addTimePeriod(TimePeriod(startDate: self.formatter.dateFromString("2014 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2015 11 05 18:15:12.000")))
        testChain.addTimePeriod(TimePeriod(startDate: self.formatter.dateFromString("2016 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2017 11 05 18:15:12.000")))
        testChain.insertTimePeriod(TimePeriod(startDate: self.formatter.dateFromString("2015 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 11 05 18:15:12.000")), atInedx: 1)
        //Check equal
        XCTAssertTrue(self.controlChain.isEqualToChain(testChain), "%s Failed", file: #function)
    }
    
    func testRemoveTimePeriodAtIndex() {
        //Create test chain
        var testChain: TimePeriodChain = TimePeriodChain.chain()
        testChain.addTimePeriod(TimePeriod(startDate: self.formatter.dateFromString("2014 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2015 11 05 18:15:12.000")))
        testChain.addTimePeriod(TimePeriod(startDate: self.formatter.dateFromString("2016 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2017 11 05 18:15:12.000")))
        self.controlChain.removeTimePeriodAtIndex(1)
        //Check equal
        XCTAssertTrue(self.controlChain.isEqualToChain(testChain), "%s Failed", file: #function)
    }
    
    func testRemoveLatestTimePeriod() {
        //Create test chain
        var testChain: TimePeriodChain = TimePeriodChain.chain()
        testChain.addTimePeriod(TimePeriod(startDate: self.formatter.dateFromString("2014 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2015 11 05 18:15:12.000")))
        testChain.addTimePeriod(TimePeriod(startDate: self.formatter.dateFromString("2015 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 11 05 18:15:12.000")))
        self.controlChain.removeLatestTimePeriod()
        //Check equal
        XCTAssertTrue(self.controlChain.isEqualToChain(testChain), "%s Failed", file: #function)
    }
    
    func testRemoveEarliestTimePeriod() {
        //Create test chain
        var testChain: TimePeriodChain = TimePeriodChain.chain()
        testChain.addTimePeriod(TimePeriod(startDate: self.formatter.dateFromString("2015 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 11 05 18:15:12.000")))
        testChain.addTimePeriod(TimePeriod(startDate: self.formatter.dateFromString("2016 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2017 11 05 18:15:12.000")))
        testChain.shiftEarlierWithSize(TimePeriodSizeSecond, amount: TimePeriod(startDate: self.formatter.dateFromString("2014 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2015 11 05 18:15:12.000")).durationInSeconds())
        self.controlChain.removeEarliestTimePeriod()
        //Check equal
        XCTAssertTrue(self.controlChain.isEqualToChain(testChain), "%s Failed", file: #function)
    }
    
    // MARK: - Chain Time Manipulation
    func testShiftEarlier() {
        //Create test chain
        var testChainOriginal: TimePeriodChain = TimePeriodChain.chain()
        testChainOriginal.addTimePeriod(TimePeriod(startDate: self.formatter.dateFromString("2014 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2015 11 05 18:15:12.000")))
        testChainOriginal.addTimePeriod(TimePeriod(startDate: self.formatter.dateFromString("2015 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 11 05 18:15:12.000")))
        testChainOriginal.addTimePeriod(TimePeriod(startDate: self.formatter.dateFromString("2016 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2017 11 05 18:15:12.000")))
        //Create test chain
        var testChain: TimePeriodChain = TimePeriodChain.chain()
        testChain.addTimePeriod(TimePeriod(startDate: self.formatter.dateFromString("2012 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2013 11 05 18:15:12.000")))
        testChain.addTimePeriod(TimePeriod(startDate: self.formatter.dateFromString("2013 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2014 11 05 18:15:12.000")))
        testChain.addTimePeriod(TimePeriod(startDate: self.formatter.dateFromString("2014 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2015 11 05 18:15:12.000")))
        //Shift control chain
        self.controlChain.shiftEarlierWithSize(TimePeriodSizeYear, amount: 2)
        //Check equal
        XCTAssertTrue(self.controlChain.isEqualToChain(testChain), "%s Failed", file: #function)
        //Check equal
        XCTAssertFalse(self.controlChain.isEqualToChain(testChainOriginal), "%s Failed", file: #function)
    }
    
    func testShiftLater() {
        //Create test chain
        var testChainOriginal: TimePeriodChain = TimePeriodChain.chain()
        testChainOriginal.addTimePeriod(TimePeriod(startDate: self.formatter.dateFromString("2014 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2015 11 05 18:15:12.000")))
        testChainOriginal.addTimePeriod(TimePeriod(startDate: self.formatter.dateFromString("2015 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 11 05 18:15:12.000")))
        testChainOriginal.addTimePeriod(TimePeriod(startDate: self.formatter.dateFromString("2016 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2017 11 05 18:15:12.000")))
        //Create test chain
        var testChain: TimePeriodChain = TimePeriodChain.chain()
        testChain.addTimePeriod(TimePeriod(startDate: self.formatter.dateFromString("2016 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2017 11 05 18:15:12.000")))
        testChain.addTimePeriod(TimePeriod(startDate: self.formatter.dateFromString("2017 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2018 11 05 18:15:12.000")))
        testChain.addTimePeriod(TimePeriod(startDate: self.formatter.dateFromString("2018 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2019 11 05 18:15:12.000")))
        //Shift control chain
        self.controlChain.shiftLaterWithSize(TimePeriodSizeYear, amount: 2)
        //Check equal
        XCTAssertTrue(self.controlChain.isEqualToChain(testChain), "%s Failed", file: #function)
        //Check equal
        XCTAssertFalse(self.controlChain.isEqualToChain(testChainOriginal), "%s Failed", file: #function)
    }
    
    // MARK: - Chain Relationship
    func testIsEqualToChain() {
        //Create test chains
        var testChain: TimePeriodChain = TimePeriodChain.chain()
        testChain.addTimePeriod(TimePeriod(startDate: self.formatter.dateFromString("2014 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2015 11 05 18:15:12.000")))
        testChain.addTimePeriod(TimePeriod(startDate: self.formatter.dateFromString("2015 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 11 05 18:15:12.000")))
        testChain.addTimePeriod(TimePeriod(startDate: self.formatter.dateFromString("2016 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2017 11 05 18:15:12.000")))
        var testChainOutOfOrder: TimePeriodChain = TimePeriodChain.chain()
        testChainOutOfOrder.addTimePeriod(TimePeriod(startDate: self.formatter.dateFromString("2015 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2016 11 05 18:15:12.000")))
        testChainOutOfOrder.addTimePeriod(TimePeriod(startDate: self.formatter.dateFromString("2016 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2017 11 05 18:15:12.000")))
        testChainOutOfOrder.addTimePeriod(TimePeriod(startDate: self.formatter.dateFromString("2014 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2015 11 05 18:15:12.000")))
        //Check equal
        XCTAssertTrue(self.controlChain.isEqualToChain(testChain), "%s Failed", file: #function)
        //Check unequal
        testChain.addTimePeriod(TimePeriod(startDate: self.formatter.dateFromString("2014 11 05 18:15:12.000"), endDate: self.formatter.dateFromString("2015 11 05 18:15:12.000")))
        XCTAssertFalse(self.controlChain.isEqualToChain(testChain), "%s Failed", file: #function)
        //Check same periods out of order
        XCTAssertFalse(self.controlChain.isEqualToChain(testChainOutOfOrder), "%s Failed", file: #function)
    }
    
}

