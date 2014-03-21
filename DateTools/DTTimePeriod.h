//
//  DTTimePeriod.h
//  DateToolsExample
//
//  Created by Matthew York on 3/19/14.
//
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger, DTTimePeriodRelation){
    DTTimePeriodRelationAfter,
    DTTimePeriodRelationStartTouching,
    DTTimePeriodRelationStartInside,
    DTTimePeriodRelationInsideStartTouching,
    DTTimePeriodRelationEnclosingStartTouching,
    DTTimePeriodRelationEnclosing,
    DTTimePeriodRelationEnclosingEndTouching,
    DTTimePeriodRelationExactMatch,
    DTTimePeriodRelationInside,
    DTTimePeriodRelationInsideEndTouching,
    DTTimePeriodRelationEndInside,
    DTTimePeriodRelationEndTouching,
    DTTimePeriodRelationBefore,
    DTTimePeriodRelationNone //One or more of the dates does not exist
};

typedef NS_ENUM(NSUInteger, DTTimePeriodSize) {
    DTTimePeriodSizeSecond,
    DTTimePeriodSizeMinute,
    DTTimePeriodSizeHour,
    DTTimePeriodSizeDay,
    DTTimePeriodSizeWeek,
    DTTimePeriodSizeMonth,
    DTTimePeriodSizeYear
};

typedef NS_ENUM(NSUInteger, DTTimePeriodInterval) {
    DTTimePeriodIntervalOpen,
    DTTimePeriodIntervalClosed
};

typedef NS_ENUM(NSUInteger, DTTimePeriodAnchor) {
    DTTimePeriodAnchorStart,
    DTTimePeriodAnchorCenter,
    DTTimePeriodAnchorEnd
};

@interface DTTimePeriod : NSObject

/**
 *  The start date for a DTTimePeriod representing the starting boundary of the time period
 */
@property NSDate *StartDate;

/**
 *  The end date for a DTTimePeriod representing the ending boundary of the time period
 */
@property NSDate *EndDate;

#pragma mark - Custom Init / Factory Methods
-(instancetype)initWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;
+(instancetype)timePeriodWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;
+(instancetype)timePeriodWithSize:(DTTimePeriodSize)size startingAt:(NSDate *)date;
+(instancetype)timePeriodWithSize:(DTTimePeriodSize)size amount:(NSInteger)amount startingAt:(NSDate *)date;
+(instancetype)timePeriodWithSize:(DTTimePeriodSize)size endingAt:(NSDate *)date;
+(instancetype)timePeriodWithSize:(DTTimePeriodSize)size amount:(NSInteger)amount endingAt:(NSDate *)date;
+(instancetype)timePeriodWithAllTime;

#pragma mark - Time Period Information
-(BOOL)hasStartDate;
-(BOOL)hasEndDate;
-(BOOL)isMoment;
-(NSInteger)durationInYears;
-(NSInteger)durationInWeeks;
-(NSInteger)durationInDays;
-(NSInteger)durationInHours;
-(NSInteger)durationInMinutes;
-(NSInteger)durationInSeconds;

#pragma mark - Time Period Relationship
-(BOOL)isSamePeriod:(DTTimePeriod *)period;
-(BOOL)isInside:(DTTimePeriod *)period;
-(BOOL)contains:(DTTimePeriod *)period;
-(BOOL)overlapsWith:(DTTimePeriod *)period;
-(BOOL)intersects:(DTTimePeriod *)period;
-(DTTimePeriodRelation)relationToPeriod:(DTTimePeriod *)period;
-(NSTimeInterval)gapBetween:(DTTimePeriod *)period;

#pragma mark - Date Relationships
-(BOOL)containsDate:(NSDate *)date interval:(DTTimePeriodInterval)interval;

#pragma mark - Period Manipulation
#pragma mark Shifts
-(void)shiftEarlierWithSize:(DTTimePeriodSize)size;
-(void)shiftEarlierWithSize:(DTTimePeriodSize)size amount:(NSInteger)amount;
-(void)shiftLaterWithSize:(DTTimePeriodSize)size;
-(void)shiftLaterWithSize:(DTTimePeriodSize)size amount:(NSInteger)amount;

#pragma mark Lengthen / Shorten
-(void)lengthenWithAnchorDate:(DTTimePeriodAnchor)anchor size:(DTTimePeriodSize)size;
-(void)lengthenWithAnchorDate:(DTTimePeriodAnchor)anchor size:(DTTimePeriodSize)size amount:(NSInteger)amount;
-(void)shortenWithAnchorDate:(DTTimePeriodAnchor)anchor size:(DTTimePeriodSize)size;
-(void)shortenWithAnchorDate:(DTTimePeriodAnchor)anchor size:(DTTimePeriodSize)size amount:(NSInteger)amount;
@end
