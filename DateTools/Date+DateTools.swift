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

public extension Date {
    
	// MARK: - Initializers
    
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
}
