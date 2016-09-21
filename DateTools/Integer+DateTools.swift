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
    var seconds: TimeChunk {
        return TimeChunk(seconds: self, minutes: 0, hours: 0, days: 0, weeks: 0, months: 0, years: 0)
    }
    
    var minutes: TimeChunk {
        return TimeChunk(seconds: 0, minutes: self, hours: 0, days: 0, weeks: 0, months: 0, years: 0)
    }
    
    var hours: TimeChunk {
        return TimeChunk(seconds: 0, minutes: 0, hours: self, days: 0, weeks: 0, months: 0, years: 0)
    }
    
    var days: TimeChunk {
        return TimeChunk(seconds: 0, minutes: 0, hours: 0, days: self, weeks: 0, months: 0, years: 0)
    }
    
    var weeks: TimeChunk {
        return TimeChunk(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: self, months: 0, years: 0)
    }
    
    var months: TimeChunk {
        return TimeChunk(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: self, years: 0)
    }
    
    var years: TimeChunk {
        return TimeChunk(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: 0, years: self)
    }
}
