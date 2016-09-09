//
//  TimePeriodChain.swift
//  DateTools
//
//  Created by Grayson Webster on 8/17/16.
//  Copyright © 2016 Grayson Webster. All rights reserved.
//

import Foundation

/**
    # TimePeriodChain
    
    Time period chains serve as a tightly coupled set of time periods. They are always organized by start and end date, and have their own characteristics like a StartDate and EndDate that are extrapolated from the time periods within. Time period chains do not allow overlaps within their set of time periods. This type of group is ideal for modeling schedules like sequential meetings or appointments.
 
    [Visit our github page](https://github.com/MatthewYork/DateTools#time-period-chains) for more information.
 */
class TimePeriodChain: TimePeriodGroup {
    
    // MARK: - Chain Existence Manipulation
    
    func append<T: TimePeriodProtocol>(_ period: T) {
        
    }
    
    func append<C: TimePeriodGroup>(_ group: C) {
        
    }
    
    func remove(at index: Int) {
        
    }
    
    func removeAll() {
        
    }
    
    internal override func map<T>(_ transform: (TimePeriodProtocol) throws -> T) rethrows -> [T] {
        return try periods.map(transform)
    }
    
    internal override func filter(_ isIncluded: (TimePeriodProtocol) throws -> Bool) rethrows -> [TimePeriodProtocol] {
        return try periods.filter(isIncluded)
    }
    
    internal override func reduce<Result>(_ initialResult: Result, _ nextPartialResult: (Result, TimePeriodProtocol) throws -> Result) rethrows -> Result {
        return try periods.reduce(initialResult, nextPartialResult)
    }
    
    func pop() -> TimePeriodProtocol {
        return TimePeriod()
    }
    
    
    
    // MARK: - Chain Relationship
    
    func equals(chain: TimePeriodChain) {
        
    }
    
    
    // MARK: - Updates
    
    func updateVariables() {
        
    }
    
}
