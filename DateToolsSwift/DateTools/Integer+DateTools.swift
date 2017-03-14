//
//  Integer+DateTools.swift
//  DateTools
//
//  Created by Grayson Webster on 8/17/16.
//  Copyright © 2016 Grayson Webster. All rights reserved.
//

import Foundation

public extension Int {
    
    //MARK: TimePeriod
    
    /**
     *  A `TimeChunk` with its seconds component set to the value of self
     */
    public var seconds: TimeChunk {
        return TimeChunk(seconds: self, minutes: 0, hours: 0, days: 0, weeks: 0, months: 0, years: 0)
    }
    
    /**
     *  A `TimeChunk` with its minutes component set to the value of self
     */
    public var minutes: TimeChunk {
        return TimeChunk(seconds: 0, minutes: self, hours: 0, days: 0, weeks: 0, months: 0, years: 0)
    }
    
    /**
     *  A `TimeChunk` with its hours component set to the value of self
     */
    public var hours: TimeChunk {
        return TimeChunk(seconds: 0, minutes: 0, hours: self, days: 0, weeks: 0, months: 0, years: 0)
    }
    
    /**
     *  A `TimeChunk` with its days component set to the value of self
     */
    public var days: TimeChunk {
        return TimeChunk(seconds: 0, minutes: 0, hours: 0, days: self, weeks: 0, months: 0, years: 0)
    }
    
    /**
     *  A `TimeChunk` with its weeks component set to the value of self
     */
    public var weeks: TimeChunk {
        return TimeChunk(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: self, months: 0, years: 0)
    }
    
    /**
     *  A `TimeChunk` with its months component set to the value of self
     */
    public var months: TimeChunk {
        return TimeChunk(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: self, years: 0)
    }
    
    /**
     *  A `TimeChunk` with its years component set to the value of self
     */
    public var years: TimeChunk {
        return TimeChunk(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: 0, years: self)
    }
}
