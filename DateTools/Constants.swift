//
//  Constants.swift
//  DateTools
//
//  Created by Grayson Webster on 8/17/16.
//  Copyright © 2016 Grayson Webster. All rights reserved.
//


import Foundation

/**
 *  Time conversions used across DateTools
 */
class Constants {
    static let SecondsInYear: TimeInterval = 31536000
    static let SecondsInLeapYear: TimeInterval = 31622400
    static let SecondsInMonth28: TimeInterval = 2419200
    static let SecondsInMonth29: TimeInterval = 2505600
    static let SecondsInMonth30: TimeInterval = 2592000
    static let SecondsInMonth31: TimeInterval = 2678400
    static let SecondsInWeek: TimeInterval = 604800
    static let SecondsInDay: TimeInterval = 86400
    static let SecondsInHour: TimeInterval = 3600
    static let SecondsInMinute: TimeInterval = 60
    static let MillisecondsInDay: TimeInterval = 86400000
    
    static let AllCalendarUnitFlags: Set<Calendar.Component> = [.year, .quarter, .month, .weekOfYear, .weekOfMonth, .day, .hour, .minute, .second, .era, .weekday, .weekdayOrdinal, .weekOfYear]
}
