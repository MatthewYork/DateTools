//
//  DTTimePeriodChain.h
//  DateToolsExample
//
//  Created by Matthew York on 3/21/14.
//
//

#import <Foundation/Foundation.h>
#import "DTTimePeriodGroup.h"

@interface DTTimePeriodChain : DTTimePeriodGroup

@property DTTimePeriod *First;
@property DTTimePeriod *Last;

#pragma mark - Chain Existence Manipulation
-(void)addTimePeriod:(DTTimePeriod *)period;
-(void)insertTimePeriod:(DTTimePeriod *)period atInedx:(NSInteger)index;
-(void)removeTimePeriodAtIndex:(NSInteger)index;
-(void)removeLatestTimePeriod;
-(void)removeEarliestTimePeriod;

#pragma mark - Chain Time Manipulation
-(void)shiftEarlierWithSize:(DTTimePeriodSize)size;
-(void)shiftEarlierWithSize:(DTTimePeriodSize)size amount:(NSInteger)amount;
-(void)shiftLaterWithSize:(DTTimePeriodSize)size;
-(void)shiftLaterWithSize:(DTTimePeriodSize)size amount:(NSInteger)amount;
@end
