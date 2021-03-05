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
    
    var formatter: DateFormatter?
    var date0: Date!
    var date1: Date!
    
    override func setUp() {
        super.setUp()
        
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
        let now: String = self.date0.timeAgo(since: self.date0)
        XCTAssert(!now.isEmpty, "'Now' is nil or empty.")
        let ago: String = self.date1.timeAgo(since: self.date0)
        XCTAssert(!ago.isEmpty, "Ago is nil or empty.")
    }
    
    func testLongTimeAgo2Days() {
        self.date0 = self.formatter?.date(from: "2014 11 05 18:15:12.000")
        self.date1 = self.formatter?.date(from: "2014 11 07 18:15:12.000")
        let ago: String = self.date0.timeAgo(since: self.date1)
        XCTAssertEqual(ago, DateToolsLocalizedStrings("2 days ago"))
    }
    
    func testLongTimeAgo1DayAndHalf() {
        self.date0 = self.formatter?.date(from: "2014 11 06 9:15:12.000")
        self.date1 = self.formatter?.date(from: "2014 11 07 18:15:12.000")
        let ago: String = self.date0.timeAgo(since: self.date1)
        XCTAssertEqual(ago, DateToolsLocalizedStrings("Yesterday"))
    }
    
    func testLongTimeAgoExactlyYesterday() {
        self.date0 = self.formatter?.date(from: "2014 11 06 18:15:12.000")
        self.date1 = self.formatter?.date(from: "2014 11 07 18:15:12.000")
        let ago: String = self.date0.timeAgo(since: self.date1)
        XCTAssertEqual(ago, DateToolsLocalizedStrings("Yesterday"))
    }
        
    func testLongTimeAgoLessThan24hoursSameDay() {
        self.date0 = self.formatter?.date(from: "2014 11 07 10:15:12.000")
        self.date1 = self.formatter?.date(from: "2014 11 07 18:15:12.000")
        let ago: String = self.date0.timeAgo(since: self.date1)
        XCTAssertEqual(ago, DateToolsLocalizedStrings("8 hours ago"))
    }
    
    func testLongTimeAgoBetween24And48Hours() {
        self.date0 = self.formatter?.date(from: "2014 11 07 10:15:12.000")
        self.date1 = self.formatter?.date(from: "2014 11 08 18:15:12.000")
        let ago: String = self.date0.timeAgo(since: self.date1)
        XCTAssertEqual(ago, DateToolsLocalizedStrings("Yesterday"))
    }
    
    func testBasicShortTimeAgo() {
        let now: String = self.date0.shortTimeAgo(since: self.date0)
        XCTAssert(!now.isEmpty, "'Now' is nil or empty.")
        let ago: String = self.date1.shortTimeAgo(since: self.date0)
        XCTAssert(!ago.isEmpty, "Ago is nil or empty.")
    }
    
    func testShortTimeAgo2Days() {
        self.date0 = self.formatter?.date(from: "2014 11 05 18:15:12.000")
        self.date1 = self.formatter?.date(from: "2014 11 07 18:15:12.000")
        let ago: String = self.date0.shortTimeAgo(since: self.date1)
        XCTAssertEqual(ago, DateToolsLocalizedStrings("2d"))
    }
    
    func testShortTimeAgo1DayAndHalf() {
        self.date0 = self.formatter?.date(from: "2014 11 06 9:15:12.000")
        self.date1 = self.formatter?.date(from: "2014 11 07 18:15:12.000")
        let ago: String = self.date0.shortTimeAgo(since: self.date1)
        XCTAssertEqual(ago, DateToolsLocalizedStrings("1d"))
    }
    
    func testShortTimeAgoExactlyYesterday() {
        self.date0 = self.formatter?.date(from: "2014 11 06 18:15:12.000")
        self.date1 = self.formatter?.date(from: "2014 11 07 18:15:12.000")
        let ago: String = self.date0.shortTimeAgo(since: self.date1)
        XCTAssertEqual(ago, DateToolsLocalizedStrings("1d"))
    }
    
    func testShortTimeAgoLessThan24hoursSameDay() {
        self.date0 = self.formatter?.date(from: "2014 11 07 10:15:12.000")
        self.date1 = self.formatter?.date(from: "2014 11 07 18:15:12.000")
        let ago: String = self.date0.shortTimeAgo(since: self.date1)
        XCTAssertEqual(ago, DateToolsLocalizedStrings("8h"))
    }
    
    func testShortTimeAgoBetween24And48Hours() {
        self.date0 = self.formatter?.date(from: "2014 11 07 10:15:12.000")
        self.date1 = self.formatter?.date(from: "2014 11 08 18:15:12.000")
        let ago: String = self.date0.shortTimeAgo(since: self.date1)
        XCTAssertEqual(ago, DateToolsLocalizedStrings("1d"))
    }
    
    class func japaneseBundle() -> Bundle {
      #if PACKAGE_MANAGER
      let assetPath = Bundle.module.resourcePath!
      #else
      let assetPath = Bundle(for: Constants.self).resourcePath!
      #endif

      return Bundle(path: NSString(string: assetPath).appendingPathComponent("DateTools.bundle/ja.lproj"))!
    }

    class func localizedString(key: String, localeIdentifier: String) -> String {
        guard let path = Bundle.dateToolsBundle().path(forResource: localeIdentifier, ofType: "lproj"),
            let bundle = Bundle(path: path) else {
                XCTFail("Missing localization for \(localeIdentifier)"); return ""
        }

        return bundle.localizedString(forKey: key, value: nil, table: "DateTools")

    }

    func testLongTimeAgoLocalizationsAccessible() {
        let en_local: String = "Yesterday"
        let ja_local: String = "昨日"
        let ja_result: String = TimeAgoTests.localizedString(key: en_local, localeIdentifier: "ja" )
        
        XCTAssertFalse(ja_result.isEmpty)
        XCTAssertEqual(ja_local, ja_result, "Could not access localizations.")
    }
}

