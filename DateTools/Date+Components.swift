//
//  Date+Components.swift
//  DateToolsTests
//
//  Created by Matthew York on 8/26/16.
//  Copyright © 2016 Matthew York. All rights reserved.
//

import Foundation

public extension Date {
	func component(_ component: Calendar.Component, from date: Date) -> Int {
		let calendar = Calendar.autoupdatingCurrent
		return calendar.component(component, from: date)
	}
	
	func ordinality(of smaller: Calendar.Component, in larger: Calendar.Component, for date: Date) -> Int? {
		let calendar = Calendar.autoupdatingCurrent
		return calendar.ordinality(of: smaller, in: larger, for: date)
	}
	
	func unit(of smaller: Calendar.Component, in larger: Calendar.Component, date: Date) -> Int? {
		let calendar = Calendar.autoupdatingCurrent
		let units = calendar.range(of: .day, in: .month, for: date)
		return units?.count
	}
	
	// MARK: - Components
	
	var era: Int {
		return component(.era, from: self)
	}
	
	var year: Int {
		return component(.year, from: self)
	}
	
	var month: Int {
		return component(.month, from: self)
	}
	
	var week: Int {
		return component(.weekday, from: self)
	}
	
	var day: Int {
		return component(.day, from: self)
	}
	
	var hour: Int {
		return component(.hour, from: self)
	}
	
	var minute: Int {
		return component(.minute, from: self)
	}
	
	var second: Int {
		return component(.second, from: self)
	}
	
	var weekday: Int {
		return component(.weekday, from: self)
	}
	
	var weekdayOrdinal: Int {
		return component(.weekdayOrdinal, from: self)
	}
	
	var quarter: Int {
		return component(.quarter, from: self)
	}
	
	var weekOfMonth: Int {
		return component(.weekOfMonth, from: self)
	}
	
	var weekOfYear: Int {
		return component(.weekOfYear, from: self)
	}
	
	var yearForWeekOfYear: Int {
		return component(.yearForWeekOfYear, from: self)
	}
	
	var dayOfYear: Int {
		guard let dayOfYear = ordinality(of: .day, in: .year, for: self) else {
			return 0
		}
		return dayOfYear
	}
	
	var daysInMonth: Int {
		guard let unit = unit(of: .day, in: .month, date: self) else {
			return 0
		}
		return unit
	}
	
	var daysInYear: Int {
		guard let unit = unit(of: .day, in: .year, date: self) else {
			return 0
		}
		return unit
	}
	
	var isInLeapYear: Bool {
		let yearComponent = component(.year, from: self)
		
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
		if weekday == 6 || weekday == 7 {
			return true
		}
		return false
	}
}
