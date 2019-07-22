//
//  TimeAgoTests.swift
//  DateToolsTests
//
//  Created by Grayson Webster on 8/19/16.
//  Copyright © 2016 Matthew York. All rights reserved.
//

import XCTest
@testable import DateToolsSwift


class TimeAgoTests : XCTestCase {
    
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd HH:mm:ss.SSS"
        return formatter
    }()
    var date0: Date!
    var date1: Date!
    
    override func setUp() {
        super.setUp()
        
        date0 = formatter.date(from: "2014 11 05 18:15:12.000")
        date1 = formatter.date(from: "2014 11 07 18:15:12.000")
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testBasicLongTimeAgo() {
        let now: String = self.date0.timeAgo(since: self.date0)
        XCTAssertFalse(now.isEmpty, "'Now' is nil or empty.")
        let ago: String = self.date1.timeAgo(since: self.date0)
        XCTAssertFalse(ago.isEmpty, "Ago is nil or empty.")
    }
    
    func testLongTimeAgo2Days() {
        self.date0 = self.formatter.date(from: "2014 11 05 18:15:12.000")
        self.date1 = self.formatter.date(from: "2014 11 07 18:15:12.000")
        let ago: String = self.date0.timeAgo(since: self.date1)
        XCTAssertEqual(ago, DateToolsLocalizedStrings("2 days ago"))
    }
    
    func testLongTimeAgo1DayAndHalf() {
        self.date0 = self.formatter.date(from: "2014 11 06 9:15:12.000")
        self.date1 = self.formatter.date(from: "2014 11 07 18:15:12.000")
        let ago: String = self.date0.timeAgo(since: self.date1)
        XCTAssertEqual(ago, DateToolsLocalizedStrings("Yesterday"))
    }
    
    func testLongTimeAgoExactlyYesterday() {
        self.date0 = self.formatter.date(from: "2014 11 06 18:15:12.000")
        self.date1 = self.formatter.date(from: "2014 11 07 18:15:12.000")
        let ago: String = self.date0.timeAgo(since: self.date1)
        XCTAssertEqual(ago, DateToolsLocalizedStrings("Yesterday"))
    }
    
    func testLongTimeAgoLessThan24hoursButYesterday() {
        self.date0 = self.formatter.date(from: "2014 11 06 20:15:12.000")
        self.date1 = self.formatter.date(from: "2014 11 07 18:15:12.000")
        let ago: String = self.date0.timeAgo(since: self.date1)
        XCTAssertEqual(ago, DateToolsLocalizedStrings("22 hours ago"))
    }
    
    func testLongTimeAgoLessThan24hoursSameDay() {
        self.date0 = self.formatter.date(from: "2014 11 07 10:15:12.000")
        self.date1 = self.formatter.date(from: "2014 11 07 18:15:12.000")
        let ago: String = self.date0.timeAgo(since: self.date1)
        XCTAssertEqual(ago, DateToolsLocalizedStrings("8 hours ago"))
    }
    
    func testLongTimeAgoBetween24And48Hours() {
        self.date0 = self.formatter.date(from: "2014 11 07 10:15:12.000")
        self.date1 = self.formatter.date(from: "2014 11 08 18:15:12.000")
        let ago: String = self.date0.timeAgo(since: self.date1)
        XCTAssertEqual(ago, DateToolsLocalizedStrings("Yesterday"))
    }
    
    func testBasicShortTimeAgo() {
        let now: String = self.date0.shortTimeAgo(since: self.date0)
        XCTAssertFalse(now.isEmpty, "'Now' is nil or empty.")
        let ago: String = self.date1.shortTimeAgo(since: self.date0)
        XCTAssertFalse(ago.isEmpty, "Ago is nil or empty.")
    }
    
    func testShortTimeAgo2Days() {
        self.date0 = self.formatter.date(from: "2014 11 05 18:15:12.000")
        self.date1 = self.formatter.date(from: "2014 11 07 18:15:12.000")
        let ago: String = self.date0.shortTimeAgo(since: self.date1)
        XCTAssertEqual(ago, DateToolsLocalizedStrings("2d"))
    }
    
    func testShortTimeAgo1DayAndHalf() {
        self.date0 = self.formatter.date(from: "2014 11 06 9:15:12.000")
        self.date1 = self.formatter.date(from: "2014 11 07 18:15:12.000")
        let ago: String = self.date0.shortTimeAgo(since: self.date1)
        XCTAssertEqual(ago, DateToolsLocalizedStrings("1d"))
    }
    
    func testShortTimeAgoExactlyYesterday() {
        self.date0 = self.formatter.date(from: "2014 11 06 18:15:12.000")
        self.date1 = self.formatter.date(from: "2014 11 07 18:15:12.000")
        let ago: String = self.date0.shortTimeAgo(since: self.date1)
        XCTAssertEqual(ago, DateToolsLocalizedStrings("1d"))
    }
    
    func testShortTimeAgoLessThan24hoursButYesterday() {
        self.date0 = self.formatter.date(from: "2014 11 06 20:15:12.000")
        self.date1 = self.formatter.date(from: "2014 11 07 18:15:12.000")
        let ago: String = self.date0.shortTimeAgo(since: self.date1)
        XCTAssertEqual(ago, DateToolsLocalizedStrings("22h"))
    }
    
    func testShortTimeAgoLessThan24hoursSameDay() {
        self.date0 = self.formatter.date(from: "2014 11 07 10:15:12.000")
        self.date1 = self.formatter.date(from: "2014 11 07 18:15:12.000")
        let ago: String = self.date0.shortTimeAgo(since: self.date1)
        XCTAssertEqual(ago, DateToolsLocalizedStrings("8h"))
    }
    
    func testShortTimeAgoBetween24And48Hours() {
        self.date0 = self.formatter.date(from: "2014 11 07 10:15:12.000")
        self.date1 = self.formatter.date(from: "2014 11 08 18:15:12.000")
        let ago: String = self.date0.shortTimeAgo(since:self.date1)
        XCTAssertEqual(ago, DateToolsLocalizedStrings("1d"))
    }
    
    func testLongTimeAgoLocalizationsAccessible() {
        let en_local: String = "Yesterday"
        let ja_local: String = "昨日"
        let key: String = en_local
        let path: String = (Bundle.main.bundlePath as NSString).appendingPathComponent("DateTools.bundle/ja.lproj")
        var _: Bundle = Bundle(path: path)!
        let ja_result: String = NSLocalizedString(key, comment: "DateTools")
        XCTAssertEqual(ja_local, ja_result, "Could not access localizations.")
    }
    
    private func DateToolsLocalizedStrings(_ key: String) -> String {
        return NSLocalizedString(key,
                                 tableName: "DateTools",
                                 bundle: Bundle.dateToolsBundle(),
                                 value: "", comment: "")
    }
    
}

