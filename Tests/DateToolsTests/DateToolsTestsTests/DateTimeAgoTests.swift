//
//  DateTimeAgoTests.swift
//  DateToolsTests
//
//  Created by Matthew York on 8/29/16.
//  Copyright © 2016 Matthew York. All rights reserved.
//

import XCTest
@testable import DateToolsTests

class DateTimeAgoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTimeAgo() {
        let testTimeAgo = Date().timeAgo(since: Date() - 5)
        XCTAssertTrue("5 seconds ago" == testTimeAgo)
    }
    
    func testShortTimeAgo() {
        let testTimeAgo = Date().shortTimeAgo(since: Date() - 5)
        XCTAssertTrue("5s ago" == testTimeAgo)
    }
    
    func testStaticTimeAgo() {
        let testTimeAgo =  Date.timeAgo(since: Date() - 3)
        XCTAssertTrue("3 seconds ago" == testTimeAgo)
    }
    
    func testStaticShortTimeAgo() {
        let testTimeAgo = Date.shortTimeAgo(since: Date() - 3)
        XCTAssertTrue("3s ago" == testTimeAgo)
    }
    
    func testTimeAgoSinceNow() {
        let testTimeAgo = Date().timeAgoSinceNow
        XCTAssertTrue("0 seconds ago" == testTimeAgo)
    }
    
    func testShortTimeAgoSinceNow() {
        let testTimeAgo = Date().shortTimeAgoSinceNow
        XCTAssertTrue("0s ago" == testTimeAgo)
    }
    
    
    
}
