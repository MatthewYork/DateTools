//
//  TimeChunk.swift
//  DateTools
//
//  Created by Grayson Webster on 8/19/16.
//  Copyright © 2016 Grayson Webster. All rights reserved.
//

import Foundation

/**
 * TimeChunk represents an abstract collection of `DateComponent`s intended for use in date manipulation. A `TimeChunk` differs from a
 * TimeInterval in that the former depends on the `Calendar` class (and takes into account daylight savings, leap year, etc.) while the
 * latter depends on hard, second based adjustments that are independent from calendar constructs. 
 *
 * In essence, TimeChunk is meant to be a thin, more flexible layer over the `Calender` and `DateComponent` classes for ease of use.
 * `TimeChunk`s may be created either by calling the provided initializer or shorthand like `2.days`. TimeChunks are manipulable and combine
 * using basic arithmetic operators like + and -.
 *
 * For more information about the utility of TimeChunks in relation to Dates, see the `Date+Manipulations` class.
 */
public struct TimeChunk {
    
    // MARK: - Variables
    
    public var seconds = 0
    public var minutes = 0
    public var hours = 0
    public var days = 0
    public var weeks = 0
    public var months = 0
    public var years = 0
    
    public init() {}
    
    public init(seconds: Int, minutes: Int, hours: Int, days: Int, weeks: Int, months: Int, years: Int) {
        self.seconds = seconds
        self.minutes = minutes
        self.hours = hours
        self.days = days
        self.weeks = weeks
        self.months = months
        self.years = years
    }
    
    
    // MARK: - Comparisons
    
    /**
     *  Check if two `TimeChunk`s are equal.
     *
     * - parameter chunk: `TimeChunk` to compare with self
     *
     * - returns: If all components in both `TimeChunk`s are equal
     */
    public func equals(chunk: TimeChunk) -> Bool {
        return (seconds == chunk.seconds && minutes == chunk.minutes && hours == chunk.hours && days == chunk.days && weeks == chunk.weeks && months == chunk.months && years == chunk.years)
    }
    
    
    // MARK: - Conversion
    
    /**
     *  Generic conversion method. Years are taken to mean
     *  365 days. This method should not be used for accurate
     *  date operations. Ex. 456.days.to(.years) will return 1.
     *
     *  ! Months are not supported for conversions. They are not a
     *  well defined unit of time without the context of a calendar. !
     */
    public func to(_ unit: TimeUnits) -> Int {
        if self.months != 0 {
            print("Months are not supported for conversion due to their uncertain number of days.")
            return 0
        }
        if (unit == .seconds) {
            var total = self.seconds
            total += self.minutes * 60
            total += self.hours * 60 * 60
            total += self.days * 24 * 60 * 60
            total += self.weeks * 7 * 24 * 60 * 60
            total += self.years * 365 * 24 * 60 * 60
            return total
        } else if (unit == .minutes) {
            var total = self.minutes
            total += self.seconds / 60
            total += self.hours * 60
            total += self.days * 24 * 60
            total += self.weeks * 7 * 24 * 60
            total += self.years * 365 * 24 * 60
            return total
        } else if (unit == .hours) {
            var total = self.hours
            let secondsToMinutes = self.seconds / 60
            total += (self.minutes + secondsToMinutes) / 60
            total += self.days * 24
            total += self.weeks * 7 * 24
            total += self.years * 365 * 24
            return total
        } else if (unit == .days) {
            var total = self.days
            let secondsToMinutes = self.seconds / 60
            let minutesToHours = (self.minutes + secondsToMinutes) / 60
            total += (self.hours + minutesToHours) / 24
            total += self.weeks * 7
            total += self.years * 365
            return total
        } else if (unit == .weeks) {
            var total = self.weeks
            let secondsToMinutes = self.seconds / 60
            let minutesToHours = (self.minutes + secondsToMinutes) / 60
            let hoursToDays = (self.hours + minutesToHours) / 24
            total += (self.days + hoursToDays) / 7
            total += self.years * 52
            return total
        } else if (unit == .years) {
            var total = self.years
            let secondsToMinutes = self.seconds / 60
            let minutesToHours = (self.minutes + secondsToMinutes) / 60
            let hoursToDays = (self.hours + minutesToHours) / 24
            let weeksToDays = weeks * 7
            total += (self.days + hoursToDays + weeksToDays) / 365
            return total
        }
        return 0
    }
    
    
    // MARK: - Date Creation
    
    /**
     *  Returns the current date decreased by the amount in self
     */
    public var earlier: Date {
        return earlier(than: Date())
    }
    
