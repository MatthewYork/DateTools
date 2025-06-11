//
//  TimePeriodCollection.swift
//  DateTools
//
//  Created by Grayson Webster on 8/17/16.
//  Copyright © 2016 Grayson Webster. All rights reserved.
//

import Foundation

/**
 *  Time period collections serve as loose sets of time periods. They are
 *  unorganized unless you decide to sort them, and have their own characteristics
 *  like a `beginning` and `end` that are extrapolated from the time periods within. Time
 *  period collections allow overlaps within their set of time periods.
 *
 *  [Visit our github page](https://github.com/MatthewYork/DateTools#time-period-collections) for more information.
 */
open class TimePeriodCollection: TimePeriodGroup {
    
    // MARK: - Collection Manipulation
    
    /**
     *  Append a TimePeriodProtocol to the periods array and check if the Collection's
     *  beginning and end should change.
     *  
     * - parameter period: TimePeriodProtocol to add to the collection
     */
    public func append(_ period: TimePeriodProtocol) {
        periods.append(period)
        updateExtremes(period: period)
    }
    
    /**
     *  Append a TimePeriodProtocol array to the periods array and check if the Collection's
     *  beginning and end should change.
     *
     * - parameter periodArray: TimePeriodProtocol list to add to the collection
     */
    public func append(_ periodArray: [TimePeriodProtocol]) {
        for period in periodArray {
            periods.append(period)
            updateExtremes(period: period)
        }
    }
    
    /**
     *  Append a TimePeriodGroup's periods array to the periods array of self and check if the Collection's
     *  beginning and end should change.
     *
     * - parameter newPeriods: TimePeriodGroup to merge periods arrays with
     */
    public func append<C: TimePeriodGroup>(contentsOf newPeriods: C) {
        for period in newPeriods as TimePeriodGroup {
            periods.append(period)
            updateExtremes(period: period)
        }
    }
    
    /**
     *  Insert period into periods array at given index.
     *
     * - parameter newElement: The period to insert
     * - parameter index: Index to insert period at
     */
    public func insert(_ newElement: TimePeriodProtocol, at index: Int) {
        periods.insert(newElement, at: index)
        updateExtremes(period: newElement)
    }
    
    /**
     *  Remove from period array at the given index.
     *
     * - parameter at: The index in the collection to remove
     */
    public func remove(at: Int) {
        periods.remove(at: at)
        updateExtremes()
    }
    
    /**
     *  Remove all periods from period array.
     */
    public func removeAll() {
        periods.removeAll()
        updateExtremes()
    }
    
    
    // MARK: - Sorting
    
