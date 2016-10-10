//
//  Date+Format.swift
//  DateToolsTests
//
//  Created by Matthew York on 8/23/16.
//  Copyright © 2016 Matthew York. All rights reserved.
//

import Foundation

/**
 *  Date + Format
 *
 *  Extends the Date class by adding convenience methods for formatting dates.
 */
public extension Date {
    
    // MARK: - Formatted Date - Style
    
    /**
     *  @param dateStyle DateFormatter.Style - The date style in which to represent the date
     *  @param timeZone  TimeZone - The time zone of the date
     *  @param locale    Locale - Encapsulates information about linguistic, cultural, and technological conventions and standards.
     *
     *  @return String? - Represenation of the date (self) in the specified format
     */
    func format(with dateStyle: DateFormatter.Style, timeZone: TimeZone, locale: Locale) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = dateStyle
        dateFormatter.timeZone = timeZone
        dateFormatter.locale = locale
        
        return dateFormatter.string(from: self)
    }
    
    /**
     *  Locale is automatically selected as the current locale of the system
     *
     *  @param dateStyle DateFormatter.Style - The date style in which to represent the date
     *  @param timeZone  TimeZone - The time zone of the date
     *
     *  @return String? - Represenation of the date (self) in the specified format
     */
    func format(with dateStyle: DateFormatter.Style, timeZone: TimeZone) -> String? {
        #if os(Linux)
            return format(with: dateStyle, timeZone: timeZone, locale: Locale.current)
        #else
            return format(with: dateStyle, timeZone: timeZone, locale: Locale.autoupdatingCurrent)
        #endif
    }
    
    /**
     *  Time zone is automatically selected as the current time zone of the system
     *
     *  @param dateStyle DateFormatter.Style - The date style in which to represent the date
     *  @param locale    Locale - Encapsulates information about linguistic, cultural, and technological conventions and standards.
     *
     *  @return String? - Represenation of the date (self) in the specified format
     */
    func format(with dateStyle: DateFormatter.Style, locale: Locale) -> String? {
        return format(with: dateStyle, timeZone: TimeZone.autoupdatingCurrent, locale: locale)
    }
    
    /**
     *  Locale and time zone are automatically selected as the current locale and time zone of the system
     *
     *  @param dateStyle DateFormatter.Style - The date style in which to represent the date
     *
     *  @return String? - Represenation of the date (self) in the specified format
     */
    func format(with dateStyle: DateFormatter.Style) -> String? {
        #if os(Linux)
            return format(with: dateStyle, timeZone: TimeZone.autoupdatingCurrent, locale: Locale.current)
        #else
            return format(with: dateStyle, timeZone: TimeZone.autoupdatingCurrent, locale: Locale.autoupdatingCurrent)
        #endif
    }
    
    
    // MARK: - Formatted Date - String
    
    /**
     *  @param dateFormat String - The date format string, according to Apple's date formatting guide in which to represent the date
     *  @param timeZone   TimeZone - The time zone of the date
     *  @param locale     Locale - Encapsulates information about linguistic, cultural, and technological conventions and standards.
     *
     *  @return String? - Represenation of the date (self) in the specified format
     */
    func format(with dateFormat: String, timeZone: TimeZone, locale: Locale) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.timeZone = timeZone
        dateFormatter.locale = locale
        
        return dateFormatter.string(from: self)
    }
    
    /**
     *  Locale is automatically selected as the current locale of the system
     *
     *  @param dateFormat String - The date format string, according to Apple's date formatting guide in which to represent the date
     *  @param timeZone   TimeZone - The time zone of the date
     *
     *  @return String? - Represenation of the date (self) in the specified format
     */
    func format(with dateFormat: String, timeZone: TimeZone) -> String? {
        #if os(Linux)
            return format(with: dateFormat, timeZone: timeZone, locale: Locale.current)
        #else
            return format(with: dateFormat, timeZone: timeZone, locale: Locale.autoupdatingCurrent)
        #endif
    }
    
    /**
     *  Time zone is automatically selected as the current time zone of the system
     *
     *  @param dateFormat String - The date format string, according to Apple's date formatting guide in which to represent the date
     *  @param locale     Locale - Encapsulates information about linguistic, cultural, and technological conventions and standards.
     *
     *  @return String? - Represenation of the date (self) in the specified format
     */
    func format(with dateFormat: String, locale: Locale) -> String? {
        return format(with: dateFormat, timeZone: TimeZone.autoupdatingCurrent, locale: locale)
    }
    
    /**
     *  Locale and time zone are automatically selected as the current locale and time zone of the system
     *
     *  @param dateFormat String - The date format string, according to Apple's date formatting guide in which to represent the date
     *
     *  @return String? - Represenation of the date (self) in the specified format
     */
    func format(with dateFormat: String) -> String? {
        #if os(Linux)
            return format(with: dateFormat, timeZone: TimeZone.autoupdatingCurrent, locale: Locale.current)
        #else
            return format(with: dateFormat, timeZone: TimeZone.autoupdatingCurrent, locale: Locale.autoupdatingCurrent)
        #endif
    }
}
