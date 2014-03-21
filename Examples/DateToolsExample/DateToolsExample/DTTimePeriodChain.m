//
//  DTTimePeriodChain.m
//  DateToolsExample
//
//  Created by Matthew York on 3/21/14.
//
//

#import "DTTimePeriodChain.h"

@implementation DTTimePeriodChain

-(void)shiftEarlierWithSize:(DTTimePeriodSize)size{
    [self shiftEarlierWithSize:size amount:1];
}
-(void)shiftEarlierWithSize:(DTTimePeriodSize)size amount:(NSInteger)amount{
    if (periods) {
        [periods enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [((DTTimePeriod *)obj) shiftEarlierWithSize:size amount:amount];
        }];
    }
}
-(void)shiftLaterWithSize:(DTTimePeriodSize)size{
    [self shiftLaterWithSize:size amount:1];
}
-(void)shiftLaterWithSize:(DTTimePeriodSize)size amount:(NSInteger)amount{
    if (periods) {
        [periods enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [((DTTimePeriod *)obj) shiftLaterWithSize:size amount:amount];
        }];
    }
}
@end
