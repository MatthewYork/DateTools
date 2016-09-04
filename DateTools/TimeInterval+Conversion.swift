//
//  TimeInterval+Conversion.swift
//  DateToolsTests
//
//  Created by Grayson Webster on 8/26/16.
//  Copyright © 2016 Matthew York. All rights reserved.
//

import Foundation

public extension TimeInterval {
    
    var seconds: Double {
        return self
    }
    
    var minutes: Double {
        return self / Constants.SecondsInMinute
    }
    
    var hours: Double {
        return self / Constants.SecondsInHour
    }
    
    var days: Double {
        return self / Constants.SecondsInDay
    }
    
    var weeks: Double {
        return self / Constants.SecondsInWeek
    }
}
