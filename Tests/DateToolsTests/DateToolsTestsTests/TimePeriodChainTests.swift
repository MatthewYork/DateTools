//
//  TimePeriodChainTests.swift
//  DateToolsTests
//
//  Created by Grayson Webster on 8/19/16.
//  Copyright © 2016 Matthew York. All rights reserved.
//

import XCTest
@testable import DateToolsTests


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
        testChain.periods.append(TimePeriod(beginning: testChain[0].end!, chunk: secondPeriod.chunk))
        testChain.periods.append(TimePeriod(beginning: testChain[1].end!, chunk: thirdPeriod.chunk))
        testChain.periods.append(TimePeriod(beginning: testChain[2].end!, chunk: testPeriod.chunk))
        
        //Append to control
        controlChain.append(testPeriod)
        
        XCTAssertTrue(testChain == controlChain)
    }
    
    func testAppendGroup() {
        let testCollection = TimePeriodCollection()
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
    }
    
    func testInsert() {
        let testPeriod = TimePeriod(beginning: self.formatter.date(from: "2015 11 05 18:15:12.000")!, end: self.formatter.date(from: "2017 11 05 18:15:12.000")!)
        controlChain.insert(testPeriod, at: 2)
        XCTAssertTrue(controlChain[2] as! TimePeriod == testPeriod)
    }
    
    func testRemove() {
        controlChain.remove(at: 1)
        XCTAssertTrue(controlChain.count == 2)
    }
    
    func testRemoveAll() {
        controlChain.removeAll()
        XCTAssertTrue(controlChain.count == 0)
    }
    
    func testMap() {
        
    }
    
    func testFilter() {
        
    }
    
    func testReduce() {
        
    }
    
    func testPop() {
        //Build test chain
        let testChain = TimePeriodChain()
        testChain.periods.append(firstPeriod)
        testChain.periods.append(TimePeriod(beginning: testChain[0].end!, chunk: secondPeriod.chunk))
        
        let poppedPeriod = controlChain.pop()!
        XCTAssertTrue(testChain == controlChain)
        //Cannot accurately test popped value due to daylight savings changes
    }
    
    
    // MARK: - Chain Time Manipulation
    
    func testShiftEarlier() {
        XCTFail()
    }
    
    func testShiftLater() {
        XCTFail()
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
        XCTAssertTrue(controlChain.equals(group: testChain))
        XCTAssertTrue(controlChain == testChain)
    }
    
    
    // MARK: - Updates
    
    func testUpdateVariables() {
        
    }
    
}

