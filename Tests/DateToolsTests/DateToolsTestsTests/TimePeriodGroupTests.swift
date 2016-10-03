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
        // Initialize control TimePeriodChain
        self.controlCollection = TimePeriodCollection()
        // Initialize formatter
        self.formatter.dateFormat = "yyyy MM dd HH:mm:ss.SSS"
        self.formatter.timeZone = TimeZone(abbreviation: "UTC")
        // Create test TimePeriods that are 1 year long
        firstPeriod = TimePeriod(beginning: self.formatter.date(from: "2014 11 05 18:15:12.000")!, end: self.formatter.date(from: "2015 11 05 18:15:12.000")!)
        secondPeriod = TimePeriod(beginning: self.formatter.date(from: "2015 11 05 18:15:12.000")!, end: self.formatter.date(from: "2016 11 05 18:15:12.000")!)
        thirdPeriod = TimePeriod(beginning: self.formatter.date(from: "2016 11 05 18:15:12.000")!, end: self.formatter.date(from: "2017 11 05 18:15:12.000")!)
        fourthPeriod = TimePeriod(beginning: self.formatter.date(from: "2015 4 05 18:15:12.000")!, end: self.formatter.date(from: "2017 4 05 18:15:12.000")!)
        // Add test periods
        self.controlCollection.append(firstPeriod)
        self.controlCollection.append(secondPeriod)
        self.controlCollection.append(thirdPeriod)
        self.controlCollection.append(fourthPeriod)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    // MARK: - Getters
    
    func testBeginning() {
        XCTAssertTrue(controlCollection.beginning == firstPeriod.beginning)
    }
    
    func testEnd() {
        XCTAssertTrue(controlCollection.end == thirdPeriod.end)
    }
    
    
    // MARK: - Group Info
    
    func testCount() {
        XCTAssertTrue(controlCollection.count == 4)
    }
    
    func testDuration() {
        XCTAssertEqual(94694400, self.controlCollection.duration)
    }
    
    
    // MARK: - Comparison
    
    func testSamePeriods() {
        let collectionSame: TimePeriodCollection = TimePeriodCollection()
        let chain: TimePeriodChain = TimePeriodChain()
        // Create test TimePeriods to construct same as control
        // Add test periods
        collectionSame.append(firstPeriod)
        collectionSame.append(secondPeriod)
        collectionSame.append(thirdPeriod)
        collectionSame.append(fourthPeriod)
        chain.append(firstPeriod)
        chain.append(secondPeriod)
        chain.append(thirdPeriod)
        chain.append(fourthPeriod)
        // Test same as control
        XCTAssertTrue(self.controlCollection.equals(group: collectionSame))
        // Test different collection
        collectionSame.append(firstPeriod)
        XCTAssertFalse(self.controlCollection.equals(group: collectionSame))
        // Test same chain with same periods
        XCTAssertTrue(self.controlCollection.equals(group: chain))
        // Test different chain
        chain.append(firstPeriod)
        XCTAssertFalse(self.controlCollection.equals(group: chain))
    }
    
    
    // MARK: - Mutations
    
    func testAppendPeriod() {
        let testPeriod = TimePeriod(beginning: self.formatter.date(from: "2014 11 05 18:15:12.000")!, end: self.formatter.date(from: "2015 11 05 18:15:12.000")!)
        controlCollection.append(testPeriod)
        XCTAssertTrue(controlCollection.count == 5)
    }
    
    func testAppendCollection() {
        let testCollection = TimePeriodCollection()
        testCollection.append(contentsOf: controlCollection)
        
    }
    
    
    // MARK: - Sequence Protocol 
    
    func testMakeIterator() {
        var testIterator = controlCollection.makeIterator()
        let testPeriod = testIterator.next()! as! TimePeriod
        XCTAssertTrue(testPeriod.equals(period: controlCollection[0] as! TimePeriod))
    }
    
    func testMap() {
        let saveDuration = controlCollection.duration
        let testCollection = controlCollection.map { (timePeriod) -> TimePeriodProtocol in
            timePeriod as! TimePeriod + 2.days
        }
        XCTAssertTrue(testCollection.duration == saveDuration + 2.days)
    }
}

