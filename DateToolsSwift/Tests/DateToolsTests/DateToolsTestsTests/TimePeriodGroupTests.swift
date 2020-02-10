//
//  TimePeriodGroupTests.swift
//  DateToolsTests
//
//  Created by Grayson Webster on 8/19/16.
//  Copyright © 2016 Matthew York. All rights reserved.
//

import XCTest
@testable import DateToolsSwift


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
        let testInterval = thirdPeriod.end?.timeIntervalSince(firstPeriod.beginning!)
        let controlInterval = self.controlCollection.duration
        XCTAssertEqual(testInterval, controlInterval)
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
        XCTAssertTrue(self.controlCollection.equals(collectionSame))
        // Test different collection
        collectionSame.append(firstPeriod)
        XCTAssertFalse(self.controlCollection.equals(collectionSame))
        // Test same chain with same periods
        // Test different chain
        chain.append(firstPeriod)
        XCTAssertFalse(self.controlCollection.equals(chain))
    }
    
    
    // MARK: - Sequence Protocol 
    
    func testMakeIterator() {
        var testIterator = controlCollection.makeIterator()
        let testPeriod = testIterator.next()! as! TimePeriod
        XCTAssertTrue(testPeriod.equals(controlCollection[0] as! TimePeriod))
    }
    
    func testMap() {
        let saveDuration = controlCollection.duration
        let testCollection = controlCollection.map { (timePeriod) -> TimePeriodProtocol in
            timePeriod as! TimePeriod + 2.days
        }
        
        XCTAssertTrue(testCollection.duration == saveDuration! + 2 * 24 * 60 * 60)
    }
    
    func testFilter() {
        let testCollectionArray = controlCollection.filter { (timePeriod) -> Bool in
            timePeriod.isAfter(period: TimePeriod(beginning: Date.init(dateString: "2014 11 05 18:15:12.000", format: "yyyy MM dd HH:mm:ss.SSS"), duration: 1))
        }
        let testPeriod = TimePeriod(beginning: self.formatter.date(from: "2014 11 05 18:15:12.000")!, end: self.formatter.date(from: "2015 4 05 18:15:12.000")!)
        let newDuration = controlCollection.duration! - TimeInterval(testPeriod.seconds)
        let testCollection = TimePeriodCollection()
        testCollection.append(testCollectionArray)
        XCTAssertTrue(testCollection.duration == newDuration)
    }
    
    func testForEach() {
        let testCollection = TimePeriodCollection()
        for period in controlCollection {
            testCollection.append(period)
        }
        XCTAssert(testCollection.equals(controlCollection))
    }
    
    func testSplit() {
        let testCollectionSplit = controlCollection.split(maxSplits: 1, omittingEmptySubsequences: false) { (timePeriod) -> Bool in
            timePeriod.contains(self.formatter.date(from: "2016 12 05 18:15:12.000")!, interval: .closed)
        }
        let testCollection = TimePeriodCollection()
        let testCollection2 = TimePeriodCollection()
        for period in testCollectionSplit[0] {
            testCollection.append(period)
        }
        for period in testCollectionSplit[1] {
            testCollection2.append(period)
        }
        let testPeriod = TimePeriod(beginning: self.formatter.date(from: "2014 11 05 18:15:12.000")!, end: self.formatter.date(from: "2016 11 05 18:15:12.000")!)
        let testPeriod2 = TimePeriod(beginning: self.formatter.date(from: "2015 4 05 18:15:12.000")!, end: self.formatter.date(from: "2017 4 05 18:15:12.000")!)
        XCTAssertTrue(testCollection.duration == TimeInterval(testPeriod.seconds))
        XCTAssertTrue(testCollection2.duration == TimeInterval(testPeriod2.seconds))
    }
}

