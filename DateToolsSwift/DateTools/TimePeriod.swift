//
//  TimePeriod.swift
//  DateTools
//
//  Created by Grayson Webster on 8/17/16.
//  Copyright © 2016 Grayson Webster. All rights reserved.
//

import Foundation



/**
 *  In DateTools, time periods are represented by the TimePeriod protocol. 
 *  Required variables and method impleementations are bound below. An inheritable 
 *  implementation of the TimePeriodProtocol is available through the TimePeriodClass
 *
 *  [Visit our github page](https://github.com/MatthewYork/DateTools#time-periods) for more information.
 */
public protocol TimePeriodProtocol {
    
    // MARK: - Variables
    
    /**
     *  The start date for a TimePeriod representing the starting boundary of the time period
     */
    var beginning: Date? {get set}
    
    /**
     *  The end date for a TimePeriod representing the ending boundary of the time period
     */
    var end: Date? {get set}
}

public extension TimePeriodProtocol {
    
    
    // MARK: - Information
    
    /**
     *  True if the `TimePeriod`'s duration is zero
     */
    public var isMoment: Bool {
        return self.beginning == self.end
    }
    
    /**
     *  The duration of the `TimePeriod` in years.
     *  Returns the max int if beginning or end are nil.
     */
    public var years: Int {
        if self.beginning != nil && self.end != nil {
            return self.beginning!.yearsEarlier(than: self.end!)
        }
        return Int.max
    }
    
    /**
     *  The duration of the `TimePeriod` in weeks.
     *  Returns the max int if beginning or end are nil.
     */
    public var weeks: Int {
        if self.beginning != nil && self.end != nil {
            return self.beginning!.weeksEarlier(than: self.end!)
        }
        return Int.max
    }
    
    /**
     *  The duration of the `TimePeriod` in days.
     *  Returns the max int if beginning or end are nil.
     */
    public var days: Int {
        if self.beginning != nil && self.end != nil {
            return self.beginning!.daysEarlier(than: self.end!)
        }
        return Int.max
    }
    
    /**
     *  The duration of the `TimePeriod` in hours.
     *  Returns the max int if beginning or end are nil.
     */
    public var hours: Int {
        if self.beginning != nil && self.end != nil {
            return self.beginning!.hoursEarlier(than: self.end!)
        }
        return Int.max
    }
    
    /**
     *  The duration of the `TimePeriod` in minutes.
     *  Returns the max int if beginning or end are nil.
     */
    public var minutes: Int {
        if self.beginning != nil && self.end != nil {
            return self.beginning!.minutesEarlier(than: self.end!)
        }
        return Int.max
    }
    
    /**
     *  The duration of the `TimePeriod` in seconds.
     *  Returns the max int if beginning or end are nil.
     */
    public var seconds: Int {
        if self.beginning != nil && self.end != nil {
            return self.beginning!.secondsEarlier(than: self.end!)
        }
        return Int.max
    }
    
    /**
     *  The duration of the `TimePeriod` in a time chunk.
     *  Returns a time chunk with all zeroes if beginning or end are nil.
     */
    public var chunk: TimeChunk {
        if beginning != nil && end != nil {
            return beginning!.chunkBetween(date: end!)
        }
        return TimeChunk(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: 0, years: 0)
    }
    
    /**
     *  The length of time between the beginning and end dates of the
     * `TimePeriod` as a `TimeInterval`.
     */
    public var duration: TimeInterval {
        if self.beginning != nil && self.end != nil {
            return abs(self.beginning!.timeIntervalSince(self.end!))
        }
        #if os(Linux)
            return TimeInterval(Double.greatestFiniteMagnitude)
        #else
            return TimeInterval(Double.greatestFiniteMagnitude)
        #endif
    }
    
    
    // MARK: - Time Period Relationships
    
