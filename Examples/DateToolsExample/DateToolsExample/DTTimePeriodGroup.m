//
//  DTTimePeriodGroup.m
//  DateToolsExample
//
//  Created by Matthew York on 3/21/14.
//
//

#import "DTTimePeriodGroup.h"

@interface DTTimePeriodGroup ()

@end

@implementation DTTimePeriodGroup

-(id) init
{
    if (self = [self init]) {
        periods = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (id)objectAtIndexedSubscript:(NSUInteger)index
{
    return periods[index];
}

- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)index {
    periods[index] = obj;
}

@end
