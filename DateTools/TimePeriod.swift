//
//  TimePeriod.swift
//  DateTools
//
//  Created by Grayson Webster on 8/17/16.
//  Copyright © 2016 Grayson Webster. All rights reserved.
//

import Foundation


/**
 # TimePeriod
 
 In DateTools, time periods are represented by the TimePeriod protocol. Required variables and method impleementations are bound below. An inheritable implementation of the TimePeriodProtocol is available through the TimePeriodClass
 
 [Visit our github page](https://github.com/MatthewYork/DateTools#time-periods) for more information.
 */
protocol TimePeriodProtocol {
    
    // MARK: - Variables
    
    /**
     The start date for a TimePeriod representing the starting boundary of the time period
     */
    var beginning: Date? {get set}
    
    /**
     *  The end date for a TimePeriod representing the ending boundary of the time period
     */
    var end: Date? {get set}
}

extension TimePeriodProtocol {
    
    
    // MARK: - Information
    
    var isMoment: Bool {
        return false
    }
    
    var years: TimeInterval {
        return 0
    }
    
    var weeks: TimeInterval {
        return 0
    }
    
    var days: TimeInterval {
        return 0
    }
    
    var hours: TimeInterval {
        return 0
    }
    
    var minutes: TimeInterval {
        return 0
    }
    
    var seconds: TimeInterval {
        return 0
    }
    
    var chunk: TimeChunk {
        return 0.days
    }
    
    var time: TimeInterval {
        return 0
    }
    
    
    // MARK: - Time Period Relationships
    
    func relation(to period: TimePeriod) -> Relation {
        return .none
    }
    
    func equals(period: TimePeriod) -> Bool {
        return self.beginning == period.beginning && self.end == period.end
    }
    
    func inside(of: TimePeriod) -> Bool {
        return false
    }
    
    func contains(date: Date, interval: Interval) -> Bool {
        return false
    }
    
    func contains(period: TimePeriod) -> Bool {
        return false
    }
    
    func overlaps(with period: TimePeriod) -> Bool {
        return false
    }
    
    func intersects(with period: TimePeriod) -> Bool {
        return self.relation(to: period) != .after && self.relation(to: period) != .before
    }
    
    func hasGap(between period: TimePeriod) -> Bool {
        return false
    }
    
    func gap(between period: TimePeriod) -> TimeInterval {
        return 0
    }
    
    func gap(between period: TimePeriod) -> TimeChunk {
        return 0.days
    }
    
    func isAfter(period: TimePeriod) -> Bool {
        return self.relation(to: period) == .after
    }
    
    func isBefore(period: TimePeriod) -> Bool {
        return self.relation(to: period) == .before
    }
    
    // MARK: - Shifts
    
    func shift(by interval: TimeInterval) {
        
    }
    
    func shift(by chunk: TimeChunk) {
        
    }
    
    // MARK: - Lengthen / Shorten
    
    // MARK: New
    
    func lengthened(by interval: TimeInterval, at anchor: Anchor) -> TimePeriod {
        return TimePeriod()
    }
    
    func lengthened(by chunk: TimeChunk, at anchor: Anchor) -> TimePeriod {
        return TimePeriod()
    }
    
    func shortened(by interval: TimeInterval, at anchor: Anchor) -> TimePeriod {
        return TimePeriod()
    }
    
    func shortened(by chunk: TimeChunk, at anchor: Anchor) -> TimePeriod {
        return TimePeriod()
    }
    
    // MARK: In Place
    // Do not lengthen by month at anchor center. Month cannot be divided reliably.
    
    func lengthen(by interval: TimeInterval, at anchor: Anchor) {
        
    }
    
    func lengthen(by chunk: TimeChunk, at anchor: Anchor) {
        
    }
    
    func shorten(by interval: TimeInterval, at anchor: Anchor) {
        
    }
    
    func shorten(by chunk: TimeChunk, at anchor: Anchor) {
        
    }
    
    
    // MARK: - Copy
    
    func copy() -> TimePeriod {
        return TimePeriod()
    }
    
    
    
}

/**
    # TimePeriod
    
    In DateTools, time periods are represented by the case TimePeriod class and come with a suite of initializaiton, manipulation, and comparison methods to make working with them a breeze.
 
    [Visit our github page](https://github.com/MatthewYork/DateTools#time-periods) for more information.
 */
class TimePeriod: TimePeriodProtocol {
    
    /**
     The start date for a TimePeriod representing the starting boundary of the time period
     */
    var beginning: Date?
    
    /**
     *  The end date for a TimePeriod representing the ending boundary of the time period
     */
    var end: Date?
    
    // MARK: - Initializers
    
    init() {
        
    }
    
    init(beginning:Date, end:Date) {
        self.beginning = beginning
        self.end = end
    }
    
    init(beginning: Date, duration: TimeInterval) {
        self.beginning = beginning
        self.end = beginning + duration
    }
    
    init(end: Date, duration: TimeInterval) {
        
    }
    
    init(beginning: Date, duration: TimeChunk) {
        self.beginning = beginning
        self.end = beginning + duration
    }
    
    init(end: Date, duration: TimeChunk) {
        
    }
    
    
    // MARK: - Operator Overloads
    
    // Default anchor = end
    static func +(leftAddend: TimePeriod, rightAddend: TimeInterval) -> TimePeriod {
       return leftAddend.lengthened(by: rightAddend, at: .end)
    }
    
    static func +(leftAddend: TimePeriod, rightAddend: TimeChunk) -> TimePeriod {
        return leftAddend.lengthened(by: rightAddend, at: .end)
    }
    
    // Default anchor = end
    static func -(minuend: TimePeriod, subtrahend: TimeInterval) -> TimePeriod {
        return minuend.shortened(by: subtrahend, at: .end)
    }
    
    static func -(minuend: TimePeriod, subtrahend: TimeChunk) -> TimePeriod {
        return minuend.shortened(by: subtrahend, at: .end)
    }
    
    static func ==(left: TimePeriod, right: TimePeriod) -> Bool {
        return left.equals(period: right)
    }
}
