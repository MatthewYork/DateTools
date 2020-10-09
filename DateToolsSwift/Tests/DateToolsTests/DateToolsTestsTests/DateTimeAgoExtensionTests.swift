//
//  DateTimeAgoTests.swift
//  DateToolsTests
//
//  Created by Matthew York on 8/29/16.
//  Copyright © 2016 Matthew York. All rights reserved.
//

import XCTest
@testable import DateToolsSwift

class DateTimeAgoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testTimeAgo() {
        let testTimeAgo = Date().timeAgo(since: Date() - 60)
        XCTAssertTrue("A minute ago" == testTimeAgo)
    }
    
    func testShortTimeAgo() {
        let testTimeAgo = Date().shortTimeAgo(since: Date() - 4.minutes)
        XCTAssertTrue("4m" == testTimeAgo)
    }
    
    func testStaticTimeAgo() {
        let testTimeAgo =  Date.timeAgo(since: Date() - 3)
        XCTAssertTrue("3 seconds ago" == testTimeAgo)
    }
    
    func testStaticShortTimeAgo() {
        let testTimeAgo = Date.shortTimeAgo(since: Date() - 3.hours)
        XCTAssertTrue("3h" == testTimeAgo)
    }
    
    func testTimeAgoSinceNow() {
        let testTimeAgo = Date().timeAgoSinceNow
        XCTAssertTrue("Just now" == testTimeAgo)
    }
    
    func testShortTimeAgoSinceNow() {
        let testTimeAgo = Date().shortTimeAgoSinceNow
        XCTAssertTrue("0s" == testTimeAgo)
    }
    
    func testEarlierDate() {
        let testTimeAgo = Date()
        XCTAssertTrue(testTimeAgo.earlierDate(testTimeAgo + 2.seconds) == testTimeAgo)
        XCTAssertTrue((testTimeAgo - 3.minutes).earlierDate(testTimeAgo) == testTimeAgo - 3.minutes)
        XCTAssertTrue(testTimeAgo.earlierDate(testTimeAgo) == testTimeAgo)
    }
    
    func testLaterDate() {
        let testTimeAgo = Date()
        XCTAssertTrue(testTimeAgo.laterDate(testTimeAgo + 2.seconds) == testTimeAgo + 2.seconds)
        XCTAssertTrue((testTimeAgo - 3.minutes).laterDate(testTimeAgo) == testTimeAgo)
        XCTAssertTrue(testTimeAgo.laterDate(testTimeAgo) == testTimeAgo)
    }
    
    
    
}
