//
//  DTTimePeriod.m
//  DateToolsExample
//
//  Created by Matthew York on 3/19/14.
//
//

#import "DTTimePeriod.h"



@implementation DTTimePeriod

#pragma mark - Time Period Relationship

-(BOOL)isSamePeriod:(DTTimePeriod *)period{
    return NO;
}

-(BOOL)isInside:(DTTimePeriod *)period{
    return NO;
}

-(BOOL)overlapsWith:(DTTimePeriod *)period{
    return NO;
}

-(BOOL)intersects:(DTTimePeriod *)period{
    return NO;
}

@end