    /**
     *  The relationship of the self `TimePeriod` to the given `TimePeriod`.
     *  Relations are stored in Enums.swift. Formal defnitions available in the provided
     *  links:
     *  [GitHub](https://github.com/MatthewYork/DateTools#relationships),
     *  [CodeProject](http://www.codeproject.com/Articles/168662/Time-Period-Library-for-NET)
     *  
     * - parameter period: The time period to compare to self
     *  
     * - returns: The relationship between self and the given time period
     */
    public func relation(to period: TimePeriodProtocol) -> Relation {
        //Make sure that all start and end points exist for comparison
        if (self.beginning != nil && self.end != nil && period.beginning != nil && period.end != nil) {
            //Make sure time periods are of positive durations
            if (self.beginning!.isEarlier(than: self.end!) && period.beginning!.isEarlier(than: period.end!)) {
                
                //Make comparisons
                if (period.end!.isEarlier(than: self.beginning!)) {
                    return .after
                }
                else if (period.end!.equals(self.beginning!)) {
                    return .startTouching
                }
                else if (period.beginning!.isEarlier(than: self.beginning!) && period.end!.isEarlier(than: self.end!)) {
                    return .startInside
                }
                else if (period.beginning!.equals(self.beginning!) && period.end!.isLater(than: self.end!)) {
                    return .insideStartTouching
                }
                else if (period.beginning!.equals(self.beginning!) && period.end!.isEarlier(than: self.end!)) {
                    return .enclosingStartTouching
                }
                else if (period.beginning!.isLater(than: self.beginning!) && period.end!.isEarlier(than: self.end!)) {
                    return .enclosing
                }
                else if (period.beginning!.isLater(than: self.beginning!) && period.end!.equals(self.end!)) {
                    return .enclosingEndTouching
                }
                else if (period.beginning!.equals(self.beginning!) && period.end!.equals(self.end!)) {
                    return .exactMatch
                }
                else if (period.beginning!.isEarlier(than: self.beginning!) && period.end!.isLater(than: self.end!)) {
                    return .inside
                }
                else if (period.beginning!.isEarlier(than: self.beginning!) && period.end!.equals(self.end!)) {
                    return .insideEndTouching
                }
                else if (period.beginning!.isEarlier(than: self.end!) && period.end!.isLater(than: self.end!)) {
                    return .endInside
                }
                else if (period.beginning!.equals(self.end!) && period.end!.isLater(than: self.end!)) {
                    return .endTouching
                }
                else if (period.beginning!.isLater(than: self.end!)) {
                    return .before
                }
            }
        }
        
        return .none;
    }
    
    /**
     *  If `self.beginning` and `self.end` are equal to the beginning and end of the
     *  given `TimePeriod`.
     *
     * - parameter period: The time period to compare to self
     *
     * - returns: True if the periods are the same
     */
    public func equals(_ period: TimePeriodProtocol) -> Bool {
        return self.beginning == period.beginning && self.end == period.end
    }
    
    /**
     *  If the given `TimePeriod`'s beginning is before `self.beginning` and
     *  if the given 'TimePeriod`'s end is after `self.end`.
     *
     * - parameter period: The time period to compare to self
     *
     * - returns: True if self is inside of the given `TimePeriod`
     */
    public func isInside(of period: TimePeriodProtocol) -> Bool {
        return period.beginning!.isEarlierThanOrEqual(to: self.beginning!) && period.end!.isLaterThanOrEqual(to: self.end!)
    }
    
    /**
     *  If the given Date is after `self.beginning` and before `self.end`.
     *
     * - parameter period: The time period to compare to self
     * - parameter interval: Whether the edge of the date is included in the calculation
     *
     * - returns: True if the given `TimePeriod` is inside of self
     */
    public func contains(_ date: Date, interval: Interval) -> Bool {
        if (interval == .open) {
            return self.beginning!.isEarlier(than: date) && self.end!.isLater(than: date)
        }
        else if (interval == .closed){
            return (self.beginning!.isEarlierThanOrEqual(to: date) && self.end!.isLaterThanOrEqual(to: date))
        }
        
        return false
    }
    
    /**
     *  If the given `TimePeriod`'s beginning is after `self.beginning` and
     *  if the given 'TimePeriod`'s after is after `self.end`.
     *
     * - parameter period: The time period to compare to self
     *
     * - returns: True if the given `TimePeriod` is inside of self
     */
    public func contains(_ period: TimePeriodProtocol) -> Bool {
        return self.beginning!.isEarlierThanOrEqual(to: period.beginning!) && self.end!.isLaterThanOrEqual(to: period.end!)
    }
    
    /**
     *  If self and the given `TimePeriod` share any sub-`TimePeriod`.
     *
     * - parameter period: The time period to compare to self
     *
     * - returns: True if there is a period of time that is shared by both `TimePeriod`s
     */
    public func overlaps(with period: TimePeriodProtocol) -> Bool {
        //Outside -> Inside
        if (period.beginning!.isEarlier(than: self.beginning!) && period.end!.isLater(than: self.beginning!)) {
            return true
        }
            //Enclosing
        else if (period.beginning!.isLaterThanOrEqual(to: self.beginning!) && period.end!.isEarlierThanOrEqual(to: self.end!)){
            return true
        }
            //Inside -> Out
        else if(period.beginning!.isEarlier(than: self.end!) && period.end!.isLater(than: self.end!)){
            return true
        }
        return false
    }
    
