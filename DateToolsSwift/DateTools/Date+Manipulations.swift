//
//  Date+Manipulations.swift
//  DateToolsTests
//
//  Created by Grayson Webster on 9/28/16.
//  Copyright © 2016 Matthew York. All rights reserved.
//

import Foundation

/**
 *  Extends the Date class by adding manipulation methods for transforming dates
 */
public extension Date {
    
    // MARK: - StartOf
    
    /**
     *  Return a date set to the start of a given component.
     *
     *  - parameter component: The date component (second, minute, hour, day, month, or year)
     *
     *  - returns: A date retaining the value of the given component and all larger components,
     *  with all smaller components set to their minimum
     */
    func start(of component: Component) -> Date {
        var newDate = self;
        if component == .second {
            newDate.second(self.second)
        }
        else if component == .minute {
            newDate.second(0)
        } else if component == .hour {
            newDate.second(0)
            newDate.minute(0)
        } else if component == .day {
            newDate.second(0)
            newDate.minute(0)
            newDate.hour(0)
        } else if component == .month {
            newDate.second(0)
            newDate.minute(0)
            newDate.hour(0)
            newDate.day(1)
        } else if component == .year {
            newDate.second(0)
            newDate.minute(0)
            newDate.hour(0)
            newDate.day(1)
            newDate.month(1)
        }
        return newDate
    }
    
    /**
     *  Return a date set to the end of a given component.
     *
     *  - parameter component: The date component (second, minute, hour, day, month, or year)
     *
     *  - returns: A date retaining the value of the given component and all larger components,
     *  with all smaller components set to their maximum
     */
    func end(of component: Component) -> Date {
        var newDate = self;
        if component == .second {
            newDate.second(newDate.second + 1)
            newDate = newDate - 0.001
        }
        else if component == .minute {
            newDate.second(60)
            newDate = newDate - 0.001
        } else if component == .hour {
            newDate.second(60)
            newDate = newDate - 0.001
            newDate.minute(59)
        } else if component == .day {
            newDate.second(60)
            newDate = newDate - 0.001
            newDate.minute(59)
            newDate.hour(23)
        } else if component == .month {
            newDate.second(60)
            newDate = newDate - 0.001
            newDate.minute(59)
            newDate.hour(23)
            newDate.day(daysInMonth(date: newDate))
        } else if component == .year {
            newDate.second(60)
            newDate = newDate - 0.001
            newDate.minute(59)
            newDate.hour(23)
            newDate.month(12)
            newDate.day(31)
        }
        
        return newDate
    }
    
    func daysInMonth(date: Date) -> Int {
        let month = date.month
        if month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12 {
            // 31 day month
            return 31
        } else if month == 2 && date.isInLeapYear {
            // February with leap year
            return 29
        } else if month == 2 && !date.isInLeapYear {
            // February without leap year
            return 28
        } else {
            // 30 day month
            return 30
        }
    }
    
    
    // MARK: - Addition / Subtractions
    
    /**
     *  # Add (TimeChunk to Date)
     *  Increase a date by the value of a given `TimeChunk`.
     *
     *  - parameter chunk: The amount to increase the date by (ex. 2.days, 4.years, etc.)
     *
     *  - returns: A date with components increased by the values of the
     *  corresponding `TimeChunk` variables
     */
    func add(_ chunk: TimeChunk) -> Date {
        let calendar = Calendar.autoupdatingCurrent
        var components = DateComponents()
        components.year = chunk.years
        components.month = chunk.months
        components.day = chunk.days + (chunk.weeks*7)
        components.hour = chunk.hours
        components.minute = chunk.minutes
        components.second = chunk.seconds
        return calendar.date(byAdding: components, to: self)!
    }
    
    /**
     *  # Subtract (TimeChunk from Date)
     *  Decrease a date by the value of a given `TimeChunk`.
     *
     *  - parameter chunk: The amount to decrease the date by (ex. 2.days, 4.years, etc.)
     *
     *  - returns: A date with components decreased by the values of the
     *  corresponding `TimeChunk` variables
     */
    func subtract(_ chunk: TimeChunk) -> Date {
        let calendar = Calendar.autoupdatingCurrent
        var components = DateComponents()
        components.year = -chunk.years
        components.month = -chunk.months
        components.day = -(chunk.days + (chunk.weeks*7))
        components.hour = -chunk.hours
        components.minute = -chunk.minutes
        components.second = -chunk.seconds
        return calendar.date(byAdding: components, to: self)!
    }
    
    
    // MARK: - Operator Overloads
    
    /**
     *  Operator overload for adding a `TimeChunk` to a date.
     */
    static func +(leftAddend: Date, rightAddend: TimeChunk) -> Date {
        return leftAddend.add(rightAddend)
    }
    
    /**
     *  Operator overload for subtracting a `TimeChunk` from a date.
     */
    static func -(minuend: Date, subtrahend: TimeChunk) -> Date {
        return minuend.subtract(subtrahend)
    }
    
    /**
     *  Operator overload for adding a `TimeInterval` to a date.
     */
    static func +(leftAddend: Date, rightAddend: Int) -> Date {
        return leftAddend.addingTimeInterval((TimeInterval(rightAddend)))
    }
    
    /**
     *  Operator overload for subtracting a `TimeInterval` from a date.
     */
    static func -(minuend: Date, subtrahend: Int) -> Date {
        return minuend.addingTimeInterval(-(TimeInterval(subtrahend)))
    }
    
}
