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
    
    override func setUp() {
        //Initialize control TimePeriodChain
        self.formatter.dateFormat = "yyyy MM dd HH:mm:ss.SSS"
        //Create test TimePeriods that are 1 year long
        let firstPeriod = TimePeriod(beginning: self.formatter.date(from: "2014 11 05 18:15:12.000")!, end: self.formatter.date(from: "2015 11 05 18:15:12.000")!)
        let secondPeriod: TimePeriod = TimePeriod(beginning: self.formatter.date(from: "2015 11 05 18:15:12.000")!, end: self.formatter.date(from: "2016 11 05 18:15:12.000")!)
        let thirdPeriod: TimePeriod = TimePeriod(beginning: self.formatter.date(from: "2016 11 05 18:15:12.000")!, end: self.formatter.date(from: "2017 11 05 18:15:12.000")!)
        //Add test periods
        self.controlChain.append(firstPeriod)
        self.controlChain.append(secondPeriod)
        self.controlChain.append(thirdPeriod)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    // MARK: - Chain Manipulation
    
    func testAppend() {
        
    }
    
    func testInsert() {
        
    }
    
    func testRemove() {
        
    }
    
    func testRemoveAll() {
        
    }
    
    func testMap() {
        
    }
    
    func testFilter() {
        
    }
    
    func testReduce() {
        
    }
    
    func testPop() {
        
    }
    
    
    // MARK: - Chain Time Manipulation
    
    func testShiftEarlier() {
        
    }
    
    func testShiftLater() {
        
    }
    
    
    // MARK: - Chain Relationship
    
    func testEquals() {
        
    }
    
    
    // MARK: - Updates
    
    func testUpdateVariables() {
        
    }
    
}