    /**
     *  If self and the given `TimePeriod` overlap or the period's edges touch.
     *
     * - parameter period: The time period to compare to self
     *
     * - returns: True if there is a period of time or moment that is shared by both `TimePeriod`s
     */
    public func intersects(with period: TimePeriodProtocol) -> Bool {
        return self.relation(to: period) != .after && self.relation(to: period) != .before
    }
    
    /**
     *  If self and the given `TimePeriod` have no overlap or touching edges.
     *
     * - parameter period: The time period to compare to self
     *
     * - returns: True if there is a period of time between self and the given `TimePeriod` not contained by either period
     */
    public func hasGap(between period: TimePeriodProtocol) -> Bool {
        return self.isBefore(period: period) || self.isAfter(period: period)
    }
    
    /**
     *  The period of time between self and the given `TimePeriod` not contained by either.
     *
     * - parameter period: The time period to compare to self
     *
     * - returns: The gap between the periods. Zero if there is no gap.
     */
    public func gap(between period: TimePeriodProtocol) -> TimeInterval {
        if (self.end!.isEarlier(than: period.beginning!)) {
            return abs(self.end!.timeIntervalSince(period.beginning!));
        }
        else if (period.end!.isEarlier(than: self.beginning!)){
            return abs(period.end!.timeIntervalSince(self.beginning!));
        }
        return 0
    }
    
    /**
     *  The period of time between self and the given `TimePeriod` not contained by either
     *  as a `TimeChunk`.
     *
     * - parameter period: The time period to compare to self
     *
     * - returns: The gap between the periods, zero if there is no gap
     */
    public func gap(between period: TimePeriodProtocol) -> TimeChunk? {
        if self.end != nil && period.beginning != nil {
            return (self.end?.chunkBetween(date: period.beginning!))!
        }
        return nil
    }
    
    /**
     *  If self is after the given `TimePeriod` chronologically. (A gap must exist between the two).
     *
     * - parameter period: The time period to compare to self
     *
     * - returns: True if self is after the given `TimePeriod`
     */
    public func isAfter(period: TimePeriodProtocol) -> Bool {
        return self.relation(to: period) == .after
    }
    
    /**
     *  If self is before the given `TimePeriod` chronologically. (A gap must exist between the two).
     *
     * - parameter period: The time period to compare to self
     *
     * - returns: True if self is after the given `TimePeriod`
     */
    public func isBefore(period: TimePeriodProtocol) -> Bool {
        return self.relation(to: period) == .before
    }
    
    // MARK: - Shifts
    
    //MARK: In Place
    
    /**
     *  In place, shift the `TimePeriod` by a `TimeInterval`
     *
     * - parameter timeInterval: The time interval to shift the period by
     */
    public mutating func shift(by timeInterval: TimeInterval) {
        self.beginning?.addTimeInterval(timeInterval)
        self.end?.addTimeInterval(timeInterval)
    }
    
    /**
     *  In place, shift the `TimePeriod` by a `TimeChunk`
     *
     * - parameter chunk: The time chunk to shift the period by
     */
    public mutating func shift(by chunk: TimeChunk) {
        self.beginning = self.beginning?.add(chunk)
        self.end = self.end?.add(chunk)
    }
    
    // MARK: - Lengthen / Shorten
    
    // MARK: In Place
    
    
    /**
     *  In place, lengthen the `TimePeriod`, anchored at the beginning, end or center
     *
     * - parameter timeInterval: The time interval to lengthen the period by
     * - parameter anchor: The anchor point from which to make the change
     */
    public mutating func lengthen(by timeInterval: TimeInterval, at anchor: Anchor) {
        switch anchor {
        case .beginning:
            self.end = self.end?.addingTimeInterval(timeInterval)
            break
        case .center:
            self.beginning = self.beginning?.addingTimeInterval(-timeInterval/2.0)
            self.end = self.end?.addingTimeInterval(timeInterval/2.0)
            break
        case .end:
            self.beginning = self.beginning?.addingTimeInterval(-timeInterval)
            break
        }
    }
    
    /**
     *  In place, lengthen the `TimePeriod`, anchored at the beginning or end
     *
     * - parameter chunk: The time chunk to lengthen the period by
     * - parameter anchor: The anchor point from which to make the change
     */
    public mutating func lengthen(by chunk: TimeChunk, at anchor: Anchor) {
        switch anchor {
        case .beginning:
            self.end = self.end?.add(chunk)
            break
        case .center:
            // Do not lengthen by TimeChunk at center
            print("Mutation via chunk from center anchor is not supported.")
            break
        case .end:
            self.beginning = self.beginning?.subtract(chunk)
            break
        }
    }
    
