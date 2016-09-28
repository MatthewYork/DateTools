//
//  Date+Comparators.swift
//  DateToolsTests
//
//  Created by Matthew York on 8/26/16.
//  Copyright © 2016 Matthew York. All rights reserved.
//

import Foundation

public extension Date {
	
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
        
        let inFuture = self.earlier(than: date)
        
        if inFuture {
            month -= 1
            if monthDelta < 0 {
                if yearDelta > 0 {
                    yearDelta -= 1
                    monthDelta += 12
                }
            }
            if dayDelta < 0 {
                if monthDelta > 0 {
                    monthDelta -= 1
                    dayDelta += daysInMonth(month: month, date: date)
                } else {
                    yearDelta -= 1
                    monthDelta += 11
                    dayDelta += daysInMonth(month: month, date: date)
                }
            }
            if hourDelta < 0 {
                if dayDelta > 0 {
                    dayDelta -= 1
                    hourDelta += 24
                } else if monthDelta > 0 {
                    monthDelta -= 1
                    dayDelta += daysInMonth(month: month, date: date)
                } else if year > 0 {
                    yearDelta -= 1
                    monthDelta += 11
                    dayDelta += daysInMonth(month: month, date: date) - 1
                    hourDelta += 24
                }
            }
            if minuteDelta < 0 {
                if hourDelta > 0 {
                    hourDelta -= 1
                    minuteDelta += 60
                } else if dayDelta > 0 {
                    dayDelta -= 1
                    hourDelta += 23
                    minuteDelta += 60
                } else if monthDelta > 0 {
                    monthDelta -= 1
                    dayDelta += daysInMonth(month: month, date: date) - 1
                    hourDelta += 23
                    minuteDelta += 60
                } else if year > 0 {
                    yearDelta -= 1
                    monthDelta += 11
                    dayDelta += daysInMonth(month: month, date: date) - 1
                    hourDelta += 23
                    minuteDelta += 60
                }
            }
            if secondDelta < 0 {
                if minuteDelta > 0 {
                    minuteDelta -= 1
                    secondDelta += 60
                } else if hourDelta > 0 {
                    hourDelta -= 1
                    minuteDelta += 59
                    secondDelta += 60
                } else if dayDelta > 0 {
                    dayDelta -= 1
                    hourDelta += 23
                    minuteDelta += 59
                    secondDelta += 60
                } else if monthDelta > 0 {
                    monthDelta -= 1
                    dayDelta += daysInMonth(month: month, date: date) - 1
                    hourDelta += 23
                    minuteDelta += 59
                    secondDelta += 60
                } else if year > 0 {
                    yearDelta -= 1
                    monthDelta += 11
                    dayDelta += daysInMonth(month: month, date: date) - 1
                    hourDelta += 23
                    minuteDelta += 59
                    secondDelta += 60
                }
            }
        } else {
            if monthDelta > 0 {
                if yearDelta < 0 {
                    yearDelta += 1
                    monthDelta -= 12
                }
            }
            if dayDelta > 0 {
                if monthDelta < 0 {
                    monthDelta += 1
                    dayDelta -= daysInMonth(month: month, date: date)
                } else if yearDelta < 0 {
                    yearDelta += 1
                    monthDelta -= 11
                    dayDelta -= daysInMonth(month: month, date: date)
                }
            }
            if hourDelta > 0 {
                if dayDelta < 0 {
                    dayDelta += 1
                    hourDelta -= 24
                } else if monthDelta < 0 {
                    monthDelta += 1
                    dayDelta -= daysInMonth(month: month, date: date) + 1
                    hourDelta -= 24
                } else if yearDelta < 0 {
                    yearDelta += 1
                    monthDelta -= 11
                    dayDelta -= daysInMonth(month: month, date: date) + 1
                    hourDelta -= 24
                }
            }
            if minuteDelta > 0 {
                if hourDelta < 0 {
                    hourDelta += 1
                    minuteDelta -= 60
                } else if dayDelta < 0 {
                    dayDelta += 1
                    hourDelta -= 23
                    minuteDelta -= 60
                } else if monthDelta < 0 {
                    monthDelta += 1
                    dayDelta -= daysInMonth(month: month, date: date) + 1
                    hourDelta -= 23
                    minuteDelta -= 60
                } else if yearDelta < 0 {
                    yearDelta += 1
                    monthDelta -= 11
                    dayDelta -= daysInMonth(month: month, date: date) + 1
                    hourDelta -= 23
                    minuteDelta -= 60
                }
            }
            if secondDelta > 0 {
                if minuteDelta < 0 {
                    minuteDelta += 1
                    secondDelta -= 60
                } else if hourDelta < 0 {
                    hourDelta += 1
                    minuteDelta -= 59
                    secondDelta -= 60
                } else if dayDelta < 0 {
                    dayDelta += 1
                    hourDelta -= 23
                    minuteDelta -= 59
                    secondDelta -= 60
                } else if monthDelta < 0 {
                    monthDelta += 1
                    dayDelta -= daysInMonth(month: month, date: date) + 1
                    hourDelta -= 23
                    minuteDelta -= 59
                    secondDelta -= 60
                } else if yearDelta < 0 {
                    yearDelta += 1
                    monthDelta -= 11
                    dayDelta -= daysInMonth(month: month, date: date) + 1
                    hourDelta -= 23
                    minuteDelta -= 59
                    secondDelta -= 60
                }
            }
            
        }
        return TimeChunk(seconds: secondDelta, minutes: minuteDelta, hours: hourDelta, days: dayDelta, weeks: 0, months: monthDelta, years: yearDelta)
    }
    
    internal func daysInMonth(month: Int, date: Date) -> Int {
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
	
	
	// MARK: - Comparisons
	
	func equals(_ date: Date) -> Bool {
		return self.compare(date) == .orderedSame
	}
	
	func later(than date: Date) -> Bool {
		return self.compare(date) == .orderedDescending
	}
	
	func earlier(than date: Date) -> Bool {
		return self.compare(date) == .orderedAscending
	}
	
}
