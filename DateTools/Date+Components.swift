//
//  Date+Components.swift
//  DateToolsTests
//
//  Created by Matthew York on 8/26/16.
//  Copyright © 2016 Matthew York. All rights reserved.
//

import Foundation

/**
 *  Date + Components
 *
 *  Extends the Date class by adding convenient accessors of calendar
 *  components. Meta information about the date is also accessible via
 *  several computed Bools.
 */
public extension Date {

    /**
     *  # Component
     *  Convenient accessor of the date's `Calendar` components
     *
     *  @param component Calendar.Component - The calendar component to access from the date
     *
     *  @return Int - The value of the component
     *
     */
    func component(_ component: Calendar.Component) -> Int {
		let calendar = Calendar.autoupdatingCurrent
		return calendar.component(component, from: self)
	}
	
    /**
     *  # Ordinality
     *  Convenient accessor of the date's `Calendar` components ordinality
     *
     *  @param smaller Calendar.Component - The smaller calendar component to access from the date
     *  @param larger  Calendar.Component - The larger calendar component to access from the date
     *
     *  @return Int - The ordinal number of a smaller calendar component within a specified larger calendar component
     *
     */
	func ordinality(of smaller: Calendar.Component, in larger: Calendar.Component) -> Int? {
		let calendar = Calendar.autoupdatingCurrent
		return calendar.ordinality(of: smaller, in: larger, for: self)
	}
	
    /**
     *  # Unit
     *  Use calendar components to determine how many units of a smaller component are inside 1 larger unit.
     *  Ex. If used on a date in the month of February in a leap year (regardless of the day), the method would
     *  return 29 days.
     *
     *  @param smaller Calendar.Component - The smaller calendar component to access from the date
     *  @param larger  Calendar.Component - The larger calendar component to access from the date
     *
     *  @return Int - The number of smaller units required to equal in 1 larger unit, given the date called on
     *
     */
	func unit(of smaller: Calendar.Component, in larger: Calendar.Component) -> Int? {
		let calendar = Calendar.autoupdatingCurrent
        var units = 1
        var unitRange: Range<Int>?
        if larger.hashValue < smaller.hashValue {
            for x in larger.hashValue..<smaller.hashValue {
                
                var stepLarger: Calendar.Component
                var stepSmaller: Calendar.Component
                
                switch(x) {
                case 0:
                    stepLarger = Calendar.Component.era
                    stepSmaller = Calendar.Component.year
                    unitRange = calendar.range(of: stepSmaller, in: stepLarger, for: self)
                    break
                case 1:
                    if smaller.hashValue > 2 {
                        break
                    } else {
                        stepLarger = Calendar.Component.year
                        stepSmaller = Calendar.Component.month
                        unitRange = calendar.range(of: stepSmaller, in: stepLarger, for: self)
                    }
                    break
                case 2:
                    if larger.hashValue < 2 {
                        if self.isInLeapYear {
                            unitRange = Range.init(uncheckedBounds: (lower: 0, upper: 366))
                        } else {
                            unitRange = Range.init(uncheckedBounds: (lower: 0, upper: 365))
                        }
                    } else {
                        stepLarger = Calendar.Component.month
                        stepSmaller = Calendar.Component.day
                        unitRange = calendar.range(of: stepSmaller, in: stepLarger, for: self)
                    }
                    break
                case 3:
                    stepLarger = Calendar.Component.day
                    stepSmaller = Calendar.Component.hour
                    unitRange = calendar.range(of: stepSmaller, in: stepLarger, for: self)
                    break
                case 4:
                    stepLarger = Calendar.Component.hour
                    stepSmaller = Calendar.Component.minute
                    unitRange = calendar.range(of: stepSmaller, in: stepLarger, for: self)
                    break
                case 5:
                    stepLarger = Calendar.Component.minute
                    stepSmaller = Calendar.Component.second
                    unitRange = calendar.range(of: stepSmaller, in: stepLarger, for: self)
                    break
                default:
                    return nil
                }
                
                if unitRange?.count != nil {
                    units *= (unitRange?.count)!
                }
            }
            return units
        }
        return nil
	}
	
	// MARK: - Components
	
	var era: Int {
		return component(.era)
	}
	
	var year: Int {
		return component(.year)
	}
	
	var month: Int {
		return component(.month)
	}
	
	var week: Int {
		return component(.weekday)
	}
	
	var day: Int {
		return component(.day)
	}
	
	var hour: Int {
		return component(.hour)
	}
	
	var minute: Int {
		return component(.minute)
	}
	
	var second: Int {
		return component(.second)
	}
	
	var weekday: Int {
		return component(.weekday)
	}
	
	var weekdayOrdinal: Int {
		return component(.weekdayOrdinal)
	}
	
	var quarter: Int {
		return component(.quarter)
	}
	
	var weekOfMonth: Int {
		return component(.weekOfMonth)
	}
	
	var weekOfYear: Int {
		return component(.weekOfYear)
	}
	
	var yearForWeekOfYear: Int {
		return component(.yearForWeekOfYear)
	}
    
    var daysInMonth: Int {
        let calendar = Calendar.autoupdatingCurrent
        let days = calendar.range(of: .day, in: .month, for: self)
        return days!.count
    }
    
    // MARK: - Set Components
    
    mutating func year(_ year: Int) {
        self = Date.init(year: year, month: self.month, day: self.day, hour: self.hour, minute: self.minute, second: self.second)
    }
    
    mutating func month(_ month: Int) {
        self = Date.init(year: self.year, month: month, day: self.day, hour: self.hour, minute: self.minute, second: self.second)
    }
    
    mutating func day(_ day: Int) {
        self = Date.init(year: self.year, month: self.month, day: day, hour: self.hour, minute: self.minute, second: self.second)
    }
    
    mutating func hour(_ hour: Int) {
        self = Date.init(year: self.year, month: self.month, day: self.day, hour: hour, minute: self.minute, second: self.second)
    }
    
    mutating func minute(_ minute: Int) {
        self = Date.init(year: self.year, month: self.month, day: self.day, hour: self.hour, minute: minute, second: self.second)
    }
    
    mutating func second(_ second: Int) {
        self = Date.init(year: self.year, month: self.month, day: self.day, hour: self.hour, minute: self.minute, second: second)
    }
    
    
    // MARK: - Bools
	
	var isInLeapYear: Bool {
		let yearComponent = component(.year)
		
		if yearComponent % 400 == 0 {
			return true
		}
		if yearComponent % 100 == 0 {
			return false
		}
		if yearComponent % 4 == 0 {
			return true
		}
		return false
	}
	
	var isToday: Bool {
		let calendar = Calendar.autoupdatingCurrent
		return calendar.isDateInToday(self)
	}
	
	var isTomorrow: Bool {
		let calendar = Calendar.autoupdatingCurrent
        return calendar.isDateInTomorrow(self)
	}
	
	var isYesterday: Bool {
		let calendar = Calendar.autoupdatingCurrent
        return calendar.isDateInYesterday(self)
	}
	
	var isWeekend: Bool {
		if weekday == 7 || weekday == 1 {
			return true
		}
		return false
	}
}
