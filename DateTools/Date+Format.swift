//
//  Date+Format.swift
//  DateToolsTests
//
//  Created by Matthew York on 8/23/16.
//  Copyright © 2016 Matthew York. All rights reserved.
//

import Foundation

public extension Date {
    
    // MARK: - Formatted Date - Style
    
    func format(with dateStyle: DateFormatter.Style, timeZone: TimeZone, locale: Locale) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = dateStyle
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
    
    
    // MARK: - Formatted Date - String
    
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
