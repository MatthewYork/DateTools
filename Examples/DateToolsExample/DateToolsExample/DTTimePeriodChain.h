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

#pragma mark - Chain Relationship
-(BOOL)isEqualToChain:(DTTimePeriodChain *)chain;

#pragma mark - Updates
-(void)updateVariables;
@end
