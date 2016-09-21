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
    
    init() {
    
    }
    
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
