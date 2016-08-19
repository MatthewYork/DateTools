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
        case After
        case StartTouching
        case StartInside
        case InsideStartTouching
        case EnclosingStartTouching
        case Enclosing
        case EnclosingEndTouching
        case ExactMatch
        case Inside
        case InsideEndTouching
        case EndInside
        case EndTouching
        case Before
        case None // One or more of the dates does not exist
    }
    
    /**
        Time period lengths
     */
    enum Size {
        case Second
        case Minute
        case Hour
        case Day
        case Week
        case Month
        case Year
    }
    
    /**
        Whether the time period is Open or Closed
     */
    enum Interval {
        case Open
        case Closed
    }
    
    /**
        When a time periods is lengthened or shortened, it does so anchoring one date of the time period and then changing the other one. There is also an option to anchor the centerpoint of the time period, changing both the start and end dates.
     */
    enum Anchor {
        case Start
        case Center
        case End
    }
    
    
    // MARK: - Variables
    
    /**
        The start date for a DTTimePeriod representing the starting boundary of the time period
     */
    var startDate: Date?
    
    /**
     *  The end date for a DTTimePeriod representing the ending boundary of the time period
     */
    var endDate: Date?
    
    
    // MARK: - Initializers
    init() {
        
    }
    
    init (start:Date, end:Date) {
        
    }
    
    
    // MARK: - Operator Overloads
    static func +(leftAddend: TimePeriod, rightAddend: TimePeriod) -> TimePeriod {
       return TimePeriod()
    }
    static func -(minuend: TimePeriod, subtrahend: TimePeriod) -> TimePeriod {
        return TimePeriod()
    }
}
