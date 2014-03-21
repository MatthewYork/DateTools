//
//  DTTimePeriodCollection.h
//  DateToolsExample
//
//  Created by Matthew York on 3/21/14.
//
//

#import <Foundation/Foundation.h>
#import "DTTimePeriodGroup.h"

@interface DTTimePeriodCollection : DTTimePeriodGroup

#pragma mark - Collection Manipulation
-(void)addTimePeriod:(DTTimePeriod *)period;
-(void)insertTimePeriod:(DTTimePeriod *)period atInedx:(NSInteger)index;
-(void)removeTimePeriodAtIndex:(NSInteger)index;
-(void)removeLatestTimePeriod;
-(void)removeEarliestTimePeriod;

#pragma mark - Sorting
-(void)sortByStart;
-(void)sortByEnd;
-(void)sortByDuration;
@end
