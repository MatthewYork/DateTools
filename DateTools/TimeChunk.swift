//
//  TimeBlock.swift
//  DateTools
//
//  Created by Grayson Webster on 8/19/16.
//  Copyright © 2016 Grayson Webster. All rights reserved.
//

import Foundation

struct TimeChunk {
    var size: TimePeriod.Size = .second
    var amount = 0
    
    init(size: TimePeriod.Size, amount: Int) {
        self.size = size
        self.amount = amount
    }
}
