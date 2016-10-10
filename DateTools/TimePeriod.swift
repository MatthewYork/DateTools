//
//  TimePeriod.swift
//  DateTools
//
//  Created by Grayson Webster on 8/17/16.
//  Copyright © 2016 Grayson Webster. All rights reserved.
//

import Foundation



/**
 *  # TimePeriod
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
    var isMoment: Bool {
        return self.beginning == self.end
    }
    
    /**
     *  The duration of the `TimePeriod` in years.
     *  Returns the max int if beginning or end are nil.
     */
    var years: Int {
        if self.beginning != nil && self.end != nil {
            return self.beginning!.yearsEarlier(than: self.end!)
        }
        return Int.max
    }
    
    /**
     *  The duration of the `TimePeriod` in weeks.
     *  Returns the max int if beginning or end are nil.
     */
    var weeks: Int {
        if self.beginning != nil && self.end != nil {
            return self.beginning!.weeksEarlier(than: self.end!)
        }
        return Int.max
    }
    
    /**
     *  The duration of the `TimePeriod` in days.
     *  Returns the max int if beginning or end are nil.
     */
    var days: Int {
        if self.beginning != nil && self.end != nil {
            return self.beginning!.daysEarlier(than: self.end!)
        }
        return Int.max
    }
    
    /**
     *  The duration of the `TimePeriod` in hours.
     *  Returns the max int if beginning or end are nil.
     */
    var hours: Int {
        if self.beginning != nil && self.end != nil {
            return self.beginning!.hoursEarlier(than: self.end!)
        }
        return Int.max
    }
    
    /**
     *  The duration of the `TimePeriod` in minutes.
     *  Returns the max int if beginning or end are nil.
     */
    var minutes: Int {
        if self.beginning != nil && self.end != nil {
            return self.beginning!.minutesEarlier(than: self.end!)
        }
        return Int.max
    }
    
    /**
     *  The duration of the `TimePeriod` in seconds.
     *  Returns the max int if beginning or end are nil.
     */
    var seconds: Int {
        if self.beginning != nil && self.end != nil {
            return self.beginning!.secondsEarlier(than: self.end!)
        }
        return Int.max
    }
    
    /**
     *  The duration of the `TimePeriod` in a time chunk.
     *  Returns a time chunk with all zeroes if beginning or end are nil.
     */
    var chunk: TimeChunk {
        if beginning != nil && end != nil {
            return beginning!.chunkBetween(date: end!)
        }
        return TimeChunk(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: 0, years: 0)
    }
    
    /**
     *  The length of time between the beginning and end dates of the
     * `TimePeriod` as a `TimeInterval`.
     */
    var duration: TimeInterval {
        if self.beginning != nil && self.end != nil {
            return abs(self.beginning!.timeIntervalSince(self.end!))
        }
        #if os(Linux)
            return TimeInterval(Double.greatestFiniteMagnitude)
        #else
            return TimeInterval(DBL_MAX)
        #endif
    }
    
    
    // MARK: - Time Period Relationships
    
    /**
     *  # Relation To (Time Period Protocol)
     *  The relationship of the self `TimePeriod` to the given `TimePeriod`.
     *  Relations are stored in Enums.swift. Formal defnitions available in the provided
     *  links:
     *  [GitHub](https://github.com/MatthewYork/DateTools#relationships),
     *  [CodeProject](http://www.codeproject.com/Articles/168662/Time-Period-Library-for-NET)
     *  
     *  @param period TimePeriodProtocol - The time period to compare to self
     *  
     *  @return Relation - The relationship between self and the given time period
     */
    func relation(to period: TimePeriodProtocol) -> Relation {
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
     *  # Equals (Time Period Protocol)
     *  If `self.beginning` and `self.end` are equal to the beginning and end of the
     *  given `TimePeriod`.
     *
     *  @param period TimePeriodProtocol - The time period to compare to self
     *
     *  @return Bool - True if the periods are the same
     */
    func equals(_ period: TimePeriodProtocol) -> Bool {
        return self.beginning == period.beginning && self.end == period.end
    }
    
    /**
     *  # Inside Of (Time Period Protocol)
     *  If the given `TimePeriod`'s beginning is before `self.beginning` and
     *  if the given 'TimePeriod`'s end is after `self.end`.
     *
     *  @param period TimePeriodProtocol - The time period to compare to self
     *
     *  @return Bool - True if self is inside of the given `TimePeriod`
     */
    func isInside(of period: TimePeriodProtocol) -> Bool {
        return period.beginning!.isEarlierThanOrEqual(to: self.beginning!) && period.end!.isLaterThanOrEqual(to: self.end!)
    }
    
    /**
     *  # Contains (Date, Interval)
     *  If the given Date is after `self.beginning` and before `self.end`.
     *
     *  @param period   TimePeriodProtocol - The time period to compare to self
     *  @param interval Interval - Whether the edge of the date is included in the calculation
     *
     *  @return Bool - True if the given `TimePeriod` is inside of self
     */
    func contains(_ date: Date, interval: Interval) -> Bool {
        if (interval == .open) {
            return self.beginning!.isEarlier(than: date) && self.end!.isLater(than: date)
        }
        else if (interval == .closed){
            return (self.beginning!.isEarlierThanOrEqual(to: date) && self.end!.isLaterThanOrEqual(to: date))
        }
        
        return false
    }
    
    /**
     *  # Contains (Time Period Protocol)
     *  If the given `TimePeriod`'s beginning is after `self.beginning` and
     *  if the given 'TimePeriod`'s after is after `self.end`.
     *
     *  @param period TimePeriodProtocol - The time period to compare to self
     *
     *  @return Bool - True if the given `TimePeriod` is inside of self
     */
    func contains(_ period: TimePeriodProtocol) -> Bool {
        return self.beginning!.isEarlierThanOrEqual(to: period.beginning!) && self.end!.isLaterThanOrEqual(to: period.end!)
    }
    
    /**
     *  # Overlaps With (Time Period Protocol)
     *  If self and the given `TimePeriod` share any sub-`TimePeriod`.
     *
     *  @param period TimePeriodProtocol - The time period to compare to self
     *
     *  @return Bool - True if there is a period of time that is shared by both `TimePeriod`s
     */
    func overlaps(with period: TimePeriodProtocol) -> Bool {
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
     *  # Intersects With (Time Period Protocol)
     *  If self and the given `TimePeriod` overlap or the period's edges touch.
     *
     *  @param period TimePeriodProtocol - The time period to compare to self
     *
     *  @return Bool - True if there is a period of time or moment that is shared by both `TimePeriod`s
     */
    func intersects(with period: TimePeriodProtocol) -> Bool {
        return self.relation(to: period) != .after && self.relation(to: period) != .before
    }
    
    /**
     *  # Has Gap Between (Time Period Protocol)
     *  If self and the given `TimePeriod` have no overlap or touching edges.
     *
     *  @param period TimePeriodProtocol - The time period to compare to self
     *
     *  @return Bool - True if there is a period of time between self and the given
     *  `TimePeriod` not contained by either period
     */
    func hasGap(between period: TimePeriodProtocol) -> Bool {
        return self.isBefore(period: period) || self.isAfter(period: period)
    }
    
    /**
     *  # Gap Between (Time Period Protocol)
     *  The period of time between self and the given `TimePeriod` not contained by either.
     *
     *  @param period TimePeriodProtocol - The time period to compare to self
     *
     *  @return TimeInterval - The gap between the periods. Zero if there is no gap.
     */
    func gap(between period: TimePeriodProtocol) -> TimeInterval {
        if (self.end!.isEarlier(than: period.beginning!)) {
            return abs(self.end!.timeIntervalSince(period.beginning!));
        }
        else if (period.end!.isEarlier(than: self.beginning!)){
            return abs(period.end!.timeIntervalSince(self.beginning!));
        }
        return 0
    }
    
    /**
     *  # Gap Between (Time Chunk)
     *  The period of time between self and the given `TimePeriod` not contained by either
     *  as a `TimeChunk`.
     *
     *  @param period TimePeriodProtocol - The time period to compare to self
     *
     *  @return TimeChunk - The gap between the periods, zero if there is no gap
     */
    func gap(between period: TimePeriodProtocol) -> TimeChunk? {
        if self.end != nil && period.beginning != nil {
            return (self.end?.chunkBetween(date: period.beginning!))!
        }
        return nil
    }
    
    /**
     *  # Is After (Time Period Protocol)
     *  If self is after the given `TimePeriod` chronologically. (A gap must exist between the two).
     *
     *  @param period TimePeriodProtocol - The time period to compare to self
     *
     *  @return Bool - True if self is after the given `TimePeriod`
     */
    func isAfter(period: TimePeriodProtocol) -> Bool {
        return self.relation(to: period) == .after
    }
    
    /**
     *  # Is Before (Time Period Protocol)
     *  If self is before the given `TimePeriod` chronologically. (A gap must exist between the two).
     *
     *  @param period TimePeriodProtocol - The time period to compare to self
     *
     *  @return Bool - True if self is after the given `TimePeriod`
     */
    func isBefore(period: TimePeriodProtocol) -> Bool {
        return self.relation(to: period) == .before
    }
    
    // MARK: - Shifts
    
    //MARK: In Place
    
    /**
     *  # Shift By (Time Interval at Anchor)
     *  In place, shift the `TimePeriod` by a `TimeInterval`
     *
     *  @param timeInterval TimeInterval - The time interval to shift the period by
     */
    mutating func shift(by timeInterval: TimeInterval) {
        self.beginning?.addTimeInterval(timeInterval)
        self.end?.addTimeInterval(timeInterval)
    }
    
    /**
     *  # Shift By (Time Chunk at Anchor)
     *  In place, shift the `TimePeriod` by a `TimeChunk`
     *
     *  @param chunk TimeChunk - The time chunk to shift the period by
     */
    mutating func shift(by chunk: TimeChunk) {
        self.beginning = self.beginning?.add(chunk)
        self.end = self.end?.add(chunk)
    }
    
    // MARK: - Lengthen / Shorten
    
    // MARK: In Place
    
    
    /**
     *  # Lengthen By (Time Interval at Anchor)
     *  In place, lengthen the `TimePeriod`, anchored at the beginning, end or center
     *
     *  @param timeInterval TimeInterval - The time interval to lengthen the period by
     *  @param anchor       Anchor - The anchor point from which to make the change
     */
    mutating func lengthen(by timeInterval: TimeInterval, at anchor: Anchor) {
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
     *  # Lengthen By (Time Chunk at Anchor)
     *  In place, lengthen the `TimePeriod`, anchored at the beginning or end
     *
     *  @param chunk  TimeChunk - The time chunk to lengthen the period by
     *  @param anchor Anchor - The anchor point from which to make the change
     */
    mutating func lengthen(by chunk: TimeChunk, at anchor: Anchor) {
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
     *  # Shorten By (Time Interval at Anchor)
     *  In place, shorten the `TimePeriod`, anchored at the beginning, end or center
     *
     *  @param timeInterval TimeInterval - The time interval to shorten the period by
     *  @param anchor       Anchor - The anchor point from which to make the change
     */
    mutating func shorten(by timeInterval: TimeInterval, at anchor: Anchor) {
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
     *  # Shorten By (Time Chunk at Anchor)
     *  In place, shorten the `TimePeriod`, anchored at the beginning or end
     *
     *  @param chunk  TimeChunk - The time chunk to shorten the period by
     *  @param anchor Anchor - The anchor point from which to make the change
     */
    mutating func shorten(by chunk: TimeChunk, at anchor: Anchor) {
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
 *  # TimePeriod
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
    
    init() {
        
    }
    
    init(beginning: Date?, end: Date?) {
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
    
    init(beginning: Date, chunk: TimeChunk) {
        self.beginning = beginning
        self.end = beginning + chunk
    }
    
    init(end: Date, chunk: TimeChunk) {
        self.end = end
        self.beginning = end - chunk
    }
    
    init(chunk: TimeChunk) {
        self.beginning = Date()
        self.end = self.beginning?.add(chunk)
    }
    
    
    // MARK: - Shifted
    
    /**
     *  # Shift By (Time Interval)
     *  Shift the `TimePeriod` by a `TimeInterval`
     *
     *  @param timeInterval TimeInterval - The time interval to shift the period by
     *
     *  @return TimePeriod - The new, shifted `TimePeriod`
     */
    func shifted(by timeInterval: TimeInterval) -> TimePeriod {
        let timePeriod = TimePeriod()
        timePeriod.beginning = self.beginning?.addingTimeInterval(timeInterval)
        timePeriod.end = self.end?.addingTimeInterval(timeInterval)
        return timePeriod
    }
    
    /**
     *  # Shift By (Time Chunk)
     *  Shift the `TimePeriod` by a `TimeChunk`
     *
     *  @param chunk TimeChunk - The time chunk to shift the period by
     *
     *  @return TimePeriod - The new, shifted `TimePeriod`
     */
    func shifted(by chunk: TimeChunk) -> TimePeriod {
        let timePeriod = TimePeriod()
        timePeriod.beginning = self.beginning?.add(chunk)
        timePeriod.end = self.end?.add(chunk)
        return timePeriod
    }
    
    // MARK: - Lengthen / Shorten
    
    // MARK: New
    
    /**
     *  # Lengthened By (Time Interval at Anchor)
     *  Lengthen the `TimePeriod` by a `TimeInterval`
     *
     *  @param timeInterval TimeInterval - The time interval to lengthen the period by
     *  @param anchor       Anchor - The anchor point from which to make the change
     *
     *  @return TimePeriod - The new, lengthened `TimePeriod`
     */
    func lengthened(by timeInterval: TimeInterval, at anchor: Anchor) -> TimePeriod {
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
     *  # Lengthened By (Time Chunk at Anchor)
     *  Lengthen the `TimePeriod` by a `TimeChunk`
     *
     *  @param chunk  TimeChunk - The time chunk to lengthen the period by
     *  @param anchor Anchor - The anchor point from which to make the change
     *
     *  @return TimePeriod - The new, lengthened `TimePeriod`
     */
    func lengthened(by chunk: TimeChunk, at anchor: Anchor) -> TimePeriod {
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
     *  # Shortened By (Time Interval at Anchor)
     *  Shorten the `TimePeriod` by a `TimeInterval`
     *
     *  @param timeInterval TimeInterval - The time interval to shorten the period by
     *  @param anchor       Anchor - The anchor point from which to make the change
     *
     *  @return TimePeriod - The new, shortened `TimePeriod`
     */
    func shortened(by timeInterval: TimeInterval, at anchor: Anchor) -> TimePeriod {
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
     *  # Shortened By (Time Chunk at Anchor)
     *  Shorten the `TimePeriod` by a `TimeChunk`
     *
     *  @param chunk  TimeChunk - The time chunk to shorten the period by
     *  @param anchor Anchor - The anchor point from which to make the change
     *
     *  @return TimePeriod - The new, shortened `TimePeriod`
     */
    func shortened(by chunk: TimeChunk, at anchor: Anchor) -> TimePeriod {
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
    static func ==(leftAddend: TimePeriod, rightAddend: TimePeriod) -> Bool {
        return leftAddend.equals(rightAddend)
    }
    
    // Default anchor = beginning
    /**
     *  Operator overload for lengthening a `TimePeriod` by a `TimeInterval`
     */
    static func +(leftAddend: TimePeriod, rightAddend: TimeInterval) -> TimePeriod {
        return leftAddend.lengthened(by: rightAddend, at: .beginning)
    }
    
    /**
     *  Operator overload for lengthening a `TimePeriod` by a `TimeChunk`
     */
    static func +(leftAddend: TimePeriod, rightAddend: TimeChunk) -> TimePeriod {
        return leftAddend.lengthened(by: rightAddend, at: .beginning)
    }
    
    // Default anchor = beginning
    /**
     *  Operator overload for shortening a `TimePeriod` by a `TimeInterval`
     */
    static func -(minuend: TimePeriod, subtrahend: TimeInterval) -> TimePeriod {
        return minuend.shortened(by: subtrahend, at: .beginning)
    }
    
    /**
     *  Operator overload for shortening a `TimePeriod` by a `TimeChunk`
     */
    static func -(minuend: TimePeriod, subtrahend: TimeChunk) -> TimePeriod {
        return minuend.shortened(by: subtrahend, at: .beginning)
    }
    
    /**
     *  Operator overload for checking if a `TimePeriod` is equal to a `TimePeriodProtocol`
     */
    static func ==(left: TimePeriod, right: TimePeriodProtocol) -> Bool {
        return left.equals(right)
    }
    
}
