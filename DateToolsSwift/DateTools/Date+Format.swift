//
//  Date+Format.swift
//  DateToolsTests
//
//  Created by Matthew York on 8/23/16.
//  Copyright © 2016 Matthew York. All rights reserved.
//

import Foundation

/**
 *  Extends the Date class by adding convenience methods for formatting dates.
 */
public extension Date {
    
    // MARK: - Formatted Date - Style
    
    /**
     *  Get string representation of date.
     *
     *  - parameter dateStyle: The date style in which to represent the date
     *  - parameter timeZone: The time zone of the date
     *  - parameter locale: Encapsulates information about linguistic, cultural, and technological conventions and standards
     *
     *  - returns: Represenation of the date (self) in the specified format
     */
    public func format(with dateStyle: DateFormatter.Style, timeZone: TimeZone, locale: Locale) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = dateStyle
        dateFormatter.timeZone = timeZone
        dateFormatter.locale = locale
        
        return dateFormatter.string(from: self)
    }
    
    /**
     *  Get string representation of date. Locale is automatically selected as the current locale of the system.
     *
     *  - parameter dateStyle: The date style in which to represent the date
     *  - parameter timeZone: The time zone of the date
     *
     *  - returns String? - Represenation of the date (self) in the specified format
     */
    public func format(with dateStyle: DateFormatter.Style, timeZone: TimeZone) -> String {
        #if os(Linux)
            return format(with: dateStyle, timeZone: timeZone, locale: Locale.current)
        #else
            return format(with: dateStyle, timeZone: timeZone, locale: Locale.autoupdatingCurrent)
        #endif
    }
    
    /**
     *  Get string representation of date.
     *  Time zone is automatically selected as the current time zone of the system.
     *
     *  - parameter dateStyle: The date style in which to represent the date
     *  - parameter locale: Encapsulates information about linguistic, cultural, and technological conventions and standards.
     *
     *  - returns: Represenation of the date (self) in the specified format
     */
    public func format(with dateStyle: DateFormatter.Style, locale: Locale) -> String {
        return format(with: dateStyle, timeZone: TimeZone.autoupdatingCurrent, locale: locale)
    }
    
    /**
     *  Get string representation of date.
     *  Locale and time zone are automatically selected as the current locale and time zone of the system.
     *
     *  - parameter dateStyle: The date style in which to represent the date
     *
     *  - returns: Represenation of the date (self) in the specified format
     */
    public func format(with dateStyle: DateFormatter.Style) -> String {
        #if os(Linux)
            return format(with: dateStyle, timeZone: TimeZone.autoupdatingCurrent, locale: Locale.current)
        #else
            return format(with: dateStyle, timeZone: TimeZone.autoupdatingCurrent, locale: Locale.autoupdatingCurrent)
        #endif
    }
    
    
    // MARK: - Formatted Date - String
    
    /**
     *  Get string representation of date.
     *
     *  - parameter dateFormat: The date format string, according to Apple's date formatting guide in which to represent the date
     *  - parameter timeZone: The time zone of the date
     *  - parameter locale: Encapsulates information about linguistic, cultural, and technological conventions and standards
     *
     *  - returns: Represenation of the date (self) in the specified format
     */
    public func format(with dateFormat: String, timeZone: TimeZone, locale: Locale) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.timeZone = timeZone
        dateFormatter.locale = locale
        
        return dateFormatter.string(from: self)
    }
    
    /**
     *  Get string representation of date.
     *  Locale is automatically selected as the current locale of the system.
     *
     *  - parameter dateFormat: The date format string, according to Apple's date formatting guide in which to represent the date
     *  - parameter timeZone: The time zone of the date
     *
     *  - returns: Representation of the date (self) in the specified format
     */
    public func format(with dateFormat: String, timeZone: TimeZone) -> String {
        #if os(Linux)
            return format(with: dateFormat, timeZone: timeZone, locale: Locale.current)
        #else
            return format(with: dateFormat, timeZone: timeZone, locale: Locale.autoupdatingCurrent)
        #endif
    }
    
    /**
     *  Get string representation of date.
     *  Time zone is automatically selected as the current time zone of the system.
     *
     *  - parameter dateFormat: The date format string, according to Apple's date formatting guide in which to represent the date
     *  - parameter locale: Encapsulates information about linguistic, cultural, and technological conventions and standards
     *
     *  - returns: Represenation of the date (self) in the specified format
     */
    public func format(with dateFormat: String, locale: Locale) -> String {
        return format(with: dateFormat, timeZone: TimeZone.autoupdatingCurrent, locale: locale)
    }
    
    /**
     *  Get string representation of date.
     *  Locale and time zone are automatically selected as the current locale and time zone of the system.
     *
     *  - parameter dateFormat: The date format string, according to Apple's date formatting guide in which to represent the date
     *
     *  - returns: Represenation of the date (self) in the specified format
     */
    public func format(with dateFormat: String) -> String {
        #if os(Linux)
            return format(with: dateFormat, timeZone: TimeZone.autoupdatingCurrent, locale: Locale.current)
        #else
            return format(with: dateFormat, timeZone: TimeZone.autoupdatingCurrent, locale: Locale.autoupdatingCurrent)
        #endif
    }
}
