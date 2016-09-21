//
//  TimePeriodCollectionTests.swift
//  DateToolsTests
//
//  Created by Grayson Webster on 8/19/16.
//  Copyright © 2016 Matthew York. All rights reserved.
//

import XCTest
@testable import DateToolsTests


class TimePeriodCollectionTests : XCTestCase {
    
    var formatter = DateFormatter()
    var controlCollection = TimePeriodCollection()
    
    override func setUp() {
        //Initialize formatter
        self.formatter.dateFormat = "yyyy MM dd HH:mm:ss.SSS"
        //Create test TimePeriods that are 1 year long
        let firstPeriod = TimePeriod(beginning: self.formatter.date(from: "2015 4 05 18:15:12.000")!, end: self.formatter.date(from: "2017 4 05 18:15:12.000")!)
        let secondPeriod = TimePeriod(beginning: self.formatter.date(from: "2014 11 05 18:15:12.000")!, end: self.formatter.date(from: "2015 11 05 18:15:12.000")!)
        let thirdPeriod = TimePeriod(beginning: self.formatter.date(from: "2015 11 05 18:15:12.000")!, end: self.formatter.date(from: "2016 11 05 18:15:12.000")!)
        let fourthPeriod = TimePeriod(beginning: self.formatter.date(from: "2016 11 05 18:15:12.000")!, end: self.formatter.date(from: "2017 11 05 18:15:12.000")!)
        
        //Add test periods
        self.controlCollection.append(firstPeriod)
        self.controlCollection.append(secondPeriod)
        self.controlCollection.append(thirdPeriod)
        self.controlCollection.append(fourthPeriod)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    // MARK: - Collection Manipulation
    
    func testRemove() {
        controlCollection.remove(at: 3)
        XCTAssertTrue(controlCollection.count == 3)
    }
    
    func testRemoveAll() {
        controlCollection.removeAll()
        XCTAssertTrue(controlCollection.count == 0)
    }
    
    func testInsert() {
        let testPeriod = TimePeriod(beginning: self.formatter.date(from: "2015 4 05 18:15:12.000")!, end: self.formatter.date(from: "2017 4 05 18:15:12.000")!)
        controlCollection.insert(testPeriod, at: 0)
        XCTAssertTrue(controlCollection[0] as! TimePeriod == testPeriod)
    }
    
    
    // MARK: - Sorting
    
    func testSort() {
        XCTAssertFalse(controlCollection[0].beginning! < controlCollection[1].beginning!)
        controlCollection.sort()
        XCTAssertTrue(controlCollection[0].beginning! < controlCollection[1].beginning!)
    }
    
    func testSorted() {
        let testCollection = controlCollection.sorted()
        XCTAssertFalse(testCollection[0].beginning == controlCollection[0].beginning)
        controlCollection.sort()
        XCTAssertTrue(testCollection[0].beginning == controlCollection[0].beginning)
    }
    
    
    // MARK: - Collection Relationship
    
    func testAllInside() {
        let failPeriod = TimePeriod(beginning: self.formatter.date(from: "2015 11 05 18:15:12.000")!, end: self.formatter.date(from: "2020 11 05 18:15:12.000")!)
        let successPeriod = TimePeriod(beginning: self.formatter.date(from: "2010 11 05 18:15:12.000")!, end: self.formatter.date(from: "2020 11 05 18:15:12.000")!)
        XCTAssertFalse(controlCollection.allInside(in: failPeriod) == controlCollection)
        XCTAssertTrue(controlCollection.allInside(in: successPeriod) == controlCollection)
    }
    
    func testPeriodsIntersectedByDate() {
        let failDate = self.formatter.date(from: "2020 11 05 18:15:12.000")!
        let successDate = self.formatter.date(from: "2015 10 05 18:15:12.000")!
        XCTAssertFalse(controlCollection.periodsIntersected(by: failDate).count == 3)
        XCTAssertTrue(controlCollection.periodsIntersected(by: successDate).count == 3)
    }
    
    func testPeriodsIntersectedByTimePeriod() {
        let failPeriod = TimePeriod(beginning: self.formatter.date(from: "2020 11 05 18:15:12.000")!, end: self.formatter.date(from: "2021 11 05 18:15:12.000")!)
        let successPeriod = TimePeriod(beginning: self.formatter.date(from: "2015 9 05 18:15:12.000")!, end: self.formatter.date(from: "2015 10 05 18:15:12.000")!)
        XCTAssertFalse(controlCollection.periodsIntersected(by: failPeriod).count == 2)
        XCTAssertTrue(controlCollection.periodsIntersected(by: successPeriod).count == 2)
    }
    
    func testEquals() {
        let testCollection = controlCollection
        XCTAssertTrue(testCollection.equals(group: controlCollection))
    }
    
    
    // MARK: - Map, Filter, Reduce
    
    
    // MARK: - Operator Overloads
    
    func testEqualsOperator() {
        let testCollection = controlCollection
        XCTAssertTrue(testCollection == controlCollection)
    }
}

