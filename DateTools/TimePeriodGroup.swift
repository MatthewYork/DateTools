//
//  TimePeriodGroup.swift
//  DateTools
//
//  Created by Grayson Webster on 8/17/16.
//  Copyright © 2016 Grayson Webster. All rights reserved.
//

import Foundation

/** 
    # TimePeriodGroup
 
    Time period groups are the final abstraction of date and time in DateTools. Here, time periods are gathered and organized into something useful. There are two main types of time period groups, ```TimePeriodCollection``` and ```TimePeriodChain```.
 
    [Visit our github page](https://github.com/MatthewYork/DateTools#time-period-groups) for more information.
 */
class TimePeriodGroup: Sequence {
    
    // MARK: - Variables
    internal var _beginning: Date?
    internal var _end: Date?
    
    var beginning: Date? {
        return _beginning
    }
    var end: Date? {
        return _end
    }
    
    internal var periods: [TimePeriodProtocol] = []
    
    var count: Int {
        return periods.count
    }
    
    var duration: TimeInterval {
        if beginning != nil && end != nil {
            return beginning!.timeBetween(date: end!)
        }
        return 0
    }
    
    // MARK: - Mutations
    
    func append(_ period: TimePeriodProtocol) {
        periods.append(period)
        updateExtremes(period: period)
    }
    
    func append<C : Collection>(_ collection: C) where C.Iterator.Element == TimePeriodProtocol {
        periods.append(contentsOf: collection)
        for period in collection {
            updateExtremes(period: period)
        }
        
    }
    
    // MARK: - Sequence Protocol
    func makeIterator() -> IndexingIterator<Array<TimePeriodProtocol>> {
        return periods.makeIterator()
    }
    
    func map<T>(_ transform: (TimePeriodProtocol) throws -> T) rethrows -> [T] {
        return try periods.map(transform)
    }
    
    func filter(_ isIncluded: (TimePeriodProtocol) throws -> Bool) rethrows -> [TimePeriodProtocol] {
        return try periods.filter(isIncluded)
    }
    
    func reduce<Result>(_ initialResult: Result, _ nextPartialResult: (Result, TimePeriodProtocol) throws -> Result) rethrows -> Result {
        return try periods.reduce(initialResult, nextPartialResult)
    }
    
    func forEach(_ body: (TimePeriodProtocol) throws -> Void) rethrows {
        return try periods.forEach(body)
    }
    
    func split(maxSplits: Int, omittingEmptySubsequences: Bool, whereSeparator isSeparator: (TimePeriodProtocol) throws -> Bool) rethrows -> [AnySequence<TimePeriodProtocol>] {
        return try periods.split(maxSplits: maxSplits, omittingEmptySubsequences: omittingEmptySubsequences, whereSeparator: isSeparator)
    }
    
    internal func updateExtremes(period: TimePeriodProtocol) {
        if beginning != nil && period.beginning != nil {
            _beginning = beginning!.earlierDate(period.beginning!)
            _end = end!.laterDate(period.end!)
        } else {
            if let uBeginning = period.beginning {
                _beginning = uBeginning
            }
        }
    }
}
