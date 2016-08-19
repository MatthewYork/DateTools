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
        Time period lengths
     */
    enum Size {
        case second
        case minute
        case hour
        case day
        case week
        case month
        case year
    }
    
    /**
        Whether the time period is Open or Closed
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
    
    init (start:Date, end:Date) {
        
    }
    
    init(start: Date, duration: TimeInterval) {
        
    }
    
    init(end: Date, duration: TimeInterval) {
        
    }
    
    //MARK: - Information
    
    func isMoment() -> Bool {
        return false
    }
    
    func years() -> TimeInterval {
        return 0
    }
    
    func weeks() -> TimeInterval {
        return 0
    }
    
    func days() -> TimeInterval {
        return 0
    }
    
    func hours() -> TimeInterval {
        return 0
    }
    
    func minutes() -> TimeInterval {
        return 0
    }
    
    func seconds() -> TimeInterval {
        return 0
    }
    
    //MARK: - Time Period Relationships
    
    func equals(timePeriod: TimePeriod) -> Bool {
        return false
    }
    
    func isInside(timePeriod: TimePeriod) -> Bool {
        return false
    }
    
    func contains(timePeriod: TimePeriod) -> Bool {
        return false
    }
    
    func overlaps(timePeriod: TimePeriod) -> Bool {
        return false
    }
    
    func intersects(timePeriod: TimePeriod) -> Bool {
        return false
    }
    
    func equals(timePeriod: TimePeriod) {
        
    }
    
    func relationTo(timePeriod: TimePeriod) -> Relation {
        return .none
    }
    
    func timeBetween(timePeriod: TimePeriod) -> TimeInterval {
        return 0
    }
    
    //MARK: - Shifts
    
    func shiftEarlier(timeInterval: TimeInterval) {
        
    }
    
    func shiftLater(timeInterval: TimeInterval) {
        
    }
    
    //MARK: - Lengthen / Shorten
    
    func lengthen(by timeInterval: TimeInterval, at anchor: Anchor) {
        
    }
    
    //MARK: - Copy
    
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
        return left.equals(timePeriod: right)
    }
}
