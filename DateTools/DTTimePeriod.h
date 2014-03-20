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

@interface DTTimePeriod : NSObject

@property NSDate *StartDate;
@property NSDate *EndDate;

#pragma mark - Custom Inits
-(instancetype)initWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;

#pragma mark - Time Period Information
-(BOOL)hasStartDate;
-(BOOL)hasEndDate;
-(NSInteger)durationInYears;
-(NSInteger)durationInWeeks;
-(NSInteger)durationInDays;
-(NSInteger)durationInHours;
-(NSInteger)durationInSeconds;

#pragma mark - Time Period Relationship
-(BOOL)isSamePeriod:(DTTimePeriod *)period;
-(BOOL)isInside:(DTTimePeriod *)period;
-(BOOL)contains:(DTTimePeriod *)period;
-(BOOL)overlapsWith:(DTTimePeriod *)period;
-(BOOL)intersects:(DTTimePeriod *)period;
-(DTTimePeriodRelation)relationToPeriod:(DTTimePeriod *)period;
@end
