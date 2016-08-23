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
	static func date(with year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) -> Date? {
		var dateComponents = DateComponents()
		dateComponents.year = year
		dateComponents.month = month
		dateComponents.day = day
		dateComponents.hour = hour
		dateComponents.minute = minute
		dateComponents.second = second
		
		let date = Calendar.current.date(from: dateComponents)
		return date;
		
	}
	
	static func date(with year: Int, month: Int, day: Int) -> Date? {
		return date(with: year, month: month, day: day, hour: 0, minute: 0, second: 0)
	}
	
	static func date(with dateString: String, format: String, timeZone: TimeZone) -> Date? {
		let dateFormatter = DateFormatter()
		dateFormatter.dateStyle = .none;
		dateFormatter.timeStyle = .none;
		dateFormatter.timeZone = timeZone;
		dateFormatter.dateFormat = format;
		
		let date = dateFormatter.date(from: dateString)
		return date
	}
	
	static func date(with dateString: String, format: String) -> Date? {
		return date(with: dateString, format: format, timeZone: TimeZone.current)
	}
}
