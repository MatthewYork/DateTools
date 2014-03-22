//
//  DTTimePeriodChain.h
//  DateToolsExample
//
//  Created by Matthew York on 3/21/14.
//
//

#import <Foundation/Foundation.h>
#import "DTTimePeriodGroup.h"

@interface DTTimePeriodChain : DTTimePeriodGroup {
    DTTimePeriod *First;
    DTTimePeriod *Last;
}

@property (nonatomic, readonly) DTTimePeriod *First;
@property (nonatomic, readonly) DTTimePeriod *Last;

#pragma mark - Custom Init / Factory Chain
+(DTTimePeriodChain *)chain;

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

#pragma mark - Chain Relationship
-(BOOL)isEqualToChain:(DTTimePeriodChain *)chain;
@end
