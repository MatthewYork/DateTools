//
//  Date+Comparators.swift
//  DateToolsTests
//
//  Created by Matthew York on 8/26/16.
//  Copyright © 2016 Matthew York. All rights reserved.
//

import Foundation

public extension Date {
	
	// MARK: - Addition / Subtractions
	
	func add(_ timeChunk: TimeChunk) -> Date {
		let calendar = Calendar.autoupdatingCurrent
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        components.year! += timeChunk.years
        components.month! += timeChunk.months
        components.day! += timeChunk.days
        components.hour! += timeChunk.hours
        components.minute! += timeChunk.minutes
        components.second! += timeChunk.seconds
        return calendar.date(from: components)!
	}
	
	func subtract(_ timeChunk: TimeChunk) -> Date {
        let calendar = Calendar.autoupdatingCurrent
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        components.year! -= timeChunk.years
        components.month! -= timeChunk.months
        components.day! -= timeChunk.days
        components.hour! -= timeChunk.hours
        components.minute! -= timeChunk.minutes
        components.second! -= timeChunk.seconds
        return calendar.date(from: components)!
	}
    
	
	// MARK: - Chunk between
	
    func chunkBetween(date: Date) -> TimeChunk {
        let calendar = Calendar.autoupdatingCurrent
        var selfComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        var diffComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        var yearDelta = diffComponents.year! - selfComponents.year!
        var monthDelta = diffComponents.month! - selfComponents.month!
        var dayDelta = diffComponents.day! - selfComponents.day!
        var hourDelta = diffComponents.hour! - selfComponents.hour!
        var minuteDelta = diffComponents.minute! - selfComponents.minute!
        var secondDelta = diffComponents.second! - selfComponents.second!
        
        var month = selfComponents.month! + monthDelta
        let year = selfComponents.year! + yearDelta
        
        let inFuture = self.less(than: date)
        
        if inFuture {
            if monthDelta < 0 {
                yearDelta -= 1
                monthDelta += 12
            }
            if dayDelta < 0 {
                monthDelta -= 1
                month -= 1
                if month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12 {
                    // 31 day month
                    dayDelta += 31
                } else if month == 2 && date.isInLeapYear {
                    // February with leap year
                    dayDelta += 29
                } else if month == 2 && !date.isInLeapYear {
                    // February without leap year
                    dayDelta += 28
                } else {
                    // 30 day month
                    dayDelta += 30
                }
            }
            if hourDelta < 0 {
                dayDelta -= 1
                hourDelta += 24
            }
            if minuteDelta < 0 {
                hourDelta -= 1
                minuteDelta += 60
            }
            if secondDelta < 0 {
                minuteDelta -= 1
                secondDelta += 60
            }
        } else {
            if monthDelta > 0 {
                yearDelta += 1
                monthDelta -= 12
            }
            if dayDelta > 0 {
                monthDelta += 1
                if month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12 {
                    // 31 day month
                    dayDelta -= 31
                } else if month == 2 && year % 4 == 0 {
                    // February with leap year
                    dayDelta -= 29
                } else if month == 2 && year % 4 != 0 {
                    // February without leap year
                    dayDelta -= 28
                } else {
                    // 30 day month
                    dayDelta -= 30
                }
            }
            if hourDelta > 0 {
                dayDelta += 1
                hourDelta -= 24
            }
            if minuteDelta > 0 {
                hourDelta += 1
                minuteDelta -= 60
            }
            if secondDelta > 0 {
                minuteDelta += 1
                secondDelta -= 60
            }
            
        }
        return TimeChunk(seconds: secondDelta, minutes: minuteDelta, hours: hourDelta, days: dayDelta, weeks: 0, months: monthDelta, years: yearDelta)
    }
	
	
	// MARK: - Comparisons
	
	func equals(_ date: Date) -> Bool {
		return self.compare(date) == .orderedSame
	}
	
	func greater(than date: Date) -> Bool {
		return self.compare(date) == .orderedDescending
	}
	
	func less(than date: Date) -> Bool {
		return self.compare(date) == .orderedAscending
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
