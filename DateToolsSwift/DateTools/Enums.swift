//
//  Enums.swift
//  DateToolsTests
//
//  Created by Matthew York on 8/26/16.
//  Copyright © 2016 Matthew York. All rights reserved.
//

// MARK: - Enums

/**
 *  There may come a need, say when you are making a scheduling app, when 
 *  it might be good to know how two time periods relate to one another. 
 *  Are they the same? Is one inside of another? All these questions may be 
 *  asked using the relationship methods of DTTimePeriod.
 *
 *  Further reading: [GitHub](https://github.com/MatthewYork/DateTools#relationships), 
 *  [CodeProject](http://www.codeproject.com/Articles/168662/Time-Period-Library-for-NET)
 */
public enum Relation {
    case after
    case startTouching
    case startInside
    case insideStartTouching
    case enclosingStartTouching
    case enclosing
    case enclosingEndTouching
    case exactMatch
    case inside
    case insideEndTouching
    case endInside
    case endTouching
    case before
    case none // One or more of the dates does not exist
}


/**
 *  Whether the time period is Open or Closed
 *
 *  Closed: The boundary moment of time is included in calculations.
 *
 *  Open: The boundary moment of time represents a boundary value which is excluded in regard to calculations.
 */
public enum Interval {
    case open
    case closed
}

/**
 *  When a time periods is lengthened or shortened, it does so anchoring one date
 *  of the time period and then changing the other one. There is also an option to 
 *  anchor the centerpoint of the time period, changing both the start and end dates.
 */
public enum Anchor {
    case beginning
    case center
    case end
}

/**
 *  When a time periods is lengthened or shortened, it does so anchoring one date 
 *  of the time period and then changing the other one. There is also an option to 
 *  anchor the centerpoint of the time period, changing both the start and end dates.
 */
public enum Component {
    case year
    case month
    case day
    case hour
    case minute
    case second
}

/**
 *  Time units that include weeks, but not months since their exact size is dependent
 *  on the date. Used for TimeChunk conversions.
 */
public enum TimeUnits {
    case years
    case weeks
    case days
    case hours
    case minutes
    case seconds
}
