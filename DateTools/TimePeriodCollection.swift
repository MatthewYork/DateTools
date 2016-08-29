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
class TimePeriodCollection: TimePeriodGroup {
    
    // MARK: - Collection Manipulation
    
    // Manipulation will be implemented by overriding CollectionType methods
    
    func remove(at: Int) {
        periods.remove(at: at)
    }
    
    func removeAll() {
        periods.removeAll()
    }
    
    func insert(_ newElement: TimePeriodProtocol, at i: Int) {
        periods.insert(newElement, at: i)
        updateExtremes(period: newElement)
        
    }
    
    // MARK: - Sorting
    
    func sort(by areInIncreasingOrder: (TimePeriodProtocol, TimePeriodProtocol) -> Bool) {
        
    }
    
    func sorted(by areInIncreasingOrder: (TimePeriodProtocol, TimePeriodProtocol) -> Bool) -> TimePeriodCollection {
        return TimePeriodCollection()
    }
    
    
    // MARK: - Collection Relationship
    
    // Potentially use .reduce() instead of these functions
    /**
        Returns from the ```TimePeriodCollection``` a sub-collection of ```TimePeriod```s whose start and end dates fall completely inside the interval of the given ```TimePeriod```
     */
    func allInside(in period: TimePeriodProtocol) -> TimePeriodCollection {
        return TimePeriodCollection()
    }
    
    /**
        Returns from the ```TimePeriodCollection``` a sub-collection of ```TimePeriod```s containing the given date
     */
    func periodsIntersected(by date: Date) -> TimePeriodCollection {
        return TimePeriodCollection()
    }
    
    /**
     Returns from the ```TimePeriodCollection``` a sub-collection of ```TimePeriod```s containing either the start date or the end date--or both--of the given ```TimePeriod```
     */
    func periodsIntersected(by period: TimePeriodProtocol) -> TimePeriodCollection {
        return TimePeriodCollection()
    }
    
    func equals(collection: TimePeriodCollection) -> Bool {
        return false
    }
    
    
    // MARK: - Helper Methods
    
    func copy() -> TimePeriodCollection {
        return TimePeriodCollection()
    }
    
    
    // MARK: - Updates
    
    func updateVariables() {
        
    }
    
    
    // MARK: - Operator Overloads
    
    static func +(leftAddend: TimePeriodCollection, rightAddend: TimePeriodCollection) -> TimePeriodCollection {
        return TimePeriodCollection()
    }
    static func -(minuend: TimePeriodCollection, subtrahend: TimePeriodCollection) -> TimePeriodCollection {
        return TimePeriodCollection()
    }
    static func ==(left: TimePeriodCollection, right: TimePeriodCollection) -> Bool {
        return left.equals(collection: right)
    }
    
}
