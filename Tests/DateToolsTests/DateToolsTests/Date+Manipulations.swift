//
//  Date+Manipulations.swift
//  DateToolsTests
//
//  Created by Grayson Webster on 9/28/16.
//  Copyright © 2016 Matthew York. All rights reserved.
//

import Foundation

public extension Date {
    
    // MARK: - StartOf
    
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
    
    internal func daysInMonth(date: Date) -> Int {
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
    
    static func +(leftAddend: Date, rightAddend: TimeChunk) -> Date {
        return leftAddend.add(rightAddend)
    }
    
    static func -(minuend: Date, subtrahend: TimeChunk) -> Date {
        return minuend.subtract(subtrahend)
    }
    
    static func +(leftAddend: Date, rightAddend: Int) -> Date {
        return leftAddend.addingTimeInterval((TimeInterval(rightAddend)))
    }
    
    static func -(minuend: Date, subtrahend: Int) -> Date {
        return minuend.addingTimeInterval(-(TimeInterval(subtrahend)))
    }

}
