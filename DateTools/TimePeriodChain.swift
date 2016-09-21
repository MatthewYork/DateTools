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
open class TimePeriodChain: TimePeriodGroup {
    
    // MARK: - Chain Existence Manipulation
    
    func append(_ period: TimePeriodProtocol) {
        let newPeriod = TimePeriod(beginning: self.periods[self.periods.count-1].end!, duration: period.duration)
        self.periods.append(newPeriod)
        updateExtremes()
    }
    
    func append<G: TimePeriodGroup>(contentsOf group: G) {
        for period in group.periods {
            let newPeriod = TimePeriod(beginning: self.periods[self.periods.count-1].end!, duration: period.duration)
            self.periods.append(newPeriod)
        }
        updateExtremes()
    }
    
    func insert(_ period: TimePeriod, at index: Int) {
        let newPeriod: TimePeriodProtocol
        //Check for special zero case which takes the beginning date
        if index == 0 && period.beginning != nil {
            //Insert new period
            newPeriod = TimePeriod(beginning: self.periods[index].beginning!, duration: period.duration)
            periods.insert(period, at: index)
        }
        else {
            //Insert new period
            newPeriod = TimePeriod(beginning: self.periods[self.periods.count-1].end!, duration: period.duration)
            periods.insert(period, at: index)
        }
        
        //Shift all periods after inserted period
        for i in 0..<periods.count {
            if i > index {
                periods[i].beginning = periods[i].beginning!.addingTimeInterval(newPeriod.duration)
                periods[i].end = periods[i].end!.addingTimeInterval(newPeriod.duration)
            }
        }
        updateExtremes()
    }
    
    func remove(at index: Int) {
        //Retrieve duration of period to be removed
        let duration = periods[index].duration
        
        //Remove period
        periods.remove(at: index)
        
        //Shift all periods after inserted period
        for i in 0..<periods.count {
            if i > index {
                periods[i].beginning = periods[i].beginning!.addingTimeInterval(-duration)
                periods[i].end = periods[i].end!.addingTimeInterval(-duration)
            }
        }
        updateExtremes()
    }
    
    func removeAll() {
        self.periods.removeAll()
        updateExtremes()
    }
    
    public override func map<T>(_ transform: (TimePeriodProtocol) throws -> T) rethrows -> [T] {
        return try periods.map(transform)
    }
    
    public override func filter(_ isIncluded: (TimePeriodProtocol) throws -> Bool) rethrows -> [TimePeriodProtocol] {
        return try periods.filter(isIncluded)
    }
    
    internal override func reduce<Result>(_ initialResult: Result, _ nextPartialResult: (Result, TimePeriodProtocol) throws -> Result) rethrows -> Result {
        return try periods.reduce(initialResult, nextPartialResult)
    }
    
    func pop() -> TimePeriodProtocol? {
        let period = self.periods.popLast()
        updateExtremes()
        
        return period
    }
    
    internal func updateExtremes() {
        _beginning = periods.first?.beginning
        _end = periods.last?.end
    }
}
