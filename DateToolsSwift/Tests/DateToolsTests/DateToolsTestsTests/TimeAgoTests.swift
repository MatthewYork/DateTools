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
    var date0 = Date()
    var date1 = Date()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        do {
            self.date0 = try XCTUnwrap(self.formatter.date(from: "2014 11 05 18:15:12.000"))
            self.date1 = try XCTUnwrap(self.formatter.date(from: "2014 11 07 18:15:12.000"))
        } catch {
            XCTFail("Failed to format dates from string.")
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBasicLongTimeAgo() {
        let now: String = self.date0.timeAgo(since: self.date0)
        XCTAssertFalse(now.isEmpty, "'Now' is empty.")
        let ago: String = self.date1.timeAgo(since: self.date0)
        XCTAssertFalse(ago.isEmpty, "Ago is empty.")
    }
    
    func testLongTimeAgo2Days() throws {
        self.date0 = try XCTUnwrap(self.formatter.date(from: "2014 11 05 18:15:12.000"))
        self.date1 = try XCTUnwrap(self.formatter.date(from: "2014 11 07 18:15:12.000"))
        let ago: String = self.date0.timeAgo(since: self.date1)
        XCTAssertEqual(ago, try DateToolsLocalizedStrings("2 days ago"))
    }
    
    func testLongTimeAgo1DayAndHalf() throws {
        self.date0 = try XCTUnwrap(self.formatter.date(from: "2014 11 06 9:15:12.000"))
        self.date1 = try XCTUnwrap(self.formatter.date(from: "2014 11 07 18:15:12.000"))
        let ago: String = self.date0.timeAgo(since: self.date1)
        XCTAssertEqual(ago, try DateToolsLocalizedStrings("Yesterday"))
    }
    
    func testLongTimeAgoExactlyYesterday() throws {
        self.date0 = try XCTUnwrap(self.formatter.date(from: "2014 11 06 18:15:12.000"))
        self.date1 = try XCTUnwrap(self.formatter.date(from: "2014 11 07 18:15:12.000"))
        let ago: String = self.date0.timeAgo(since: self.date1)
        XCTAssertEqual(ago, try DateToolsLocalizedStrings("Yesterday"))
    }
    
    func testLongTimeAgoLessThan24hoursButYesterday() throws {
        self.date0 = try XCTUnwrap(self.formatter.date(from: "2014 11 07 00:15:12.000"))
        self.date1 = try XCTUnwrap(self.formatter.date(from: "2014 11 07 22:15:12.000"))
        let ago: String = self.date0.timeAgo(since: self.date1)
        XCTAssertEqual(ago, try DateToolsLocalizedStrings("22 hours ago"))
    }
    
    func testLongTimeAgoLessThan24hoursSameDay() throws {
        self.date0 = try XCTUnwrap(self.formatter.date(from: "2014 11 07 10:15:12.000"))
        self.date1 = try XCTUnwrap(self.formatter.date(from: "2014 11 07 18:15:12.000"))
        let ago: String = self.date0.timeAgo(since: self.date1)
        XCTAssertEqual(ago, try DateToolsLocalizedStrings("8 hours ago"))
    }
    
    func testLongTimeAgoBetween24And48Hours() throws {
        self.date0 = try XCTUnwrap(self.formatter.date(from: "2014 11 07 10:15:12.000"))
        self.date1 = try XCTUnwrap(self.formatter.date(from: "2014 11 08 18:15:12.000"))
        let ago: String = self.date0.timeAgo(since: self.date1)
        XCTAssertEqual(ago, try DateToolsLocalizedStrings("Yesterday"))
    }
    
    func testBasicShortTimeAgo() {
        let now: String = self.date0.shortTimeAgo(since: self.date0)
        XCTAssertFalse(now.isEmpty, "'Now' is empty.")
        let ago: String = self.date1.shortTimeAgo(since: self.date0)
        XCTAssertFalse(ago.isEmpty, "Ago is empty.")
    }
    
    func testShortTimeAgo2Days() throws {
        self.date0 = try XCTUnwrap(self.formatter.date(from: "2014 11 05 18:15:12.000"))
        self.date1 = try XCTUnwrap(self.formatter.date(from: "2014 11 07 18:15:12.000"))
        let ago: String = self.date0.shortTimeAgo(since: self.date1)
        XCTAssertEqual(ago, try DateToolsLocalizedStrings("2d"))
    }
    
    func testShortTimeAgo1DayAndHalf() throws {
        self.date0 = try XCTUnwrap(self.formatter.date(from: "2014 11 06 9:15:12.000"))
        self.date1 = try XCTUnwrap(self.formatter.date(from: "2014 11 07 18:15:12.000"))
        let ago: String = self.date0.shortTimeAgo(since: self.date1)
        XCTAssertEqual(ago, try DateToolsLocalizedStrings("1d"))
    }
    
    func testShortTimeAgoExactlyYesterday() throws {
        self.date0 = try XCTUnwrap(self.formatter.date(from: "2014 11 06 18:15:12.000"))
        self.date1 = try XCTUnwrap(self.formatter.date(from: "2014 11 07 18:15:12.000"))
        let ago: String = self.date0.shortTimeAgo(since: self.date1)
        XCTAssertEqual(ago, try DateToolsLocalizedStrings("1d"))
    }
    
    func testShortTimeAgoLessThan24hoursButYesterday() throws {
        self.date0 = try XCTUnwrap(self.formatter.date(from: "2014 11 07 00:15:12.000"))
        self.date1 = try XCTUnwrap(self.formatter.date(from: "2014 11 07 22:15:12.000"))
        let ago: String = self.date0.shortTimeAgo(since: self.date1)
        XCTAssertEqual(ago, try DateToolsLocalizedStrings("22h"))
    }
    
    func testShortTimeAgoLessThan24hoursSameDay() throws {
        self.date0 = try XCTUnwrap(self.formatter.date(from: "2014 11 07 10:15:12.000"))
        self.date1 = try XCTUnwrap(self.formatter.date(from: "2014 11 07 18:15:12.000"))
        let ago: String = self.date0.shortTimeAgo(since: self.date1)
        XCTAssertEqual(ago, try DateToolsLocalizedStrings("8h"))
    }
    
    func testShortTimeAgoBetween24And48Hours() throws {
        self.date0 = try XCTUnwrap(self.formatter.date(from: "2014 11 07 10:15:12.000"))
        self.date1 = try XCTUnwrap(self.formatter.date(from: "2014 11 08 18:15:12.000"))
        let ago: String = self.date0.shortTimeAgo(since: self.date1)
        XCTAssertEqual(ago, try DateToolsLocalizedStrings("1d"))
    }
    
    func testLongTimeAgoLocalizationsAccessible() throws {
        let en_local = "Yesterday"
        let ja_local = "昨日"
        let key = en_local
        let ja_result = try DateToolsLocalizedStrings(key, for: .japanese)
        XCTAssertEqual(ja_local, ja_result, "Could not access localizations.")
    }
}

extension XCTestCase {
    enum LanguageIdentifier: String {
        case english = "en"
        case japanese = "ja"
    }
    func DateToolsLocalizedStrings(_ key: String, for language: LanguageIdentifier = .english) throws -> String {
        let dateToolsBundlePath = try XCTUnwrap(Bundle.module.path(forResource: "DateTools", ofType: "bundle"))
        let dateToolsBundle = try XCTUnwrap(Bundle(path: dateToolsBundlePath))
        let path = try XCTUnwrap(dateToolsBundle.path(forResource: language.rawValue, ofType: "lproj"))
        let languageBundle = try XCTUnwrap(Bundle(path: path))
        return NSLocalizedString(key,
                                 tableName: "DateTools",
                                 bundle: languageBundle,
                                 value: "",
                                 comment: "")
    }
}
