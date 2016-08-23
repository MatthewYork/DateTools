//
//  Date+DateTools.swift
//  DateTools
//
//  Created by Grayson Webster on 8/17/16.
//  Copyright © 2016 Grayson Webster. All rights reserved.
//

import Foundation

/**

*/

extension Date {
	//MARK: Initializers
	init(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) {
		var dateComponents = DateComponents()
		dateComponents.year = year
		dateComponents.month = month
		dateComponents.day = day
		dateComponents.hour = hour
		dateComponents.minute = minute
		dateComponents.second = second
		
		guard let date = Calendar.current.date(from: dateComponents) else {
			self = Date()
			return
		}
		self = date
	}
	
	init(year: Int, month: Int, day: Int) {
		self.init(year: year, month: month, day: day, hour: 0, minute: 0, second: 0)
	}
	
	init(dateString: String, format: String, timeZone: TimeZone) {
		let dateFormatter = DateFormatter()
		dateFormatter.dateStyle = .none;
		dateFormatter.timeStyle = .none;
		dateFormatter.timeZone = timeZone;
		dateFormatter.dateFormat = format;
		
		guard let date = dateFormatter.date(from: dateString) else {
			self = Date()
			return
		}
		self = date
	}
	
	init (dateString: String, format: String) {
		self.init(dateString: dateString, format: format, timeZone: TimeZone.autoupdatingCurrent)
	}
	
	//MARK: Formatted Date - Style
	func format(with dateStyle: DateFormatter.Style, timeZone: TimeZone, locale: Locale) -> String? {
		let dateFormatter = DateFormatter()
		dateFormatter.dateStyle = .medium
		dateFormatter.timeZone = timeZone
		dateFormatter.locale = locale
		
		return dateFormatter.string(from: self)
	}
	
	func format(with dateStyle: DateFormatter.Style, timeZone: TimeZone) -> String? {
		return format(with: dateStyle, timeZone: timeZone, locale: Locale.autoupdatingCurrent)
	}
	
	func format(with dateStyle: DateFormatter.Style, locale: Locale) -> String? {
		return format(with: dateStyle, timeZone: TimeZone.autoupdatingCurrent, locale: locale)
	}
	
	func format(with dateStyle: DateFormatter.Style) -> String? {
		return format(with: dateStyle, timeZone: TimeZone.autoupdatingCurrent, locale: Locale.autoupdatingCurrent)
	}
	
	//MARK: Formatted Date - String
	func format(with dateFormat: String, timeZone: TimeZone, locale: Locale) -> String? {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = dateFormat
		dateFormatter.timeZone = timeZone
		dateFormatter.locale = locale
		
		return dateFormatter.string(from: self)
	}
	
	func format(with dateFormat: String, timeZone: TimeZone) -> String? {
		return format(with: dateFormat, timeZone: timeZone, locale: Locale.autoupdatingCurrent)
	}
	
	func format(with dateFormat: String, locale: Locale) -> String? {
		return format(with: dateFormat, timeZone: TimeZone.autoupdatingCurrent, locale: locale)
	}
	
	func format(with dateFormat: String) -> String? {
		return format(with: dateFormat, timeZone: TimeZone.autoupdatingCurrent, locale: Locale.autoupdatingCurrent)
	}
}