    // In place
    /**
     *  Sort periods array in place by beginning
     */
    public func sortByBeginning() {
        self.sort { (period1: TimePeriodProtocol, period2: TimePeriodProtocol) -> Bool in
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
    }
    
    /**
     *  Sort periods array in place
     */
    public func sort(by areInIncreasingOrder: (TimePeriodProtocol, TimePeriodProtocol) -> Bool) {
        self.periods.sort(by: areInIncreasingOrder)
    }
    
    // New collection
    /**
     *  Return collection with sorted periods array by beginning
     *
     * - returns: Collection with sorted periods
     */
    public func sortedByBeginning() -> TimePeriodCollection {
        let array = self.periods.sorted { (period1: TimePeriodProtocol, period2: TimePeriodProtocol) -> Bool in
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
        let collection = TimePeriodCollection()
        collection.append(array)
        return collection
    }
    
    /**
     *  Return collection with sorted periods array
     *
     * - returns: Collection with sorted periods
     */
    public func sorted(by areInIncreasingOrder: (TimePeriodProtocol, TimePeriodProtocol) -> Bool) -> TimePeriodCollection {
        let collection = TimePeriodCollection()
        collection.append(self.periods.sorted(by: areInIncreasingOrder))
        return collection
    }
    
    
    // MARK: - Collection Relationship
    
    // Potentially use .reduce() instead of these functions
    /**
     *  Returns from the `TimePeriodCollection` a sub-collection of `TimePeriod`s
     *  whose start and end dates fall completely inside the interval of the given `TimePeriod`.
     *
     * - parameter period: The period to compare each other period against
     *
     * - returns: Collection of periods inside the given period
     */
    public func allInside(in period: TimePeriodProtocol) -> TimePeriodCollection {
        let collection = TimePeriodCollection()
        // Filter by period
        collection.periods = self.periods.filter({ (timePeriod: TimePeriodProtocol) -> Bool in
            return timePeriod.isInside(of: period)
        })
        return collection
    }
    
    /**
     *  Returns from the `TimePeriodCollection` a sub-collection of `TimePeriod`s containing 
     *  the given date.
     *
     * - parameter date: The date to compare each period to
     *
     * - returns: Collection of periods intersected by the given date
     */
    public func periodsIntersected(by date: Date) -> TimePeriodCollection {
        let collection = TimePeriodCollection()
        // Filter by period
        collection.periods = self.periods.filter({ (timePeriod: TimePeriodProtocol) -> Bool in
            return timePeriod.contains(date, interval: .closed)
        })
        return collection
    }
    
    /**
     *  Returns from the `TimePeriodCollection` a sub-collection of `TimePeriod`s 
     *  containing either the start date or the end date--or both--of the given `TimePeriod`.
     *
     *  - parameter period: The period to compare each other period to
     *
     *  - returns: Collection of periods intersected by the given period
     */
    public func periodsIntersected(by period: TimePeriodProtocol) -> TimePeriodCollection {
        let collection = TimePeriodCollection()
        //Filter by periop
        collection.periods = self.periods.filter({ (timePeriod: TimePeriodProtocol) -> Bool in
            return timePeriod.intersects(with: period)
        })
        return collection
    }
    
    // MARK: - Map
    
    public func map(_ transform: (TimePeriodProtocol) throws -> TimePeriodProtocol) rethrows -> TimePeriodCollection {
        var mappedArray = [TimePeriodProtocol]()
        mappedArray = try periods.map(transform)
        let mappedCollection = TimePeriodCollection()
        for period in mappedArray {
            mappedCollection.periods.append(period)
            mappedCollection.updateExtremes(period: period)
        }
        return mappedCollection
    }
    
    // MARK: - Operator Overloads
    
    /**
     *  Operator overload for comparing `TimePeriodCollection`s to each other
     */
    public static func ==(left: TimePeriodCollection, right: TimePeriodCollection) -> Bool {
        return left.equals(right)
    }
    
    //MARK: - Helpers
    
    internal func updateExtremes(period: TimePeriodProtocol) {
        //Check incoming period against previous beginning and end date
        if self.count == 1 {
            _beginning = period.beginning
            _end = period.end
        } else {
            _beginning = nilOrEarlier(date1: _beginning, date2: period.beginning)
            _end = nilOrLater(date1: _end, date2: period.end)
        }
        
    }
    
    internal func updateExtremes() {
        if periods.count == 0 {
            _beginning = nil
            _end = nil
        } else {
            _beginning = periods[0].beginning
            _end = periods[0].end
            for i in 1..<periods.count {
                _beginning = nilOrEarlier(date1: _beginning, date2: periods[i].beginning)
                _end = nilOrEarlier(date1: _end, date2: periods[i].end)
            }
        }
    }
    
    internal func nilOrEarlier(date1: Date?, date2: Date?) -> Date? {
        if date1 == nil || date2 == nil {
            return nil
        } else {
            return date1!.earlierDate(date2!)
        }
    }
    
    internal func nilOrLater(date1: Date?, date2: Date?) -> Date? {
        if date1 == nil || date2 == nil {
            return nil
        } else {
            return date1!.laterDate(date2!)
        }
    }
}
