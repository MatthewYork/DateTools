//
//  TimePeriodChain.swift
//  DateTools
//
//  Created by Grayson Webster on 8/17/16.
//  Copyright © 2016 Grayson Webster. All rights reserved.
//

import Foundation

/**
 *  # TimePeriodChain
 *  Time period chains serve as a tightly coupled set of time periods. They are
 *  always organized by start and end date, and have their own characteristics like
 *  a StartDate and EndDate that are extrapolated from the time periods within. Time 
 *  period chains do not allow overlaps within their set of time periods. This type of 
 *  group is ideal for modeling schedules like sequential meetings or appointments.
 *
 *  [Visit our github page](https://github.com/MatthewYork/DateTools#time-period-chains) for more information.
 */
open class TimePeriodChain: TimePeriodGroup {
    
    // MARK: - Chain Existence Manipulation
    
    /*
     *  # Append (Time Period Protocol)
     *  Append a TimePeriodProtocol to the periods array and update the Chain's
     *  beginning and end.
     *
     *  @param period TimePeriodProtocol - TimePeriodProtocol to add to the collection
     */
    func append(_ period: TimePeriodProtocol) {
        let beginning = (self.periods.count > 0) ? self.periods.last!.end! : period.beginning
        
        let newPeriod = TimePeriod(beginning: beginning!, duration: period.duration)
        self.periods.append(newPeriod)
        
        //Update updateExtremes
        if periods.count == 1 {
            _beginning = period.beginning
            _end = period.end
        }
        else {
            _end = _end?.addingTimeInterval(period.duration)
        }
    }
    
    /*
     *  # Append (List of Time Period Protocols)
     *  Append a TimePeriodProtocol array to the periods array and update the Chain's
     *  beginning and end.
     *
     *  @param periodArray [TimePeriodProtocol] - TimePeriodProtocol list to add to the collection
     */
    func append<G: TimePeriodGroup>(contentsOf group: G) {
        for period in group.periods {
            let beginning = (self.periods.count > 0) ? self.periods.last!.end! : period.beginning
            
            let newPeriod = TimePeriod(beginning: beginning!, duration: period.duration)
            self.periods.append(newPeriod)
            
            //Update updateExtremes
            if periods.count == 1 {
                _beginning = period.beginning
                _end = period.end
            }
            else {
                _end = _end?.addingTimeInterval(period.duration)
            }
        }
    }
    
    /*
     *  # Insert (Time Period Protocol)
     *  Insert period into periods array at given index.
     *
     *  @param newElement TimePeriodProtocol - The period to insert
     *  @param i Int - Index to insert period at
     */
    func insert(_ period: TimePeriodProtocol, at index: Int) {
        //Check for special zero case which takes the beginning date
        if index == 0 && period.beginning != nil && period.end != nil {
            //Insert new period
            periods.insert(period, at: index)
        }
        else if period.beginning != nil && period.end != nil {
            //Insert new period
            periods.insert(period, at: index)
        }
        else {
            print("All TimePeriods in a TimePeriodChain must contain a defined start and end date")
            return
        }
        
        //Shift all periods after inserted period
        for i in 0..<periods.count {
            if i > index && i > 0 {
                let currentPeriod = TimePeriod(beginning: period.beginning, end: period.end)
                periods[i].beginning = periods[i-1].end
                periods[i].end = periods[i].beginning!.addingTimeInterval(currentPeriod.duration)
            }
        }
        
        updateExtremes()
    }
    
    /*
     *  # Remove At (Int)
     *  Remove from period array at the given index.
     *
     *  @param at Int - The index in the collection to remove
     */
    func remove(at index: Int) {
        //Retrieve duration of period to be removed
        let duration = periods[index].duration
        
        //Remove period
        periods.remove(at: index)
        
        //Shift all periods after inserted period
        for i in index..<periods.count {
            periods[i].shift(by: -duration)
        }
        updateExtremes()
    }
    
    /*
     *  # Remove All
     *  Remove all periods from period array.
     */
    func removeAll() {
        self.periods.removeAll()
        updateExtremes()
    }
    
    //MARK: - Chain Content Manipulation
    
    /**
     *  # Shift By (Time Interval)
     *  In place, shifts all chain time periods by a given time interval
     *
     *  @param duration TimeInterval - The time interval to shift the period by
     */
    func shift(by duration: TimeInterval) {
        for var period in self.periods {
            period.shift(by:duration)
        }
        
        _beginning = _beginning?.addingTimeInterval(duration)
        _end = _end?.addingTimeInterval(duration)
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
    
    /**
     *  # Pop time Interval
     *  Removes the last object from the `TimePeriodChain` and returns it
     *
     */
    func pop() -> TimePeriodProtocol? {
        let period = self.periods.popLast()
        updateExtremes()
        
        return period
    }
    
    internal func updateExtremes() {
        _beginning = periods.first?.beginning
        _end = periods.last?.end
    }
    
    // MARK: - Operator Overloads
    
    /**
     *  Operator overload for comparing `TimePeriodChain`s to each other
     */
    static func ==(left: TimePeriodChain, right: TimePeriodChain) -> Bool {
        return left.equals(right)
    }

}
