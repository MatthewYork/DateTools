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
class TimePeriodGroup {
    
    // MARK: - Variables
    
    var beginning: Date?
    var end: Date?
    
    private var periods: [TimePeriod] = []
    
    var duration: TimeInterval {
        if beginning != nil && end != nil {
            return beginning!.timeBetween(date: end!)
        }
        return 0
    }
    
    // MARK: - Mutations
    
    func add(_ period: TimePeriod) {
        periods.append(period)
        if beginning != nil && period.beginning != nil {
            beginning = min(beginning!, period.beginning!)
            end = max(end!, period.end!)
        } else {
            if let uBeginning = period.beginning {
                self.beginning = uBeginning
            }
        }
    }
    
}
