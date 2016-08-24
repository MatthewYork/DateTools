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
    
    In DateTools, time periods are represented by the case TimePeriod class and come with a suite of initializaiton, manipulation, and comparison methods to make working with them a breeze.
 
    [Visit our github page](https://github.com/MatthewYork/DateTools#time-periods) for more information.
 */
class TimePeriod {
    
    // MARK: - Enums
    
    /**
         There may come a need, say when you are making a scheduling app, when it might be good to know how two time periods relate to one another. Are they the same? Is one inside of another? All these questions may be asked using the relationship methods of DTTimePeriod.
         
         Further reading: [GitHub](https://github.com/MatthewYork/DateTools#relationships), [CodeProject](http://www.codeproject.com/Articles/168662/Time-Period-Library-for-NET)
     */
    enum Relation {
        case after
        case startTouching
        case startInside
        case insideStartTouching
        case enclosingStartTouching
        case enclosing
        case enclosingEndTouching
        case exactMatch
        case inside
        case insideEndTouching
        case endInside
        case endTouching
        case before
        case none // One or more of the dates does not exist
    }
    
    
    /**
        Whether the time period is Open or Closed
     
        Closed: The boundary moment of time is included in calculations.
     
        Open: The boundary moment of time represents a boundary value which is excluded in regard to calculations.
     */
    enum Interval {
        case open
        case closed
    }
    
    /**
        When a time periods is lengthened or shortened, it does so anchoring one date of the time period and then changing the other one. There is also an option to anchor the centerpoint of the time period, changing both the start and end dates.
     */
    enum Anchor {
        case beginning
        case center
        case end
    }
    
    
    // MARK: - Variables
    
    /**
        The start date for a DTTimePeriod representing the starting boundary of the time period
     */
    var beginning: Date?
    
    /**
     *  The end date for a DTTimePeriod representing the ending boundary of the time period
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
        return false
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
        return false
    }
    
    func touches(period: TimePeriod) -> Bool {
        return false
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
    
    
    // MARK: - Shifts
    
    func shift(by interval: TimeInterval) {
        
    }
    
    func shift(by chunk: TimeChunk) {
        
    }
    
    
    // MARK: - Lengthen / Shorten
    
    func lengthen(by interval: TimeInterval, at anchor: Anchor) {
        
    }
    
    func lengthen(by chunk: TimeChunk, at anchor: Anchor) {
        
    }
    
    
    // MARK: - Copy
    
    func copy() -> TimePeriod {
        return TimePeriod()
    }
    
    
    // MARK: - Operator Overloads
    
    static func +(leftAddend: TimePeriod, rightAddend: TimePeriod) -> TimePeriod {
       return TimePeriod()
    }
    static func -(minuend: TimePeriod, subtrahend: TimePeriod) -> TimePeriod {
        return TimePeriod()
    }
    static func ==(left: TimePeriod, right: TimePeriod) -> Bool {
        return left.equals(period: right)
    }
}
