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


-(void)shiftEarlierWithSize:(DTTimePeriodSize)size;
-(void)shiftEarlierWithSize:(DTTimePeriodSize)size amount:(NSInteger)amount;
-(void)shiftLaterWithSize:(DTTimePeriodSize)size;
-(void)shiftLaterWithSize:(DTTimePeriodSize)size amount:(NSInteger)amount;
@end
