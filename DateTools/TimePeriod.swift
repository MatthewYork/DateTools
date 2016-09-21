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
public protocol TimePeriodProtocol {
    
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

public extension TimePeriodProtocol {
    
    
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
    
    var duration: TimeInterval {
        return 0
    }
    
    
    // MARK: - Time Period Relationships
    
    func relation(to period: TimePeriodProtocol) -> Relation {
        return .none
    }
    
    func equals(period: TimePeriodProtocol) -> Bool {
        return self.beginning == period.beginning && self.end == period.end
    }
    
    func inside(of: TimePeriodProtocol) -> Bool {
        return false
    }
    
    func contains(date: Date, interval: Interval) -> Bool {
        return false
    }
    
    func contains(period: TimePeriodProtocol) -> Bool {
        return false
    }
    
    func overlaps(with period: TimePeriodProtocol) -> Bool {
        return false
    }
    
    func intersects(with period: TimePeriodProtocol) -> Bool {
        return self.relation(to: period) != .after && self.relation(to: period) != .before
    }
    
    func hasGap(between period: TimePeriodProtocol) -> Bool {
        return false
    }
    
    func gap(between period: TimePeriodProtocol) -> TimeInterval {
        return 0
    }
    
    func gap(between period: TimePeriodProtocol) -> TimeChunk {
        return 0.days
    }
    
    func isAfter(period: TimePeriodProtocol) -> Bool {
        return self.relation(to: period) == .after
    }
    
    func isBefore(period: TimePeriodProtocol) -> Bool {
        return self.relation(to: period) == .before
    }
    
    // MARK: - Shifts
    
    func shift(by interval: TimeInterval) {
        
    }
    
    func shift(by chunk: TimeChunk) {
        
    }
    
    // MARK: - Lengthen / Shorten
    
    // MARK: New
    
    func lengthened(by interval: TimeInterval, at anchor: Anchor) -> TimePeriodProtocol {
        return TimePeriod()
    }
    
    func lengthened(by chunk: TimeChunk, at anchor: Anchor) -> TimePeriodProtocol {
        return TimePeriod()
    }
    
    func shortened(by interval: TimeInterval, at anchor: Anchor) -> TimePeriodProtocol {
        return TimePeriod()
    }
    
    func shortened(by chunk: TimeChunk, at anchor: Anchor) -> TimePeriodProtocol {
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
open class TimePeriod: TimePeriodProtocol {
    
    /**
     The start date for a TimePeriod representing the starting boundary of the time period
     */
    public var beginning: Date?
    
    /**
     *  The end date for a TimePeriod representing the ending boundary of the time period
     */
    public var end: Date?
    
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
        self.end = end
        self.beginning = end.addingTimeInterval(-duration)
    }
    
    init(beginning: Date, duration: TimeChunk) {
        self.beginning = beginning
        self.end = beginning + duration
    }
    
    init(end: Date, duration: TimeChunk) {
        self.end = end
        self.beginning = end - duration
    }
    
    init(chunk: TimeChunk) {
        self.beginning = Date()
        self.end = self.beginning?.add(chunk)
    }
    
    // MARK: - Operator Overloads
    
    // Default anchor = end
    static func +(leftAddend: TimePeriod, rightAddend: TimeInterval) -> TimePeriod {
       return leftAddend.lengthened(by: rightAddend, at: .end) as! TimePeriod
    }
    
    static func +(leftAddend: TimePeriod, rightAddend: TimeChunk) -> TimePeriod {
        return leftAddend.lengthened(by: rightAddend, at: .end) as! TimePeriod
    }
    
    // Default anchor = end
    static func -(minuend: TimePeriod, subtrahend: TimeInterval) -> TimePeriod {
        return minuend.shortened(by: subtrahend, at: .end) as! TimePeriod
    }
    
    static func -(minuend: TimePeriod, subtrahend: TimeChunk) -> TimePeriod {
        return minuend.shortened(by: subtrahend, at: .end) as! TimePeriod
    }
    
    static func ==(left: TimePeriod, right: TimePeriod) -> Bool {
        return left.equals(period: right)
    }
}
