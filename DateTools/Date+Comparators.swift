//
//  Date+Comparators.swift
//  DateToolsTests
//
//  Created by Matthew York on 8/26/16.
//  Copyright © 2016 Matthew York. All rights reserved.
//

import Foundation

public extension Date {
    
    static var _defaultCalendarIdentifier = Calendar.Identifier.gregorian;
    
    private static func defaultCalendarIdentifier() -> Calendar.Identifier {
        return _defaultCalendarIdentifier
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
    
    func laterThanOrEqual(to date: Date) -> Bool {
        return self.compare(date) == .orderedDescending || self.compare(date) == .orderedSame
    }
	
	func earlier(than date: Date) -> Bool {
		return self.compare(date) == .orderedAscending
	}
    
    func earlierThanOrEqual(to date: Date) -> Bool {
        return self.compare(date) == .orderedAscending || self.compare(date) == .orderedSame
    }
	
    
    // MARK: - Date Comparison
    
    // MARK: Time From
    
    /**
     *  Returns an NSInteger representing the amount of time in years between the receiver and the provided date.
     *  If the receiver is earlier than the provided date, the returned value will be negative.
     *  Uses the default Gregorian calendar
     *
     *  @param date Date - The provided date for comparison
     *
     *  @return NSInteger - The NSInteger representation of the years between receiver and provided date
     */
    func yearsFrom(_ date: Date) -> Int {
        return yearsFrom(date, calendar:nil)
    }
    
    /**
     *  Returns an NSInteger representing the amount of time in months between the receiver and the provided date.
     *  If the receiver is earlier than the provided date, the returned value will be negative.
     *  Uses the default Gregorian calendar
     *
     *  @param date Date - The provided date for comparison
     *
     *  @return NSInteger - The NSInteger representation of the years between receiver and provided date
     */
    func monthsFrom(_ date: Date) -> Int {
        return monthsFrom(date, calendar:nil)
    }
    
    /**
     *  Returns an NSInteger representing the amount of time in weeks between the receiver and the provided date.
     *  If the receiver is earlier than the provided date, the returned value will be negative.
     *  Uses the default Gregorian calendar
     *
     *  @param date Date - The provided date for comparison
     *
     *  @return NSInteger - The double representation of the weeks between receiver and provided date
     */
    func weeksFrom(_ date: Date) -> Int {
        return weeksFrom(date, calendar:nil)
    }
    
    /**
     *  Returns an NSInteger representing the amount of time in days between the receiver and the provided date.
     *  If the receiver is earlier than the provided date, the returned value will be negative.
     *  Uses the default Gregorian calendar
     *
     *  @param date Date - The provided date for comparison
     *
     *  @return NSInteger - The double representation of the days between receiver and provided date
     */
    func daysFrom(_ date: Date) -> Int {
        return daysFrom(date, calendar:nil)
    }
    
    /**
     *  Returns an NSInteger representing the amount of time in hours between the receiver and the provided date.
     *  If the receiver is earlier than the provided date, the returned value will be negative.
     *
     *  @param date Date - The provided date for comparison
     *
     *  @return double - The double representation of the hours between receiver and provided date
     */
    func hoursFrom(_ date: Date) -> Int {
        return Int(self.timeIntervalSince(date)/Constants.SecondsInHour);
    }
    
    /**
     *  Returns an NSInteger representing the amount of time in minutes between the receiver and the provided date.
     *  If the receiver is earlier than the provided date, the returned value will be negative.
     *
     *  @param date Date - The provided date for comparison
     *
     *  @return double - The double representation of the minutes between receiver and provided date
     */
    func minutesFrom(_ date: Date) -> Int {
        return Int(self.timeIntervalSince(date)/Constants.SecondsInMinute)
    }
    
    /**
     *  Returns an NSInteger representing the amount of time in seconds between the receiver and the provided date.
     *  If the receiver is earlier than the provided date, the returned value will be negative.
     *
     *  @param date Date - The provided date for comparison
     *
     *  @return double - The double representation of the seconds between receiver and provided date
     */
    func secondsFrom(_ date: Date) -> Int {
        return Int(timeIntervalSince(date))
    }
    
    
    // MARK: Time From With Calendar
    
    /**
     *  Returns an NSInteger representing the amount of time in years between the receiver and the provided date.
     *  If the receiver is earlier than the provided date, the returned value will be negative.
     *
     *  @param date     Date - The provided date for comparison
     *  @param calendar NSCalendar - The calendar to be used in the calculation
     *
     *  @return NSInteger - The double representation of the years between receiver and provided date
     */
    func yearsFrom(_ date: Date, calendar: Calendar?) -> Int {
        var calendarCopy = calendar
        if (calendar == nil) {
            calendarCopy = Calendar.autoupdatingCurrent
        }
        
        let earliest = earlierDate(date)
        let latest = (earliest == self) ? date : self;
        let multiplier = (earliest == self) ? -1 : 1;
        let components = calendarCopy!.dateComponents([.year], from: earliest, to: latest)
        return multiplier * components.year!;
    }
    
    /**
     *  Returns an NSInteger representing the amount of time in months between the receiver and the provided date.
     *  If the receiver is earlier than the provided date, the returned value will be negative.
     *
     *  @param date     Date - The provided date for comparison
     *  @param calendar NSCalendar - The calendar to be used in the calculation
     *
     *  @return NSInteger - The double representation of the months between receiver and provided date
     */
    func monthsFrom(_ date: Date, calendar: Calendar?) -> Int{
        var calendarCopy = calendar
        if (calendar == nil) {
            calendarCopy = Calendar.autoupdatingCurrent
        }
        
        let earliest = earlierDate(date)
        let latest = (earliest == self) ? date : self;
        let multiplier = (earliest == self) ? -1 : 1;
        let components = calendarCopy!.dateComponents(Constants.AllCalendarUnitFlags, from: earliest, to: latest)
        return multiplier*(components.month! + 12*components.year!);
    }
    
    /**
     *  Returns an NSInteger representing the amount of time in weeks between the receiver and the provided date.
     *  If the receiver is earlier than the provided date, the returned value will be negative.
     *
     *  @param date     Date - The provided date for comparison
     *  @param calendar NSCalendar - The calendar to be used in the calculation
     *
     *  @return NSInteger - The double representation of the weeks between receiver and provided date
     */
    func weeksFrom(_ date: Date, calendar: Calendar?) -> Int{
        var calendarCopy = calendar
        if (calendar == nil) {
            calendarCopy = Calendar.autoupdatingCurrent
        }
        
        let earliest = earlierDate(date)
        let latest = (earliest == self) ? date : self;
        let multiplier = (earliest == self) ? -1 : 1;
        let components = calendarCopy!.dateComponents([.weekOfYear], from: earliest, to: latest)
        return multiplier*components.weekOfYear!;
    }
    
    /**
     *  Returns an NSInteger representing the amount of time in days between the receiver and the provided date.
     *  If the receiver is earlier than the provided date, the returned value will be negative.
     *
     *  @param date     Date - The provided date for comparison
     *  @param calendar NSCalendar - The calendar to be used in the calculation
     *
     *  @return NSInteger - The double representation of the days between receiver and provided date
     */
    func daysFrom(_ date: Date, calendar: Calendar?) -> Int {
        var calendarCopy = calendar
        if (calendar == nil) {
            calendarCopy = Calendar.autoupdatingCurrent
        }
        
        let earliest = earlierDate(date)
        let latest = (earliest == self) ? date : self
        let multiplier = (earliest == self) ? -1 : 1
        let components = calendarCopy!.dateComponents([.day], from: earliest, to: latest)
        return multiplier*components.day!
    }
    
    
    // MARK: Time Until
    
    /**
     *  Returns the number of years until the receiver's date. Returns 0 if the receiver is the same or earlier than now.
     *
     *  @return NSInteger representiation of years
     */
    func yearsUntil() -> Int {
        return yearsLaterThan(Date())
    }
    
    /**
     *  Returns the number of months until the receiver's date. Returns 0 if the receiver is the same or earlier than now.
     *
     *  @return NSInteger representiation of months
     */
    func monthsUntil() -> Int {
        return monthsLaterThan(Date())
    }
    
    /**
     *  Returns the number of weeks until the receiver's date. Returns 0 if the receiver is the same or earlier than now.
     *
     *  @return NSInteger representiation of weeks
     */
    func weeksUntil() -> Int {
        return weeksLaterThan(Date())
    }
    
    /**
     *  Returns the number of days until the receiver's date. Returns 0 if the receiver is the same or earlier than now.
     *
     *  @return NSInteger representiation of days
     */
    func daysUntil() -> Int {
        return daysLaterThan(Date())
    }
    
    /**
     *  Returns the number of hours until the receiver's date. Returns 0 if the receiver is the same or earlier than now.
     *
     *  @return double representiation of hours
     */
    func hoursUntil() -> Int{
        return hoursLaterThan(Date())
    }
    
    /**
     *  Returns the number of minutes until the receiver's date. Returns 0 if the receiver is the same or earlier than now.
     *
     *  @return double representiation of minutes
     */
    func minutesUntil() -> Int{
        return minutesLaterThan(Date())
    }
    
    /**
     *  Returns the number of seconds until the receiver's date. Returns 0 if the receiver is the same or earlier than now.
     *
     *  @return double representiation of seconds
     */
    func secondsUntil() -> Int{
        return secondsLaterThan(Date())
    }
    
    
    // MARK: Time Ago
    
    /**
     *  Returns the number of years the receiver's date is earlier than now. Returns 0 if the receiver is the same or later than now.
     *
     *  @return NSInteger representiation of years
     */
    func yearsAgo() -> Int {
        return yearsEarlierThan(Date())
    }
    
    /**
     *  Returns the number of months the receiver's date is earlier than now. Returns 0 if the receiver is the same or later than now.
     *
     *  @return NSInteger representiation of months
     */
    func monthsAgo() -> Int {
        return monthsEarlierThan(Date())
    }
    
    /**
     *  Returns the number of weeks the receiver's date is earlier than now. Returns 0 if the receiver is the same or later than now.
     *
     *  @return NSInteger representiation of weeks
     */
    func weeksAgo() -> Int {
        return weeksEarlierThan(Date())
    }
    
    /**
     *  Returns the number of days the receiver's date is earlier than now. Returns 0 if the receiver is the same or later than now.
     *
     *  @return NSInteger representiation of days
     */
    func daysAgo() -> Int {
        return daysEarlierThan(Date())
    }
    
    /**
     *  Returns the number of hours the receiver's date is earlier than now. Returns 0 if the receiver is the same or later than now.
     *
     *  @return double representiation of hours
     */
    func hoursAgo() -> Int{
        return hoursEarlierThan(Date())
    }
    
    /**
     *  Returns the number of minutes the receiver's date is earlier than now. Returns 0 if the receiver is the same or later than now.
     *
     *  @return double representiation of minutes
     */
    func minutesAgo() -> Int{
        return minutesEarlierThan(Date())
    }
    
    /**
     *  Returns the number of seconds the receiver's date is earlier than now. Returns 0 if the receiver is the same or later than now.
     *
     *  @return double representiation of seconds
     */
    func secondsAgo() -> Int{
        return secondsEarlierThan(Date())
    }
    
    
    // MARK: Earlier Than
    
    /**
     *  Returns the number of years the receiver's date is earlier than the provided comparison date.
     *  Returns 0 if the receiver's date is later than or equal to the provided comparison date.
     *
     *  @param date Date - Provided date for comparison
     *
     *  @return NSInteger representing the number of years
     */
    func yearsEarlierThan(_ date: Date) -> Int {
        return abs(min(yearsFrom(date), 0))
    }
    
    /**
     *  Returns the number of months the receiver's date is earlier than the provided comparison date.
     *  Returns 0 if the receiver's date is later than or equal to the provided comparison date.
     *
     *  @param date Date - Provided date for comparison
     *
     *  @return NSInteger representing the number of months
     */
    func monthsEarlierThan(_ date: Date) -> Int {
        return abs(min(monthsFrom(date), 0));
    }
    
    /**
     *  Returns the number of weeks the receiver's date is earlier than the provided comparison date.
     *  Returns 0 if the receiver's date is later than or equal to the provided comparison date.
     *
     *  @param date Date - Provided date for comparison
     *
     *  @return NSInteger representing the number of weeks
     */
    func weeksEarlierThan(_ date: Date) -> Int {
        return abs(min(weeksFrom(date), 0))
    }
    
    /**
     *  Returns the number of days the receiver's date is earlier than the provided comparison date.
     *  Returns 0 if the receiver's date is later than or equal to the provided comparison date.
     *
     *  @param date Date - Provided date for comparison
     *
     *  @return NSInteger representing the number of days
     */
    func daysEarlierThan(_ date: Date) -> Int {
        return abs(min(daysFrom(date), 0))
    }
    
    /**
     *  Returns the number of hours the receiver's date is earlier than the provided comparison date.
     *  Returns 0 if the receiver's date is later than or equal to the provided comparison date.
     *
     *  @param date Date - Provided date for comparison
     *
     *  @return double representing the number of hours
     */
    func hoursEarlierThan(_ date: Date) -> Int {
        return abs(min(hoursFrom(date), 0))
    }
    
    /**
     *  Returns the number of minutes the receiver's date is earlier than the provided comparison date.
     *  Returns 0 if the receiver's date is later than or equal to the provided comparison date.
     *
     *  @param date Date - Provided date for comparison
     *
     *  @return double representing the number of minutes
     */
    func minutesEarlierThan(_ date: Date) -> Int {
        return abs(min(minutesFrom(date), 0))
    }
    
    /**
     *  Returns the number of seconds the receiver's date is earlier than the provided comparison date.
     *  Returns 0 if the receiver's date is later than or equal to the provided comparison date.
     *
     *  @param date Date - Provided date for comparison
     *
     *  @return double representing the number of seconds
     */
    func secondsEarlierThan(_ date: Date) -> Int {
        return abs(min(secondsFrom(date), 0))
    }
    
    
    // MARK: Later Than
    
    /**
     *  Returns the number of years the receiver's date is later than the provided comparison date.
     *  Returns 0 if the receiver's date is earlier than or equal to the provided comparison date.
     *
     *  @param date Date - Provided date for comparison
     *
     *  @return NSInteger representing the number of years
     */
    func yearsLaterThan(_ date: Date) -> Int {
        return max(yearsFrom(date), 0)
    }
    
    /**
     *  Returns the number of months the receiver's date is later than the provided comparison date.
     *  Returns 0 if the receiver's date is earlier than or equal to the provided comparison date.
     *
     *  @param date Date - Provided date for comparison
     *
     *  @return NSInteger representing the number of months
     */
    func monthsLaterThan(_ date: Date) -> Int {
        return max(monthsFrom(date), 0)
    }
    
    /**
     *  Returns the number of weeks the receiver's date is later than the provided comparison date.
     *  Returns 0 if the receiver's date is earlier than or equal to the provided comparison date.
     *
     *  @param date Date - Provided date for comparison
     *
     *  @return NSInteger representing the number of weeks
     */
    func weeksLaterThan(_ date: Date) -> Int {
        return max(weeksFrom(date), 0)
    }
    
    /**
     *  Returns the number of days the receiver's date is later than the provided comparison date.
     *  Returns 0 if the receiver's date is earlier than or equal to the provided comparison date.
     *
     *  @param date Date - Provided date for comparison
     *
     *  @return NSInteger representing the number of days
     */
    func daysLaterThan(_ date: Date) -> Int {
        return max(daysFrom(date), 0)
    }
    
    /**
     *  Returns the number of hours the receiver's date is later than the provided comparison date.
     *  Returns 0 if the receiver's date is earlier than or equal to the provided comparison date.
     *
     *  @param date Date - Provided date for comparison
     *
     *  @return double representing the number of hours
     */
    func hoursLaterThan(_ date: Date) -> Int {
        return max(hoursFrom(date), 0)
    }
    
    /**
     *  Returns the number of minutes the receiver's date is later than the provided comparison date.
     *  Returns 0 if the receiver's date is earlier than or equal to the provided comparison date.
     *
     *  @param date Date - Provided date for comparison
     *
     *  @return double representing the number of minutes
     */
    func minutesLaterThan(_ date: Date) -> Int {
        return max(minutesFrom(date), 0)
    }
    
    /**
     *  Returns the number of seconds the receiver's date is later than the provided comparison date.
     *  Returns 0 if the receiver's date is earlier than or equal to the provided comparison date.
     *
     *  @param date Date - Provided date for comparison
     *
     *  @return double representing the number of seconds
     */
    func secondsLaterThan(_ date: Date) -> Int {
        return max(secondsFrom(date), 0)
    }

}
