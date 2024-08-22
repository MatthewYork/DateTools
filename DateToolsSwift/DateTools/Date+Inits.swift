//
//  Date+DateTools.swift
//  DateTools
//
//  Created by Grayson Webster on 8/17/16.
//  Copyright © 2016 Grayson Webster. All rights reserved.
//

import Foundation

/**
 *  Extends the Date class by adding convenient initializers based on components
 *  and format strings.
 */

public extension Date {
    
	// MARK: - Initializers
    
    /**
     *  Init date with components.
     *
     *  - parameter year: Year component of new date
     *  - parameter month: Month component of new date
     *  - parameter day: Day component of new date
     *  - parameter hour: Hour component of new date
     *  - parameter minute: Minute component of new date
     *  - parameter second: Second component of new date
     */
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
	
    /**
     *  Init date with components. Hour, minutes, and seconds set to zero.
     *
     *  - parameter year: Year component of new date
     *  - parameter month: Month component of new date
     *  - parameter day: Day component of new date
     */
    init(year: Int, month: Int, day: Int) {
		self.init(year: year, month: month, day: day, hour: 0, minute: 0, second: 0)
	}
	
    /**
     *  Init date from string, given a format string, according to Apple's date formatting guide, and time zone.
     *
     *  - parameter dateString: Date in the formatting given by the format parameter
     *  - parameter format: Format style using Apple's date formatting guide
     *  - parameter timeZone: Time zone of date
     */
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
	
    /**
     *  Init date from string, given a format string, according to Apple's date formatting guide.
     *  Time Zone automatically selected as the current time zone.
     *
     *  - parameter dateString: Date in the formatting given by the format parameter
     *  - parameter format: Format style using Apple's date formatting guide
     */
    init (dateString: String, format: String) {
		self.init(dateString: dateString, format: format, timeZone: TimeZone.autoupdatingCurrent)
	}	
}