    /**
     *  In place, shorten the `TimePeriod`, anchored at the beginning, end or center
     *
     * - parameter timeInterval: The time interval to shorten the period by
     * - parameter anchor: The anchor point from which to make the change
     */
    public mutating func shorten(by timeInterval: TimeInterval, at anchor: Anchor) {
        switch anchor {
        case .beginning:
            self.end = self.end?.addingTimeInterval(-timeInterval)
            break
        case .center:
            self.beginning = self.beginning?.addingTimeInterval(timeInterval/2.0)
            self.end = self.end?.addingTimeInterval(-timeInterval/2.0)
            break
        case .end:
            self.beginning = self.beginning?.addingTimeInterval(timeInterval)
            break
        }
    }
    
    /**
     *  In place, shorten the `TimePeriod`, anchored at the beginning or end
     *
     * - parameter chunk: The time chunk to shorten the period by
     * - parameter anchor: The anchor point from which to make the change
     */
    public mutating func shorten(by chunk: TimeChunk, at anchor: Anchor) {
        switch anchor {
        case .beginning:
            self.end = self.end?.subtract(chunk)
            break
        case .center:
            // Do not shorten by TimeChunk at center
            print("Mutation via chunk from center anchor is not supported.")
            break
        case .end:
            self.beginning = self.beginning?.add(chunk)
            break
        }
    }
}

/**
 *  In DateTools, time periods are represented by the case TimePeriod class
 *  and come with a suite of initializaiton, manipulation, and comparison methods 
 *  to make working with them a breeze.
 *
 *  [Visit our github page](https://github.com/MatthewYork/DateTools#time-periods) for more information.
 */
open class TimePeriod: TimePeriodProtocol {
    
    // MARK: - Variables
    /**
     *  The start date for a TimePeriod representing the starting boundary of the time period
     */
    public var beginning: Date?
    
    /**
     *  The end date for a TimePeriod representing the ending boundary of the time period
     */
    public var end: Date?
    
    
    // MARK: - Initializers
    
    public init() {
        
    }
    
    public init(beginning: Date?, end: Date?) {
        self.beginning = beginning
        self.end = end
    }
    
    public init(beginning: Date, duration: TimeInterval) {
        self.beginning = beginning
        self.end = beginning + duration
    }
    
    public init(end: Date, duration: TimeInterval) {
        self.end = end
        self.beginning = end.addingTimeInterval(-duration)
    }
    
    public init(beginning: Date, chunk: TimeChunk) {
        self.beginning = beginning
        self.end = beginning + chunk
    }
    
    public init(end: Date, chunk: TimeChunk) {
        self.end = end
        self.beginning = end - chunk
    }
    
    public init(chunk: TimeChunk) {
        self.beginning = Date()
        self.end = self.beginning?.add(chunk)
    }
    
    
    // MARK: - Shifted
    
    /**
     *  Shift the `TimePeriod` by a `TimeInterval`
     *
     * - parameter timeInterval: The time interval to shift the period by
     *
     * - returns: The new, shifted `TimePeriod`
     */
    public func shifted(by timeInterval: TimeInterval) -> TimePeriod {
        let timePeriod = TimePeriod()
        timePeriod.beginning = self.beginning?.addingTimeInterval(timeInterval)
        timePeriod.end = self.end?.addingTimeInterval(timeInterval)
        return timePeriod
    }
    
    /**
     *  Shift the `TimePeriod` by a `TimeChunk`
     *
     * - parameter chunk: The time chunk to shift the period by
     *
     * - returns: The new, shifted `TimePeriod`
     */
    public func shifted(by chunk: TimeChunk) -> TimePeriod {
        let timePeriod = TimePeriod()
        timePeriod.beginning = self.beginning?.add(chunk)
        timePeriod.end = self.end?.add(chunk)
        return timePeriod
    }
    
    // MARK: - Lengthen / Shorten
    
    // MARK: New
    
    /**
     *  Lengthen the `TimePeriod` by a `TimeInterval`
     *
     * - parameter timeInterval: The time interval to lengthen the period by
     * - parameter anchor: The anchor point from which to make the change
     *
     * - returns: The new, lengthened `TimePeriod`
     */
    public func lengthened(by timeInterval: TimeInterval, at anchor: Anchor) -> TimePeriod {
        let timePeriod = TimePeriod()
        switch anchor {
        case .beginning:
            timePeriod.beginning = self.beginning
            timePeriod.end = self.end?.addingTimeInterval(timeInterval)
            break
        case .center:
            timePeriod.beginning = self.beginning?.addingTimeInterval(-timeInterval)
            timePeriod.end = self.end?.addingTimeInterval(timeInterval)
            break
        case .end:
            timePeriod.beginning = self.beginning?.addingTimeInterval(-timeInterval)
            timePeriod.end = self.end
            break
        }
        
        return timePeriod
    }
    
