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
open class TimePeriodGroup: Sequence {
    
    // MARK: - Variables
    
    internal var periods: [TimePeriodProtocol] = []
    
    internal var _beginning: Date?
    internal var _end: Date?
    
    var beginning: Date? {
        return _beginning
    }
    var end: Date? {
        return _end
    }
    
    var count: Int {
        return periods.count
    }
    
    var duration: TimeInterval {
        if beginning != nil && end != nil {
            return beginning!.timeIntervalSince(end!)
        }
        return 0
    }
    
    
    // MARK: - Comparisons
    
    func equals(group: TimePeriodGroup) -> Bool {
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
    
    internal func reduce<Result>(_ initialResult: Result, _ nextPartialResult: (Result, TimePeriodProtocol) throws -> Result) rethrows -> Result {
        return try periods.reduce(initialResult, nextPartialResult)
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
    
    
    internal func containSameElements(array1: [TimePeriodProtocol], _ array2: [TimePeriodProtocol]) -> Bool {
        guard array1.count == array2.count else {
            return false // No need to sorting if they already have different counts
        }
        
        var compArray1: [TimePeriodProtocol] = array1.sorted {$0.beginning! < $1.beginning!}
        var compArray2: [TimePeriodProtocol] = array2.sorted {$0.beginning! < $1.beginning!}
        for x in 0..<compArray1.count {
            if !compArray1[x].equals(period: compArray2[x]) {
                return false
            }
        }
        return true
    }
}
