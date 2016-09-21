//
//  DateComponents.swift
//  DateToolsTests
//
//  Created by Matthew York on 8/29/16.
//  Copyright © 2016 Matthew York. All rights reserved.
//

import XCTest

class DateComponentsTests: XCTestCase {
    
    var controlDate = Date()
    var formatter = DateFormatter()
    
    override func setUp() {
        super.setUp()
        formatter.dateFormat = "yyyy MM dd HH:mm:ss.SSS"
        self.controlDate = formatter.date(from: "2014 11 05 18:15:12.000")!
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    
}
