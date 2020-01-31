//
//  TimeAgoTests.swift
//  DateToolsTests
//
//  Created by Grayson Webster on 8/19/16.
//  Copyright © 2016 Matthew York. All rights reserved.
//

import XCTest
@testable import DateToolsTests


class TimeAgoTests : XCTestCase {
    
    var formatter: DateFormatter?
    var date0: Date?
    var date1: Date?
    
    override func setUp() {
        super.up = nil
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.formatter = DateFormatter()
        self.formatter?.dateFormat = "yyyy MM dd HH:mm:ss.SSS"
        self.date0 = self.formatter?.date(from: "2014 11 05 18:15:12.000")
        self.date1 = self.formatter?.date(from: "2014 11 07 18:15:12.000")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBasicLongTimeAgo() {
        var now: String = self.date0.timeAgoSinceDate(self.date0)
        XCTAssert(now && now.length > 0, "'Now' is nil or empty.")
        var ago: String = self.date1.timeAgoSinceDate(self.date0)
        XCTAssert(ago && ago.length > 0, "Ago is nil or empty.")
    }
    
    func testLongTimeAgo2Days() {
        self.date0 = self.formatter?.date(from: "2014 11 05 18:15:12.000")
        self.date1 = self.formatter?.date(from: "2014 11 07 18:15:12.000")
        var ago: String = self.date0.timeAgoSinceDate(self.date1)
        XCTAssertEqualObjects(ago, DateToolsLocalizedStrings("2 days ago"))
    }
    
    func testLongTimeAgo1DayAndHalf() {
        self.date0 = self.formatter?.date(from: "2014 11 06 9:15:12.000")
        self.date1 = self.formatter?.date(from: "2014 11 07 18:15:12.000")
        var ago: String = self.date0.timeAgoSinceDate(self.date1)
        XCTAssertEqualObjects(ago, DateToolsLocalizedStrings("Yesterday"))
    }
    
    func testLongTimeAgoExactlyYesterday() {
        self.date0 = self.formatter?.date(from: "2014 11 06 18:15:12.000")
        self.date1 = self.formatter?.date(from: "2014 11 07 18:15:12.000")
        var ago: String = self.date0.timeAgoSinceDate(self.date1)
        XCTAssertEqualObjects(ago, DateToolsLocalizedStrings("Yesterday"))
    }
    
    func testLongTimeAgoLessThan24hoursButYesterday() {
        self.date0 = self.formatter?.date(from: "2014 11 06 20:15:12.000")
        self.date1 = self.formatter?.date(from: "2014 11 07 18:15:12.000")
        var ago: String = self.date0.timeAgoSinceDate(self.date1)
        XCTAssertEqualObjects(ago, DateToolsLocalizedStrings("22 hours ago"))
    }
    
    func testLongTimeAgoLessThan24hoursSameDay() {
        self.date0 = self.formatter?.date(from: "2014 11 07 10:15:12.000")
        self.date1 = self.formatter?.date(from: "2014 11 07 18:15:12.000")
        var ago: String = self.date0.timeAgoSinceDate(self.date1)
        XCTAssertEqualObjects(ago, DateToolsLocalizedStrings("8 hours ago"))
    }
    
    func testLongTimeAgoBetween24And48Hours() {
        self.date0 = self.formatter?.date(from: "2014 11 07 10:15:12.000")
        self.date1 = self.formatter?.date(from: "2014 11 08 18:15:12.000")
        var ago: String = self.date0.timeAgoSinceDate(self.date1)
        XCTAssertEqualObjects(ago, DateToolsLocalizedStrings("Yesterday"))
    }
    
    func testBasicShortTimeAgo() {
        var now: String = self.date0.shortTimeAgoSinceDate(self.date0)
        XCTAssert(now && now.length > 0, "'Now' is nil or empty.")
        var ago: String = self.date1.shortTimeAgoSinceDate(self.date0)
        XCTAssert(ago && ago.length > 0, "Ago is nil or empty.")
    }
    
    func testShortTimeAgo2Days() {
        self.date0 = self.formatter?.date(from: "2014 11 05 18:15:12.000")
        self.date1 = self.formatter?.date(from: "2014 11 07 18:15:12.000")
        var ago: String = self.date0.shortTimeAgoSinceDate(self.date1)
        XCTAssertEqualObjects(ago, DateToolsLocalizedStrings("2d"))
    }
    
    func testShortTimeAgo1DayAndHalf() {
        self.date0 = self.formatter?.date(from: "2014 11 06 9:15:12.000")
        self.date1 = self.formatter?.date(from: "2014 11 07 18:15:12.000")
        var ago: String = self.date0.shortTimeAgoSinceDate(self.date1)
        XCTAssertEqualObjects(ago, DateToolsLocalizedStrings("1d"))
    }
    
    func testShortTimeAgoExactlyYesterday() {
        self.date0 = self.formatter?.date(from: "2014 11 06 18:15:12.000")
        self.date1 = self.formatter?.date(from: "2014 11 07 18:15:12.000")
        var ago: String = self.date0.shortTimeAgoSinceDate(self.date1)
        XCTAssertEqualObjects(ago, DateToolsLocalizedStrings("1d"))
    }
    
    func testShortTimeAgoLessThan24hoursButYesterday() {
        self.date0 = self.formatter?.date(from: "2014 11 06 20:15:12.000")
        self.date1 = self.formatter?.date(from: "2014 11 07 18:15:12.000")
        var ago: String = self.date0.shortTimeAgoSinceDate(self.date1)
        XCTAssertEqualObjects(ago, DateToolsLocalizedStrings("22h"))
    }
    
    func testShortTimeAgoLessThan24hoursSameDay() {
        self.date0 = self.formatter?.date(from: "2014 11 07 10:15:12.000")
        self.date1 = self.formatter?.date(from: "2014 11 07 18:15:12.000")
        var ago: String = self.date0.shortTimeAgoSinceDate(self.date1)
        XCTAssertEqualObjects(ago, DateToolsLocalizedStrings("8h"))
    }
    
    func testShortTimeAgoBetween24And48Hours() {
        self.date0 = self.formatter?.date(from: "2014 11 07 10:15:12.000")
        self.date1 = self.formatter?.date(from: "2014 11 08 18:15:12.000")
        var ago: String = self.date0.shortTimeAgoSinceDate(self.date1)
        XCTAssertEqualObjects(ago, DateToolsLocalizedStrings("1d"))
    }
    
    func testLongTimeAgoLocalizationsAccessible() {
        var en_local: String = "Yesterday"
        var ja_local: String = "昨日"
        var key: String = en_local
        var path: String = NSBundlemainBundle.bundlePath.stringByAppendingPathComponent("DateTools.bundle/ja.lproj")
        var bundle: Bundle = Bundle(path: path)!
        var ja_result: String = NSLocalizedStringFromTableInBundle(key, "DateTools", bundle, nil)
        XCTAssertEqualObjects(ja_local, ja_result, "Could not access localizations.")
    }
    
}

