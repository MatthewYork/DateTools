//
//  DTTimePeriodGroup.h
//  DateToolsExample
//
//  Created by Matthew York on 3/21/14.
//
//

#import <Foundation/Foundation.h>
#import "DTTimePeriod.h"

@interface DTTimePeriodGroup : NSObject {
@protected
    NSMutableArray *periods;
    NSDate *StartDate;
    NSDate *EndDate;
}

@property (nonatomic, readonly) NSDate *StartDate;
@property (nonatomic, readonly) NSDate *EndDate;

//Here we will use object subscripting to help create the illusion of an array
- (id)objectAtIndexedSubscript:(NSUInteger)index; //getter
- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)index; //setter

#pragma mark - Group Info
-(double)durationInYears;
-(double)durationInWeeks;
-(double)durationInDays;
-(double)durationInHours;
-(double)durationInMinutes;
-(double)durationInSeconds;
-(NSDate *)StartDate;
-(NSDate *)EndDate;
-(NSInteger)count;

#pragma mark - Chain Time Manipulation
-(void)shiftEarlierWithSize:(DTTimePeriodSize)size;
-(void)shiftEarlierWithSize:(DTTimePeriodSize)size amount:(NSInteger)amount;
-(void)shiftLaterWithSize:(DTTimePeriodSize)size;
-(void)shiftLaterWithSize:(DTTimePeriodSize)size amount:(NSInteger)amount;

#pragma mark - Comparison
-(BOOL)hasSameCharacteristicsAs:(DTTimePeriodGroup *)group;

#pragma mark - Updates
-(void)updateVariables;
@end
