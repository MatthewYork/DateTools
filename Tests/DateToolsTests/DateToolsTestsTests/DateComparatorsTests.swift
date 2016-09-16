//
//  DateComparators.swift
//  DateToolsTests
//
//  Created by Matthew York on 8/29/16.
//  Copyright © 2016 Matthew York. All rights reserved.
//

import XCTest
@testable import DateToolsTests

class DateComparatorsTests: XCTestCase {
    
    var controlDate = Date()
    var formatter = DateFormatter()
    
    override func setUp() {
        super.setUp()
        
        self.formatter.dateFormat = "yyyy MM dd HH:mm:ss.SSS"
        self.controlDate = self.formatter.date(from: "2016 09 16 13:30:25.000")!
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testChunkBetweenFuture() {
        let testDate1 = self.formatter.date(from: "2018 09 16 13:30:25.000")!
        var resultChunk = self.controlDate.chunkBetween(date: testDate1)
        XCTAssertTrue(resultChunk.years == 2)
        let testDate2 = self.formatter.date(from: "2018 08 14 13:30:25.000")!
        resultChunk = self.controlDate.chunkBetween(date: testDate2)
        print(resultChunk)
        XCTAssertTrue(resultChunk.years == 1 && resultChunk.months == 10 && resultChunk.days == 28)
    }
    
    func testChunkBetweenPast() {
        
    }
    
}
