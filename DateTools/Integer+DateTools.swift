//
//  Integer+DateTools.swift
//  DateTools
//
//  Created by Grayson Webster on 8/17/16.
//  Copyright © 2016 Grayson Webster. All rights reserved.
//

import Foundation

extension Int {
    
    //MARK: TimePeriod
    var seconds: TimeChunk {
        return TimeChunk(size: .second, amount: self)
    }
    
    var minutes: TimeChunk {
        return TimeChunk(size: .minute, amount: self)
    }
    
    var hours: TimeChunk {
        return TimeChunk(size: .hour, amount: self)
    }
    
    var days: TimeChunk {
        return TimeChunk(size: .day, amount: self)
    }
    
    var weeks: TimeChunk {
        return TimeChunk(size: .week, amount: self)
    }
    
    var months: TimeChunk {
        return TimeChunk(size: .month, amount: self)
    }
    
    var years: TimeChunk {
        return TimeChunk(size: .year, amount: self)
    }
}
