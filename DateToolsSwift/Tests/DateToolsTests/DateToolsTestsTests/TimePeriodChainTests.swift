//
//  TimePeriodChainTests.swift
//  DateToolsTests
//
//  Created by Grayson Webster on 8/19/16.
//  Copyright © 2016 Matthew York. All rights reserved.
//

import XCTest
@testable import DateToolsSwift


class TimePeriodChainTests : XCTestCase {
    
    var formatter = DateFormatter()
    var controlChain = TimePeriodChain()
    var firstPeriod = TimePeriod()
    var secondPeriod = TimePeriod()
    var thirdPeriod = TimePeriod()
    
    override func setUp() {
        //Initialize control TimePeriodChain
        self.formatter.dateFormat = "yyyy MM dd HH:mm:ss.SSS"
        self.formatter.timeZone = TimeZone(abbreviation: "UTC")
        //Create test TimePeriods that are 1 year long
        firstPeriod = TimePeriod(beginning: self.formatter.date(from: "2014 11 05 18:15:12.000")!, end: self.formatter.date(from: "2015 11 05 18:15:12.000")!)
        secondPeriod = TimePeriod(beginning: self.formatter.date(from: "2015 11 05 18:15:12.000")!, end: self.formatter.date(from: "2016 11 05 18:15:12.000")!)
        thirdPeriod = TimePeriod(beginning: self.formatter.date(from: "2016 11 05 18:15:12.000")!, end: self.formatter.date(from: "2017 11 05 18:15:12.000")!)
        //Add test periods
        self.controlChain.append(firstPeriod)
        self.controlChain.append(secondPeriod)
        self.controlChain.append(thirdPeriod)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    // MARK: - Chain Manipulation
    
    func testAppendPeriod() {
        let testPeriod = TimePeriod(beginning: self.formatter.date(from: "2015 11 05 18:15:12.000")!, end: self.formatter.date(from: "2017 11 05 18:15:12.000")!)
        
        //Build test chain
        let testChain = TimePeriodChain()
        testChain.periods.append(firstPeriod)
        testChain.periods.append(TimePeriod(beginning: testChain[0].end!, duration: secondPeriod.duration))
        testChain.periods.append(TimePeriod(beginning: testChain[1].end!, duration: thirdPeriod.duration))
        testChain.periods.append(TimePeriod(beginning: testChain[2].end!, duration: testPeriod.duration))
        
        //Append to control
        controlChain.append(testPeriod)
        
        XCTAssertTrue(testChain == controlChain)
        XCTAssertEqual(self.formatter.date(from: "2014 11 05 18:15:12.000")!, controlChain.beginning)
        XCTAssertEqual(self.formatter.date(from: "2019 11 06 18:15:12.000")!, controlChain.end)
        
        //Simple example
        let simplePeriod = TimePeriod(beginning: self.formatter.date(from: "2015 11 05 18:15:12.000")!, end: self.formatter.date(from: "2015 11 05 18:15:13.000")!)
        let simpleChain = TimePeriodChain()
        simpleChain.append(simplePeriod)
        simpleChain.append(simplePeriod)
        simpleChain.append(simplePeriod)
        XCTAssertEqual(self.formatter.date(from: "2015 11 05 18:15:12.000")!, simpleChain.beginning)
        XCTAssertEqual(self.formatter.date(from: "2015 11 05 18:15:15.000")!, simpleChain.end)
    }
    
    func testAppendGroup() {
        let testPeriod1 = TimePeriod(beginning: self.formatter.date(from: "2015 11 05 18:15:12.000")!, end: self.formatter.date(from: "2017 11 05 18:15:12.000")!)
        let testPeriod2 = TimePeriod(beginning: self.formatter.date(from: "2015 11 05 18:15:12.000")!, end: self.formatter.date(from: "2018 11 05 18:15:12.000")!)
        let testPeriod3 = TimePeriod(beginning: self.formatter.date(from: "2015 11 05 18:15:12.000")!, end: self.formatter.date(from: "2019 11 05 18:15:12.000")!)
        
        //Build test chain
        let testChain = TimePeriodChain()
        testChain.periods.append(testPeriod1)
        testChain.periods.append(TimePeriod(beginning: testChain[0].end!, chunk: testPeriod2.chunk))
        testChain.periods.append(TimePeriod(beginning: testChain[1].end!, chunk: testPeriod3.chunk))
        
        let appendCollection = TimePeriodCollection();
        appendCollection.append(testPeriod1)
        appendCollection.append(testPeriod2)
        appendCollection.append(testPeriod3)
        let appendChain = TimePeriodChain()
        appendChain.append(contentsOf: appendCollection)
        
        XCTAssertTrue(testChain == appendChain)
        XCTAssertEqual(self.formatter.date(from: "2015 11 05 18:15:12.000")!, appendChain.beginning)
        XCTAssertEqual(self.formatter.date(from: "2024 11 05 18:15:12.000")!, appendChain.end)
    }
    
    func testInsert() {
        let testPeriod = TimePeriod(beginning: self.formatter.date(from: "2012 11 05 18:15:12.000")!, end: self.formatter.date(from: "2013 11 05 18:15:12.000")!)
        controlChain.insert(testPeriod, at: 0)
        
        //Check accurate insertion placement
        XCTAssertTrue(controlChain[0].beginning == testPeriod.beginning)
        XCTAssertTrue(controlChain[0].end == testPeriod.end)
        
        //Check accurate insertion chain modification
        XCTAssertEqual(self.formatter.date(from: "2012 11 05 18:15:12.000")!, controlChain.beginning)
        XCTAssertEqual(self.formatter.date(from: "2016 11 04 18:15:12.000")!, controlChain.end) //Doesn't account for leap year
    }
    
    func testRemove() {
        controlChain.remove(at: 1)
        
        //Build test chain
        let testChain = TimePeriodChain()
        testChain.append(firstPeriod)
        testChain.append(thirdPeriod)
        
        XCTAssertTrue(controlChain == testChain)
    }
    
    func testRemoveAll() {
        controlChain.removeAll()
        XCTAssertTrue(controlChain.count == 0)
    }
    
    func testDuration() {
        //Simple example
        let simplePeriod = TimePeriod(beginning: self.formatter.date(from: "2015 11 05 18:15:12.000")!, end: self.formatter.date(from: "2015 11 05 18:15:13.000")!)
        let simpleChain = TimePeriodChain()
        simpleChain.append(simplePeriod)
        simpleChain.append(simplePeriod)
        simpleChain.append(simplePeriod)
        XCTAssertEqual(simpleChain.duration, 3.0)
    }
    
    func testPop() {
        //Build test chain
        let testChain = TimePeriodChain()
        testChain.periods.append(firstPeriod)
        testChain.periods.append(TimePeriod(beginning: testChain[0].end!, chunk: secondPeriod.chunk))
        
        let _ = controlChain.pop()!
        XCTAssertTrue(testChain == controlChain)
        //Cannot accurately test popped value due to daylight savings changes
    }
    
    
    // MARK: - Chain Time Manipulation
    
    func testShiftBy() {
        controlChain.shift(by: 4)
        
        let testChain = TimePeriodChain()
        let testPeriod1 = TimePeriod(beginning: self.formatter.date(from: "2014 11 05 18:15:16.000")!, end: self.formatter.date(from: "2015 11 05 18:15:16.000")!)
        let testPeriod2 = TimePeriod(beginning: self.formatter.date(from: "2015 11 05 18:15:16.000")!, end: self.formatter.date(from: "2016 11 05 18:15:16.000")!)
        let testPeriod3 = TimePeriod(beginning: self.formatter.date(from: "2016 11 05 18:15:16.000")!, end: self.formatter.date(from: "2017 11 05 18:15:16.000")!)
        testChain.append(testPeriod1)
        testChain.append(testPeriod2)
        testChain.append(testPeriod3)
        XCTAssertTrue(controlChain.equals(testChain))
    }
    
    
    // MARK: - Chain Relationship
    
    func testEquals() {
        let testChain = TimePeriodChain()
        let testPeriod1 = TimePeriod(beginning: self.formatter.date(from: "2014 11 05 18:15:12.000")!, end: self.formatter.date(from: "2015 11 05 18:15:12.000")!)
        let testPeriod2 = TimePeriod(beginning: self.formatter.date(from: "2015 11 05 18:15:12.000")!, end: self.formatter.date(from: "2016 11 05 18:15:12.000")!)
        let testPeriod3 = TimePeriod(beginning: self.formatter.date(from: "2016 11 05 18:15:12.000")!, end: self.formatter.date(from: "2017 11 05 18:15:12.000")!)
        testChain.append(testPeriod1)
        testChain.append(testPeriod2)
        testChain.append(testPeriod3)
        XCTAssertTrue(controlChain.equals(testChain))
        XCTAssertTrue(controlChain == testChain)
        XCTAssertEqual(controlChain.beginning, testChain.beginning)
        XCTAssertEqual(controlChain.end, testChain.end)
    }
    
    
    // MARK: - Updates
    
    func testUpdateVariables() {
        
    }
    
}

