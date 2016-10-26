//
//  Date+DateTools.swift
//  DateTools
//
//  Created by Grayson Webster on 8/17/16.
//  Copyright © 2016 Grayson Webster. All rights reserved.
//

import Foundation

/**
 *  Date + Inits
 *
 *  Extends the Date class by adding convenient initializers based on components
 *  and format strings.
 */

public extension Date {
    
	// MARK: - Initializers
    
    /**
     *  Init date with components.
     *
     *  @param year   Int - Year component of new date
     *  @param month  Int - Month component of new date
     *  @param day    Int - Day component of new date
     *  @param hour   Int - Hour component of new date
     *  @param minute Int - Minute component of new date
     *  @param second Int - Second component of new date
     */
	public init(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) {
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
     *  @param year   Int - Year component of new date
     *  @param month  Int - Month component of new date
     *  @param day    Int - Day component of new date
     */
	public init(year: Int, month: Int, day: Int) {
		self.init(year: year, month: month, day: day, hour: 0, minute: 0, second: 0)
	}
	
    /**
     *  Init date from string, given a format string, according to Apple's date formatting guide, and time zone.
     *
     *  @param dateString String - Date in the formatting given by the format parameter
     *  @param format     String - Format style using Apple's date formatting guide
     *  @param timeZone   TimeZone - Time zone of date
     */
	public init(dateString: String, format: String, timeZone: TimeZone) {
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
     *  @param dateString String - Date in the formatting given by the format parameter
     *  @param format     String - Format style using Apple's date formatting guide
     */
	public init (dateString: String, format: String) {
		self.init(dateString: dateString, format: format, timeZone: TimeZone.autoupdatingCurrent)
	}	
}
