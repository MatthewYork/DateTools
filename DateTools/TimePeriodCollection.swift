//
//  TimePeriodCollection.swift
//  DateTools
//
//  Created by Grayson Webster on 8/17/16.
//  Copyright © 2016 Grayson Webster. All rights reserved.
//

import Foundation

/**
    # TimePeriodCollection
    
     Time period collections serve as loose sets of time periods. They are unorganized unless you decide to sort them, and have their own characteristics like a StartDate and EndDate that are extrapolated from the time periods within. Time period collections allow overlaps within their set of time periods.
 
    [Visit our github page](https://github.com/MatthewYork/DateTools#time-period-collections) for more information.
 */
open class TimePeriodCollection: TimePeriodGroup {
    
    // MARK: - Collection Manipulation
    
    func append(_ period: TimePeriodProtocol) {
        periods.append(period)
        updateExtremes(period: period)
    }
    
    func append<C: TimePeriodGroup>(contentsOf newPeriods: C) {
        for period in newPeriods as TimePeriodGroup {
            periods.append(period)
            updateExtremes(period: period)
        }
    }
    
    func remove(at: Int) {
        periods.remove(at: at)
        updateExtremes()
    }
    
    func removeAll() {
        periods.removeAll()
        updateExtremes()
    }
    
    func insert(_ newElement: TimePeriodProtocol, at i: Int) {
        periods.insert(newElement, at: i)
        updateExtremes(period: newElement)
    }
    
    
    // MARK: - Sorting
    
    // In place
    func sort() {
        self.periods.sort { $0.beginning! < $1.beginning! }
    }
    
    func sort(by areInIncreasingOrder: (TimePeriodProtocol, TimePeriodProtocol) -> Bool) {
        self.periods.sort { $0.beginning! < $1.beginning! }
    }
    
    // New collection
    func sorted() -> TimePeriodCollection {
        let array = self.periods.sorted { $0.beginning! < $1.beginning! }
        let collection = TimePeriodCollection()
        collection.periods = array
        collection._beginning = self.beginning
        collection._end = self.end
        return collection
    }
    
    func sorted(by areInIncreasingOrder: (TimePeriodProtocol, TimePeriodProtocol) -> Bool) -> TimePeriodCollection {
        let array = self.periods.sorted { $0.beginning! < $1.beginning! }
        let collection = TimePeriodCollection()
        collection.periods = array
        collection._beginning = self.beginning
        collection._end = self.end
        return collection
    }
    
    
    // MARK: - Collection Relationship
    
    // Potentially use .reduce() instead of these functions
    /**
        Returns from the ```TimePeriodCollection``` a sub-collection of ```TimePeriod```s whose start and end dates fall completely inside the interval of the given ```TimePeriod```
     */
    func allInside(in period: TimePeriodProtocol) -> TimePeriodCollection {
        let collection = TimePeriodCollection()
        //Filter by periop
        collection.periods = self.periods.filter({ (timePeriod: TimePeriodProtocol) -> Bool in
            return timePeriod.inside(of: period)
        })
        return collection
    }
    
    /**
        Returns from the ```TimePeriodCollection``` a sub-collection of ```TimePeriod```s containing the given date
     */
    func periodsIntersected(by date: Date) -> TimePeriodCollection {
        let collection = TimePeriodCollection()
        //Filter by periop
        collection.periods = self.periods.filter({ (timePeriod: TimePeriodProtocol) -> Bool in
            return timePeriod.contains(date: date, interval: .closed)
        })
        return collection
    }
    
    /**
     Returns from the ```TimePeriodCollection``` a sub-collection of ```TimePeriod```s containing either the start date or the end date--or both--of the given ```TimePeriod```
     */
    func periodsIntersected(by period: TimePeriodProtocol) -> TimePeriodCollection {
        let collection = TimePeriodCollection()
        //Filter by periop
        collection.periods = self.periods.filter({ (timePeriod: TimePeriodProtocol) -> Bool in
            return timePeriod.intersects(with: period)
        })
        return collection
    }
    
    // MARK: - Map, Filter, Reduce
    
    func map(_ transform: (TimePeriodProtocol) throws -> TimePeriodProtocol) rethrows -> TimePeriodCollection {
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
    
    static func ==(left: TimePeriodCollection, right: TimePeriodCollection) -> Bool {
        return left.equals(group: right)
    }
    
    //MARK: - Helpers
    
    internal func updateExtremes(period: TimePeriodProtocol) {
        //Check incoming period against previous beginning and end date
        _beginning = nilOrEarlier(date1: _beginning, date2: period.beginning)
        _end = nilOrLater(date1: _end, date2: period.end)
    }
    
    internal func updateExtremes() {
        if periods.count == 0 {
            _beginning = nil
            _end = nil
        }
        else {
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
        }
        else {
            return date1!.earlierDate(date2!)
        }
    }
    
    internal func nilOrLater(date1: Date?, date2: Date?) -> Date? {
        if date1 == nil || date2 == nil {
            return nil
        }
        else {
            return date1!.laterDate(date2!)
        }
    }
}
