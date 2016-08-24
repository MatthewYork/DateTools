//
//  TimeBlock.swift
//  DateTools
//
//  Created by Grayson Webster on 8/19/16.
//  Copyright © 2016 Grayson Webster. All rights reserved.
//

import Foundation

struct TimeChunk {
    
    enum Size {
        case second
        case minute
        case hour
        case day
        case week
        case month
        case year
    }
    
    
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
    
    init(size: Size, amount: Int) {
        switch size {
        case .second:
            seconds += amount
        case .minute:
            minutes += amount
        case .hour:
            hours += amount
        case .day:
            days += amount
        case .week:
            weeks += amount
        case .month:
            months += amount
        case .year:
            years += amount
        }
    }
    
    
    // MARK: - Comparisons
    
    func equals(chunk: TimeChunk) -> Bool {
        return (seconds == chunk.seconds && minutes == chunk.minutes && hours == chunk.hours && days == chunk.days && weeks == chunk.weeks && months == chunk.months && years == chunk.years)
    }
    
    
    //MARK: - Lengthen / Shorten
    
    func lengthen(by chunk: TimeChunk) -> TimeChunk {
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
    
    func shorten(by chunk: TimeChunk) -> TimeChunk {
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
    
    
    // MARK: - Mutation
    
    mutating func lengthened(by chunk: TimeChunk) {
        seconds += chunk.seconds
        minutes += chunk.minutes
        hours += chunk.hours
        days += chunk.days
        weeks += chunk.weeks
        months += chunk.months
        years += chunk.years
    }
    
    mutating func shortened(by chunk: TimeChunk) {
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
        return leftAddend.lengthen(by: rightAddend)
    }
    static func -(minuend: TimeChunk, subtrahend: TimeChunk) -> TimeChunk {
        return minuend.shorten(by: subtrahend)
    }
    static func ==(left: TimeChunk, right: TimeChunk) -> Bool {
        return left.equals(chunk: right)
    }
}
