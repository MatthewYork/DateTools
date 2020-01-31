//
//  Date+Comparators.swift
//  DateToolsTests
//
//  Created by Matthew York on 8/26/16.
//  Copyright © 2016 Matthew York. All rights reserved.
//

import Foundation

/**
 *  Extends the Date class by adding methods for calculating the chunk
 *  of time between two dates and providing many variables and functions
 *  that compare the ordinality of two dates and the space between two dates
 *  for a given unit of time.
 */
public extension Date {
	
    // MARK: - Comparisons
    
    /**
     *  Given a date, returns a `TimeChunk` with components in their most natural form. Example:
     *
     *  ```
     *  let formatter = DateFormatter()
     *  formatter.dateFormat = "yyyy MM dd HH:mm:ss.SSS"
     *  let birthday = formatter.date(from: "2015 11 24 14:50:12.000")!
     *  let age = birthday.chunkBetween(date: formatter.date(from: "2016 10 07 15:27:12.000")!)
     *  ```
     *
     *  The age variable will have a chunk of time with year, month, day, hour, minute, 
     *  and second components (note that we do not use weeks since they are not components 
     *  of `Calendar`). So if you just wanted the age in years, you could then say: age.years.
     *
     *  The chunk is calculated exactly as you'd say it in real life, always converting up 
     *  when a lower unit equals 1 of the unit above it. The above example returns 
     *  `TimeChunk(seconds: 0, minutes: 37, hours: 0, days: 13, weeks: 0, months: 10, years: 0)`.
     *
     *  Passing a future date returns a TimeChunk with all positive components and passing 
     *  a date in the past returns one with all negative components.
     *
     *  - parameter date: The date of reference from the date called on
     *
     *  - returns: A TimeChunk representing the time between the dates, in natural form
     */
    func chunkBetween(date: Date) -> TimeChunk {
        let compenentsBetween = Calendar.autoupdatingCurrent.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self, to: date)
        return TimeChunk(seconds: compenentsBetween.second!, minutes: compenentsBetween.minute!, hours: compenentsBetween.hour!, days: compenentsBetween.day!, weeks: 0, months: compenentsBetween.month!, years: compenentsBetween.year!)
        // TimeChunk(seconds: secondDelta, minutes: minuteDelta, hours: hourDelta, days: dayDelta, weeks: 0, months: monthDelta, years: yearDelta)
    }
	
    /**
     *  Returns a true if receiver is equal to provided comparison date, otherwise returns false
     *
     *  - parameter date: Provided date for comparison
     *
     *  - returns: Bool representing comparison result
     */
    func equals(_ date: Date) -> Bool {
		return self.compare(date) == .orderedSame
	}
	
    /**
     *  Returns a true if receiver is later than provided comparison date, otherwise
     *  returns false
     *
     *  - parameter date: Provided date for comparison
     *
     *  - returns: Bool representing comparison result
     */
    func isLater(than date: Date) -> Bool {
		return self.compare(date) == .orderedDescending
	}
    
    /**
     *  Returns a true if receiver is later than or equal to provided comparison date,
     *  otherwise returns false
     *
     *  - parameter date: Provided date for comparison
     *
     *  - returns: Bool representing comparison result
     */
    func isLaterThanOrEqual(to date: Date) -> Bool {
        return self.compare(date) == .orderedDescending || self.compare(date) == .orderedSame
    }
	
    /**
     *  Returns a true if receiver is earlier than provided comparison date, otherwise
     *  returns false
     *
     *  - parameter date: Provided date for comparison
     *
     *  - returns: Bool representing comparison result
     */
    func isEarlier(than date: Date) -> Bool {
		return self.compare(date) == .orderedAscending
	}
    
    /**
     *  Returns a true if receiver is earlier than or equal to the provided comparison date,
     *  otherwise returns false
     *
     *  - parameter date: Provided date for comparison
     *
     *  - returns:  Bool representing comparison result
     */
    func isEarlierThanOrEqual(to date: Date) -> Bool {
        return self.compare(date) == .orderedAscending || self.compare(date) == .orderedSame
    }
    
    /**
     *  Returns whether two dates fall on the same day.
     *
     *  - parameter date: Date to compare with sender
     *
     *  - returns: True if both paramter dates fall on the same day, false otherwise
     */
    func isSameDay(date : Date ) -> Bool {
        return Date.isSameDay(date: self, as: date)
    }
    
    /**
     *  Returns whether two dates fall on the same day.
     *
     *  - parameter date: First date to compare
     *  - parameter compareDate: Second date to compare
     *
     *  - returns: True if both paramter dates fall on the same day, false otherwise
     */
    static func isSameDay(date: Date, as compareDate: Date) -> Bool {
        let calendar = Calendar.autoupdatingCurrent
        var components = calendar.dateComponents([.era, .year, .month, .day], from: date)
        let dateOne = calendar.date(from: components)
        
        components = calendar.dateComponents([.era, .year, .month, .day], from: compareDate)
        let dateTwo = calendar.date(from: components)
        
        return (dateOne?.equals(dateTwo!))!
    }
	
    
    // MARK: - Date Comparison
    
    // MARK: Time From
    
    /**
     *  Returns an Int representing the amount of time in years between the receiver and
     *  the provided date.
     *
     *  If the receiver is earlier than the provided date, the returned value will be negative.
     *  Uses the default Gregorian calendar
     *
     *  - parameter date: The provided date for comparison
     *
     *  - returns: The years between receiver and provided date
     */
    func years(from date: Date) -> Int {
        return years(from: date, calendar:nil)
    }
    
    /**
     *  Returns an Int representing the amount of time in months between the receiver and
     *  the provided date.
     *
     *  If the receiver is earlier than the provided date, the returned value will be negative.
     *  Uses the default Gregorian calendar
     *
     *  - parameter date: The provided date for comparison
     *
     *  - returns: The years between receiver and provided date
     */
    func months(from date: Date) -> Int {
        return months(from: date, calendar:nil)
    }
    
    /**
     *  Returns an Int representing the amount of time in weeks between the receiver and
     *  the provided date.
     *
     *  If the receiver is earlier than the provided date, the returned value will be negative.
     *  Uses the default Gregorian calendar
     *
     *  - parameter date: The provided date for comparison
     *
     *  - returns: The weeks between receiver and provided date
     */
    func weeks(from date: Date) -> Int {
        return weeks(from: date, calendar:nil)
    }
    
    /**
     *  Returns an Int representing the amount of time in days between the receiver and
     *  the provided date.
     *
     *  If the receiver is earlier than the provided date, the returned value will be negative.
     *  Uses the default Gregorian calendar
     *
     *  - parameter date: The provided date for comparison
     *
     *  - returns: The days between receiver and provided date
     */
    func days(from date: Date) -> Int {
        return days(from: date, calendar:nil)
    }
    
    /**
     *  Returns an Int representing the amount of time in hours between the receiver and
     *  the provided date.
     *
     *  If the receiver is earlier than the provided date, the returned value will be negative.
     *
     *  - parameter date: The provided date for comparison
     *
     *  - returns: The hours between receiver and provided date
     */
    func hours(from date: Date) -> Int {
        return Int(self.timeIntervalSince(date)/Constants.SecondsInHour);
    }
    
    /**
     *  Returns an Int representing the amount of time in minutes between the receiver and
     *  the provided date.
     *
     *  If the receiver is earlier than the provided date, the returned value will be negative.
     *
     *  - parameter date: The provided date for comparison
     *
     *  - returns: The minutes between receiver and provided date
     */
    func minutes(from date: Date) -> Int {
        return Int(self.timeIntervalSince(date)/Constants.SecondsInMinute)
    }
    
    /**
     *  Returns an Int representing the amount of time in seconds between the receiver and
     *  the provided date.
     *
     *  If the receiver is earlier than the provided date, the returned value will be negative.
     *
     *  - parameter date: The provided date for comparison
     *
     *  - returns: The seconds between receiver and provided date
     */
    func seconds(from date: Date) -> Int {
        return Int(timeIntervalSince(date))
    }
    
    
    // MARK: Time From With Calendar
    
    /**
     *  Returns an Int representing the amount of time in years between the receiver and
     *  the provided date.
     *
     *  If the receiver is earlier than the provided date, the returned value will be negative.
     *
     *  - parameter date: The provided date for comparison
     *  - parameter calendar: The calendar to be used in the calculation
     *
     *  - returns: The years between receiver and provided date
     */
    func years(from date: Date, calendar: Calendar?) -> Int {
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
     *  Returns an Int representing the amount of time in months between the receiver and
     *  the provided date.
     *
     *  If the receiver is earlier than the provided date, the returned value will be negative.
     *
     *  - parameter date: The provided date for comparison
     *  - parameter calendar: The calendar to be used in the calculation
     *
     *  - returns: The months between receiver and provided date
     */
    func months(from date: Date, calendar: Calendar?) -> Int {
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
     *  Returns an Int representing the amount of time in weeks between the receiver and
     *  the provided date.
     *
     *  If the receiver is earlier than the provided date, the returned value will be negative.
     *
     *  - parameter date: The provided date for comparison
     *  - parameter calendar: The calendar to be used in the calculation
     *
     *  - returns: The weeks between receiver and provided date
     */
    func weeks(from date: Date, calendar: Calendar?) -> Int {
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
     *  Returns an Int representing the amount of time in days between the receiver and
     *  the provided date.
     *
     *  If the receiver is earlier than the provided date, the returned value will be negative.
     *
     *  - parameter date: The provided date for comparison
     *  - parameter calendar: The calendar to be used in the calculation
     *
     *  - returns: The days between receiver and provided date
     */
    func days(from date: Date, calendar: Calendar?) -> Int {
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
     *  The number of years until the receiver's date (0 if the receiver is the same or 
     *  earlier than now).
     */
    var yearsUntil: Int {
        return yearsLater(than: Date())
    }
    
    /**
     *  The number of months until the receiver's date (0 if the receiver is the same or 
     *  earlier than now).
     */
    var monthsUntil: Int {
        return monthsLater(than: Date())
    }
    
    /**
     *  The number of weeks until the receiver's date (0 if the receiver is the same or 
     *  earlier than now).
     */
    var weeksUntil: Int {
        return weeksLater(than: Date())
    }
    
    /**
     *  The number of days until the receiver's date (0 if the receiver is the same or 
     *  earlier than now).
     */
    var daysUntil: Int {
        return daysLater(than: Date())
    }
    
    /**
     *  The number of hours until the receiver's date (0 if the receiver is the same or 
     *  earlier than now).
     */
    var hoursUntil: Int{
        return hoursLater(than: Date())
    }
    
    /**
     *  The number of minutes until the receiver's date (0 if the receiver is the same or 
     *  earlier than now).
     */
    var minutesUntil: Int{
        return minutesLater(than: Date())
    }
    
    /**
     *  The number of seconds until the receiver's date (0 if the receiver is the same or 
     *  earlier than now).
     */
    var secondsUntil: Int{
        return secondsLater(than: Date())
    }
    
    
    // MARK: Time Ago
    
    /**
     *  The number of years the receiver's date is earlier than now (0 if the receiver is 
     *  the same or earlier than now).
     */
    var yearsAgo: Int {
        return yearsEarlier(than: Date())
    }
    
    /**
     *  The number of months the receiver's date is earlier than now (0 if the receiver is 
     *  the same or earlier than now).
     */
    var monthsAgo: Int {
        return monthsEarlier(than: Date())
    }
    
    /**
     *  The number of weeks the receiver's date is earlier than now (0 if the receiver is 
     *  the same or earlier than now).
     */
    var weeksAgo: Int {
        return weeksEarlier(than: Date())
    }
    
    /**
     *  The number of days the receiver's date is earlier than now (0 if the receiver is 
     *  the same or earlier than now).
     */
    var daysAgo: Int {
        return daysEarlier(than: Date())
    }
    
    /**
     *  The number of hours the receiver's date is earlier than now (0 if the receiver is 
     *  the same or earlier than now).
     */
    var hoursAgo: Int {
        return hoursEarlier(than: Date())
    }
    
    /**
     *  The number of minutes the receiver's date is earlier than now (0 if the receiver is 
     *  the same or earlier than now).
     */
    var minutesAgo: Int {
        return minutesEarlier(than: Date())
    }
    
    /**
     *  The number of seconds the receiver's date is earlier than now (0 if the receiver is 
     *  the same or earlier than now).
     */
    var secondsAgo: Int{
        return secondsEarlier(than: Date())
    }
    
    
    // MARK: Earlier Than
    
    /**
     *  Returns the number of years the receiver's date is earlier than the provided
     *  comparison date, 0 if the receiver's date is later than or equal to the provided comparison date.
     *
     *  - parameter date: Provided date for comparison
     *
     *  - returns: The number of years
     */
    func yearsEarlier(than date: Date) -> Int {
        return abs(min(years(from: date), 0))
    }
    
    /**
     *  Returns the number of months the receiver's date is earlier than the provided
     *  comparison date, 0 if the receiver's date is later than or equal to the provided comparison date.
     *
     *  - parameter date: Provided date for comparison
     *
     *  - returns: The number of months
     */
    func monthsEarlier(than date: Date) -> Int {
        return abs(min(months(from: date), 0));
    }
    
    /**
     *  Returns the number of weeks the receiver's date is earlier than the provided
     *  comparison date, 0 if the receiver's date is later than or equal to the provided comparison date.
     *
     *  - parameter date: Provided date for comparison
     *
     *  - returns: The number of weeks
     */
    func weeksEarlier(than date: Date) -> Int {
        return abs(min(weeks(from: date), 0))
    }
    
    /**
     *  Returns the number of days the receiver's date is earlier than the provided
     *  comparison date, 0 if the receiver's date is later than or equal to the provided comparison date.
     *
     *  - parameter date: Provided date for comparison
     *
     *  - returns: The number of days
     */
    func daysEarlier(than date: Date) -> Int {
        return abs(min(days(from: date), 0))
    }
    
    /**
     *  Returns the number of hours the receiver's date is earlier than the provided
     *  comparison date, 0 if the receiver's date is later than or equal to the provided comparison date.
     *
     *  - parameter date: Provided date for comparison
     *
     *  - returns: The number of hours
     */
    func hoursEarlier(than date: Date) -> Int {
        return abs(min(hours(from: date), 0))
    }
    
    /**
     *  Returns the number of minutes the receiver's date is earlier than the provided
     *  comparison date, 0 if the receiver's date is later than or equal to the provided comparison date.
     *
     *  - parameter date: Provided date for comparison
     *
     *  - returns: The number of minutes
     */
    func minutesEarlier(than date: Date) -> Int {
        return abs(min(minutes(from: date), 0))
    }
    
    /**
     *  Returns the number of seconds the receiver's date is earlier than the provided
     *  comparison date, 0 if the receiver's date is later than or equal to the provided comparison date.
     *
     *  - parameter date: Provided date for comparison
     *
     *  - returns: The number of seconds
     */
    func secondsEarlier(than date: Date) -> Int {
        return abs(min(seconds(from: date), 0))
    }
    
    
    // MARK: Later Than
    
    /**
     *  Returns the number of years the receiver's date is later than the provided
     *  comparison date, 0 if the receiver's date is earlier than or equal to the provided 
     *  comparison date.
     *
     *  - parameter date: Provided date for comparison
     *
     *  - returns: The number of years
     */
    func yearsLater(than date: Date) -> Int {
        return max(years(from: date), 0)
    }
    
    /**
     *  Returns the number of months the receiver's date is later than the provided
     *  comparison date, 0 if the receiver's date is earlier than or equal to the provided 
     *  comparison date.
     *
     *  - parameter date: Provided date for comparison
     *
     *  - returns: The number of months
     */
    func monthsLater(than date: Date) -> Int {
        return max(months(from: date), 0)
    }
    
    /**
     *  Returns the number of weeks the receiver's date is later than the provided
     *  comparison date, 0 if the receiver's date is earlier than or equal to the provided
     *  comparison date.
     *
     *  - parameter date: Provided date for comparison
     *
     *  - returns: The number of weeks
     */
    func weeksLater(than date: Date) -> Int {
        return max(weeks(from: date), 0)
    }
    
    /**
     *  Returns the number of days the receiver's date is later than the provided
     *  comparison date, 0 if the receiver's date is earlier than or equal to the provided
     *  comparison date.
     *
     *  - parameter date: Provided date for comparison
     *
     *  - returns: The number of days
     */
    func daysLater(than date: Date) -> Int {
        return max(days(from: date), 0)
    }
    
    /**
     *  Returns the number of hours the receiver's date is later than the provided
     *  comparison date, 0 if the receiver's date is earlier than or equal to the provided
     *  comparison date.
     *
     *  - parameter date: Provided date for comparison
     *
     *  - returns: The number of hours
     */
    func hoursLater(than date: Date) -> Int {
        return max(hours(from: date), 0)
    }
    
    /**
     *  Returns the number of minutes the receiver's date is later than the provided
     *  comparison date, 0 if the receiver's date is earlier than or equal to the provided
     *  comparison date.
     *
     *  - parameter date: Provided date for comparison
     *
     *  - returns: The number of minutes
     */
    func minutesLater(than date: Date) -> Int {
        return max(minutes(from: date), 0)
    }
    
    /**
     *  Returns the number of seconds the receiver's date is later than the provided
     *  comparison date, 0 if the receiver's date is earlier than or equal to the provided
     *  comparison date.
     *
     *  - parameter date: Provided date for comparison
     *
     *  - returns: The number of seconds
     */
    func secondsLater(than date: Date) -> Int {
        return max(seconds(from: date), 0)
    }
}
