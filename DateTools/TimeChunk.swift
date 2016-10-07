//
//  TimeChunk.swift
//  DateTools
//
//  Created by Grayson Webster on 8/19/16.
//  Copyright © 2016 Grayson Webster. All rights reserved.
//

import Foundation

public struct TimeChunk {
    
    // MARK: - Variables
    
    var seconds = 0
    var minutes = 0
    var hours = 0
    var days = 0
    var weeks = 0
    var months = 0
    var years = 0
    
    init() {}
    
    init(seconds: Int, minutes: Int, hours: Int, days: Int, weeks: Int, months: Int, years: Int) {
        self.seconds = seconds
        self.minutes = minutes
        self.hours = hours
        self.days = days
        self.weeks = weeks
        self.months = months
        self.years = years
    }
    
    
    // MARK: - Comparisons
    
    func equals(chunk: TimeChunk) -> Bool {
        return (seconds == chunk.seconds && minutes == chunk.minutes && hours == chunk.hours && days == chunk.days && weeks == chunk.weeks && months == chunk.months && years == chunk.years)
    }
    
    
    // MARK: - Conversion
    
    /**
     *  # To
     *  Generic conversion method. Years are taken to mean
     *  365 days. This method should not be used for accurate
     *  date operations. Ex. 456.days.to(.years) will return 1.
     *
     *  ! Months are not supported for conversions. They are not a
     *  well defined unit of time without the context of a calendar. !
     */
    func to(_ unit: TimeUnits) -> Int {
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
    
    var earlier: Date {
        return earlier(than: Date())
    }
    
    var later: Date {
        return later(than: Date())
    }
    
    func earlier(than date: Date) -> Date {
        return date.subtract(self)
    }
    
    func later(than date: Date) -> Date {
        return date.add(self)
    }
    
    // MARK: - Lengthen / Shorten
    
    // MARK: In Place
    
    func lengthened(by chunk: TimeChunk) -> TimeChunk {
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
    
    func shortened(by chunk: TimeChunk) -> TimeChunk {
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
    
    mutating func lengthen(by chunk: TimeChunk) {
        seconds += chunk.seconds
        minutes += chunk.minutes
        hours += chunk.hours
        days += chunk.days
        weeks += chunk.weeks
        months += chunk.months
        years += chunk.years
    }
    
    mutating func shorten(by chunk: TimeChunk) {
        seconds -= chunk.seconds
        minutes -= chunk.minutes
        hours -= chunk.hours
        days -= chunk.days
        weeks -= chunk.weeks
        months -= chunk.months
        years -= chunk.years
    }
    
    
    // MARK: - Operator Overloads
    
    static func +(leftAddend: TimeChunk, rightAddend: TimeChunk) -> TimeChunk {
        return leftAddend.lengthened(by: rightAddend)
    }
    
    static func -(minuend: TimeChunk, subtrahend: TimeChunk) -> TimeChunk {
        return minuend.shortened(by: subtrahend)
    }
    
    static func ==(left: TimeChunk, right: TimeChunk) -> Bool {
        return left.equals(chunk: right)
    }
    
    static prefix func -(chunk: TimeChunk) -> TimeChunk {
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