    /**
     *  Lengthen the `TimePeriod` by a `TimeChunk`
     *
     * - parameter chunk: The time chunk to lengthen the period by
     * - parameter anchor: The anchor point from which to make the change
     *
     * - returns: The new, lengthened `TimePeriod`
     */
    public func lengthened(by chunk: TimeChunk, at anchor: Anchor) -> TimePeriod {
        let timePeriod = TimePeriod()
        switch anchor {
        case .beginning:
            timePeriod.beginning = beginning
            timePeriod.end = end?.add(chunk)
            break
        case .center:
            print("Mutation via chunk from center anchor is not supported.")
            break
        case .end:
            timePeriod.beginning = beginning?.add(-chunk)
            timePeriod.end = end
            break
        }
        
        return timePeriod
    }
    
    /**
     *  Shorten the `TimePeriod` by a `TimeInterval`
     *
     * - parameter timeInterval: The time interval to shorten the period by
     * - parameter anchor: The anchor point from which to make the change
     *
     * - returns: The new, shortened `TimePeriod`
     */
    public func shortened(by timeInterval: TimeInterval, at anchor: Anchor) -> TimePeriod {
        let timePeriod = TimePeriod()
        switch anchor {
        case .beginning:
            timePeriod.beginning = beginning
            timePeriod.end = end?.addingTimeInterval(-timeInterval)
            break
        case .center:
            timePeriod.beginning = beginning?.addingTimeInterval(-timeInterval/2)
            timePeriod.end = end?.addingTimeInterval(timeInterval/2)
            break
        case .end:
            timePeriod.beginning = beginning?.addingTimeInterval(timeInterval)
            timePeriod.end = end
            break
        }
        
        return timePeriod
    }
    
    /**
     *  Shorten the `TimePeriod` by a `TimeChunk`
     *
     * - parameter chunk: The time chunk to shorten the period by
     * - parameter anchor: The anchor point from which to make the change
     *
     * - returns: The new, shortened `TimePeriod`
     */
    public func shortened(by chunk: TimeChunk, at anchor: Anchor) -> TimePeriod {
        let timePeriod = TimePeriod()
        switch anchor {
        case .beginning:
            timePeriod.beginning = beginning
            timePeriod.end = end?.subtract(chunk)
            break
        case .center:
            print("Mutation via chunk from center anchor is not supported.")
            break
        case .end:
            timePeriod.beginning = beginning?.add(-chunk)
            timePeriod.end = end
            break
        }
        
        return timePeriod
    }
    
    
    // MARK: - Operator Overloads
    
    /**
     *  Operator overload for checking if two `TimePeriod`s are equal
     */
    public static func ==(leftAddend: TimePeriod, rightAddend: TimePeriod) -> Bool {
        return leftAddend.equals(rightAddend)
    }
    
    // Default anchor = beginning
    /**
     *  Operator overload for lengthening a `TimePeriod` by a `TimeInterval`
     */
    public static func +(leftAddend: TimePeriod, rightAddend: TimeInterval) -> TimePeriod {
        return leftAddend.lengthened(by: rightAddend, at: .beginning)
    }
    
    /**
     *  Operator overload for lengthening a `TimePeriod` by a `TimeChunk`
     */
    public static func +(leftAddend: TimePeriod, rightAddend: TimeChunk) -> TimePeriod {
        return leftAddend.lengthened(by: rightAddend, at: .beginning)
    }
    
    // Default anchor = beginning
    /**
     *  Operator overload for shortening a `TimePeriod` by a `TimeInterval`
     */
    public static func -(minuend: TimePeriod, subtrahend: TimeInterval) -> TimePeriod {
        return minuend.shortened(by: subtrahend, at: .beginning)
    }
    
    /**
     *  Operator overload for shortening a `TimePeriod` by a `TimeChunk`
     */
    public static func -(minuend: TimePeriod, subtrahend: TimeChunk) -> TimePeriod {
        return minuend.shortened(by: subtrahend, at: .beginning)
    }
    
    /**
     *  Operator overload for checking if a `TimePeriod` is equal to a `TimePeriodProtocol`
     */
    public static func ==(left: TimePeriod, right: TimePeriodProtocol) -> Bool {
        return left.equals(right)
    }
}
