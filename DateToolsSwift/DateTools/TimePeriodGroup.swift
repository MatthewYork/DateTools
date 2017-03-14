//
//  TimePeriodGroup.swift
//  DateTools
//
//  Created by Grayson Webster on 8/17/16.
//  Copyright © 2016 Grayson Webster. All rights reserved.
//

import Foundation

/** 
 *  Time period groups are the final abstraction of date and time in DateTools. Here, time 
 *  periods are gathered and organized into something useful. There are two main types of time
 *  period groups, `TimePeriodCollection` and `TimePeriodChain`.
 *
 *  [Visit our github page](https://github.com/MatthewYork/DateTools#time-period-groups) for more information.
 */
open class TimePeriodGroup: Sequence {
    
    // MARK: - Variables
    
    /**
     *  The array of periods that define the group.
     */
    internal var periods: [TimePeriodProtocol] = []
    
    internal var _beginning: Date?
    internal var _end: Date?
    
    /**
     *  The earliest beginning date of a `TimePeriod` in the group.
     *  Nil if any `TimePeriod` in group has a nil beginning date (indefinite).
     *  (Read Only)
     */
    public var beginning: Date? {
        return _beginning
    }
    
    /**
     *  The latest end date of a `TimePeriod` in the group.
     *  Nil if any `TimePeriod` in group has a nil end date (indefinite).
     *  (Read Only)
     */
    public var end: Date? {
        return _end
    }
    
    /**
     *  The number of periods in the periods array.
     */
    public var count: Int {
        return periods.count
    }
    
    /**
     *  The total amount of time between the earliest and latest dates stored in the
     *  periods array. Nil if any beginning or end date in any contained period is nil.
     */
    public var duration: TimeInterval? {
        if beginning != nil && end != nil {
            return end!.timeIntervalSince(beginning!)
        }
        return nil
    }
    
    // MARK: - Initializers
    
    public init() {
        
    }
    
    // MARK: - Comparisons
    
    /**
     *  If `self.periods` contains the exact elements as the given group's periods array.
     *
     *  - parameter group: The group to compare to self
     *
     *  - returns: True if the periods arrays are the same
     */
    public func equals(_ group: TimePeriodGroup) -> Bool {
        return containSameElements(array1: self.periods, group.periods)
    }
    

    // MARK: - Sequence Protocol
    
    public func makeIterator() -> IndexingIterator<Array<TimePeriodProtocol>> {
        return periods.makeIterator()
    }
    
    public func map<T>(_ transform: (TimePeriodProtocol) throws -> T) rethrows -> [T] {
        return try periods.map(transform)
    }
    
    public func filter(_ isIncluded: (TimePeriodProtocol) throws -> Bool) rethrows -> [TimePeriodProtocol] {
        return try periods.filter(isIncluded)
    }
    
    public func forEach(_ body: (TimePeriodProtocol) throws -> Void) rethrows {
        return try periods.forEach(body)
    }
    
    public func split(maxSplits: Int, omittingEmptySubsequences: Bool, whereSeparator isSeparator: (TimePeriodProtocol) throws -> Bool) rethrows -> [AnySequence<TimePeriodProtocol>] {
        return try periods.split(maxSplits: maxSplits, omittingEmptySubsequences: omittingEmptySubsequences, whereSeparator: isSeparator)
    }
    
    subscript(index: Int) -> TimePeriodProtocol {
        get {
            return periods[index]
        }
    }
    
    internal func reduce<Result>(_ initialResult: Result, _ nextPartialResult: (Result, TimePeriodProtocol) throws -> Result) rethrows -> Result {
        return try periods.reduce(initialResult, nextPartialResult)
    }
    
    internal func containSameElements(array1: [TimePeriodProtocol], _ array2: [TimePeriodProtocol]) -> Bool {
        guard array1.count == array2.count else {
            return false // No need to sorting if they already have different counts
        }
        
        var compArray1: [TimePeriodProtocol] = array1.sorted { (period1: TimePeriodProtocol, period2: TimePeriodProtocol) -> Bool in
            if period1.beginning == nil && period2.beginning == nil {
                return false
            } else if (period1.beginning == nil) {
                return true
            } else if (period2.beginning == nil) {
                return false
            } else {
                return period2.beginning! < period1.beginning!
            }
        }
        var compArray2: [TimePeriodProtocol] = array2.sorted { (period1: TimePeriodProtocol, period2: TimePeriodProtocol) -> Bool in
            if period1.beginning == nil && period2.beginning == nil {
                return false
            } else if (period1.beginning == nil) {
                return true
            } else if (period2.beginning == nil) {
                return false
            } else {
                return period2.beginning! < period1.beginning!
            }
        }
        for x in 0..<compArray1.count {
            if !compArray1[x].equals(compArray2[x]) {
                return false
            }
        }
        return true
    }
}
