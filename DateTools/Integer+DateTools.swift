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
    func seconds() -> TimeChunk {
		return TimeChunk(size: .second, amount: self)
    }
    
    func minutes() -> TimeChunk {
        return TimeChunk(size: .minute, amount: self)
    }
    
    func days() -> TimeChunk {
        return TimeChunk(size: .day, amount: self)
    }
    
    func years() -> TimeChunk {
        return TimeChunk(size: .year, amount: self)
    }
}
