//
//  Date+Comparators.swift
//  DateToolsTests
//
//  Created by Matthew York on 8/26/16.
//  Copyright © 2016 Matthew York. All rights reserved.
//

import Foundation

extension Date {
	
	// MARK: - Addition / Subtractions
	
	func add(_ timeChunk: TimeChunk) -> Date {
		return Date()
	}
	
	func subtract(_ timeChunk: TimeChunk) -> Date {
		return Date()
	}
    
    func add(_ timeInterval: TimeInterval) -> Date {
        return Date()
    }
    
    func subtract(_ timeInterval: TimeInterval) -> Date {
        return Date()
    }
	
	// MARK: - Time Between
	
	func timeBetween(date: Date) -> TimeInterval {
		return TimeInterval()
	}
    
    func chunkBetween(date: Date) -> TimeChunk {
        return TimeChunk()
    }
	
	
	// MARK: - Comparisons
	
	func equals(_ date: Date) -> Bool {
		return self.compare(date) == .orderedSame
	}
	
	func greater(than date: Date) -> Bool {
		return self.compare(date) == .orderedDescending
	}
	
	func less(than date: Date) -> Bool {
		return self.compare(date) == .orderedAscending
	}
	
    
	// MARK: - Operator Overloads
	
	static func +(leftAddend: Date, rightAddend: TimeChunk) -> Date {
		return leftAddend.add(rightAddend)
	}
	
	static func -(minuend: Date, subtrahend: TimeChunk) -> Date {
		return minuend.subtract(subtrahend)
	}
    
    static func +(leftAddend: Date, rightAddend: Int) -> Date {
        return leftAddend.add(TimeInterval(rightAddend))
    }
    
    static func -(minuend: Date, subtrahend: Int) -> Date {
        return minuend.subtract(TimeInterval(subtrahend))
    }
}