    /**
     *  Returns the current date increased by the amount in self
     */
    public var later: Date {
        return later(than: Date())
    }
    
    /**
     *  Returns the given date decreased by the amount in self.
     *
     * - parameter date: The date to decrease
     *
     * - returns: A new date with components decreased according to the variables of self
     */
    public func earlier(than date: Date) -> Date {
        return date.subtract(self)
    }
    
    /**
     *  Returns the given date increased by the amount in self.
     *
     * - parameter date: The date to increase
     *
     * - returns: A new date with components increased according to the variables of self
     */
    public func later(than date: Date) -> Date {
        return date.add(self)
    }
    
    // MARK: - Lengthen / Shorten
    
    // MARK: In Place
    
    /**
     *  Increase the variables of self (`TimeChunk`) by the variables of the given `TimeChunk`.
     *
     * - parameter chunk: The `TimeChunk` to increase self by
     *
     * - returns: The `TimeChunk` with variables increased
     */
    public func lengthened(by chunk: TimeChunk) -> TimeChunk {
        var newChunk = TimeChunk()
        newChunk.seconds = seconds + chunk.seconds
        newChunk.minutes = minutes + chunk.minutes
        newChunk.hours = hours + chunk.hours
        newChunk.days = days + chunk.days
        newChunk.weeks = weeks + chunk.weeks
        newChunk.months = months + chunk.months
        newChunk.years = years + chunk.years
        
        return newChunk
    }
    
    /**
     *  Decrease the variables of self (`TimeChunk`) by the variables of the given `TimeChunk`.
     *
     * - parameter chunk: The `TimeChunk` to decrease self by
     *
     * - returns: The `TimeChunk` with variables decreased
     */
    public func shortened(by chunk: TimeChunk) -> TimeChunk {
        var newChunk = TimeChunk()
        newChunk.seconds = seconds - chunk.seconds
        newChunk.minutes = minutes - chunk.minutes
        newChunk.hours = hours - chunk.hours
        newChunk.days = days - chunk.days
        newChunk.weeks = weeks - chunk.weeks
        newChunk.months = months - chunk.months
        newChunk.years = years - chunk.years
        
        return newChunk
    }
    
    
    // MARK: Mutation
    
    /**
     *  In place, increase the variables of self (`TimeChunk`) by the variables of the given `TimeChunk`.
     *
     * - parameter chunk: The `TimeChunk` to increase self by
     */
    public mutating func lengthen(by chunk: TimeChunk) {
        seconds += chunk.seconds
        minutes += chunk.minutes
        hours += chunk.hours
        days += chunk.days
        weeks += chunk.weeks
        months += chunk.months
        years += chunk.years
    }
    
    /**
     *  In place, decrease the variables of self (`TimeChunk`) by the variables of the given `TimeChunk`.
     *
     * - parameter chunk: The `TimeChunk` to decrease self by
     */
    public mutating func shorten(by chunk: TimeChunk) {
        seconds -= chunk.seconds
        minutes -= chunk.minutes
        hours -= chunk.hours
        days -= chunk.days
        weeks -= chunk.weeks
        months -= chunk.months
        years -= chunk.years
    }
    
    
    // MARK: - Operator Overloads
    
    /**
     *  Operator overload for adding two `TimeChunk`s
     */
    public static func +(leftAddend: TimeChunk, rightAddend: TimeChunk) -> TimeChunk {
        return leftAddend.lengthened(by: rightAddend)
    }
    
    /**
     *  Operator overload for subtracting two `TimeChunk`s
     */
    public static func -(minuend: TimeChunk, subtrahend: TimeChunk) -> TimeChunk {
        return minuend.shortened(by: subtrahend)
    }
    
    /**
     *  Operator overload for checking if two `TimeChunk`s are equal
     */
    public static func ==(left: TimeChunk, right: TimeChunk) -> Bool {
        return left.equals(chunk: right)
    }
    
    /**
     *  Operator overload for inverting (negating all variables) a `TimeChunk`
     */
    public static prefix func -(chunk: TimeChunk) -> TimeChunk {
        var invertedChunk = chunk;
        invertedChunk.seconds = -chunk.seconds
        invertedChunk.minutes = -chunk.minutes
        invertedChunk.hours = -chunk.hours
        invertedChunk.days = -chunk.days
        invertedChunk.weeks = -chunk.weeks
        invertedChunk.months = -chunk.months
        invertedChunk.years = -chunk.years
        return invertedChunk
    }
    
}
