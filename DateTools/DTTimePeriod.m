//
//  DTTimePeriod.m
//  DateToolsExample
//
//  Created by Matthew York on 3/19/14.
//
//

#import "DTTimePeriod.h"
#import "NSDate+DateTools.h"

@interface DTTimePeriod ()
@property (readwrite, assign) BOOL hasStart;
@end


@implementation DTTimePeriod

#pragma mark - Custom Init / Factory Methods
-(instancetype)initWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate{
    if (self = [super init]) {
        self.StartDate = startDate;
        self.EndDate = endDate;
    }
    
    return self;
}

+(instancetype)timePeriodWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate{
    return [[DTTimePeriod alloc] initWithStartDate:startDate endDate:endDate];
}

+(instancetype)timePeriodWithSize:(DTTimePeriodSize)size startingAt:(NSDate *)date{
    return [[DTTimePeriod alloc] initWithStartDate:date endDate:[DTTimePeriod dateWithAddedTime:size amount:1 baseDate:date]];
}

+(instancetype)timePeriodWithSize:(DTTimePeriodSize)size amount:(NSInteger)amount startingAt:(NSDate *)date{
    return [[DTTimePeriod alloc] initWithStartDate:date endDate:[DTTimePeriod dateWithAddedTime:size amount:amount baseDate:date]];
}

+(instancetype)timePeriodWithSize:(DTTimePeriodSize)size endingAt:(NSDate *)date{
    return [[DTTimePeriod alloc] initWithStartDate:[DTTimePeriod dateWithSubtractedTime:size amount:1 baseDate:date] endDate:date];
}

+(instancetype)timePeriodWithSize:(DTTimePeriodSize)size amount:(NSInteger)amount endingAt:(NSDate *)date{
    return [[DTTimePeriod alloc] initWithStartDate:[DTTimePeriod dateWithSubtractedTime:size amount:amount baseDate:date] endDate:date];
}

+(instancetype)timePeriodWithAllTime{
    return [[DTTimePeriod alloc] initWithStartDate:[NSDate distantPast] endDate:[NSDate distantFuture]];
}

+(NSDate *)dateWithAddedTime:(DTTimePeriodSize)size amount:(NSInteger)amount baseDate:(NSDate *)date{
    switch (size) {
        case DTTimePeriodSizeSecond:
            return [date dateByAddingSeconds:amount];
            break;
        case DTTimePeriodSizeMinute:
            return [date dateByAddingMinutes:amount];
            break;
        case DTTimePeriodSizeHour:
            return [date dateByAddingHours:amount];
            break;
        case DTTimePeriodSizeDay:
            return [date dateByAddingDays:amount];
            break;
        case DTTimePeriodSizeWeek:
            return [date dateByAddingWeeks:amount];
            break;
        case DTTimePeriodSizeMonth:
            return [date dateByAddingMonths:amount];
            break;
        case DTTimePeriodSizeYear:
            return [date dateByAddingYears:amount];
            break;
        default:
            break;
    }
    
    return date;
}

+(NSDate *)dateWithSubtractedTime:(DTTimePeriodSize)size amount:(NSInteger)amount baseDate:(NSDate *)date{
    switch (size) {
        case DTTimePeriodSizeSecond:
            return [date dateBySubtractingSeconds:amount];
            break;
        case DTTimePeriodSizeMinute:
            return [date dateBySubtractingMinutes:amount];
            break;
        case DTTimePeriodSizeHour:
            return [date dateBySubtractingHours:amount];
            break;
        case DTTimePeriodSizeDay:
            return [date dateBySubtractingDays:amount];
            break;
        case DTTimePeriodSizeWeek:
            return [date dateBySubtractingWeeks:amount];
            break;
        case DTTimePeriodSizeMonth:
            return [date dateBySubtractingMonths:amount];
            break;
        case DTTimePeriodSizeYear:
            return [date dateBySubtractingYears:amount];
            break;
        default:
            break;
    }
    
    return date;
}

#pragma mark - Time Period Information
-(BOOL)hasStartDate {
    return (self.StartDate)? YES:NO;
}

-(BOOL)hasEndDate {
    return (self.EndDate)? YES:NO;
}

-(NSInteger)durationInYears {
    if (self.StartDate && self.EndDate) {
        return [self.StartDate yearsEarlierThan:self.EndDate];
    }
    
    return 0;
}

-(NSInteger)durationInWeeks {
    if (self.StartDate && self.EndDate) {
        return [self.StartDate weeksEarlierThan:self.EndDate];
    }
    
    return 0;
}

-(NSInteger)durationInDays {
    if (self.StartDate && self.EndDate) {
        return [self.StartDate daysEarlierThan:self.EndDate];
    }
    
    return 0;
}

-(NSInteger)durationInHours {
    if (self.StartDate && self.EndDate) {
        return [self.StartDate hoursEarlierThan:self.EndDate];
    }
    
    return 0;
}

-(NSInteger)durationInSeconds {
    if (self.StartDate && self.EndDate) {
        return [self.StartDate secondsEarlierThan:self.EndDate];
    }
    
    return 0;
}

#pragma mark - Time Period Relationship

-(BOOL)isSamePeriod:(DTTimePeriod *)period{
    if ([self.StartDate isEqualToDate:period.StartDate] && [self.EndDate isEqualToDate:period.EndDate]) {
        return YES;
    }
    return NO;
}

-(BOOL)isInside:(DTTimePeriod *)period{
    if ([period.StartDate timeIntervalSinceDate:self.StartDate] >= 0 && [self.EndDate timeIntervalSinceDate:period.EndDate] <= 0) {
        return YES;
    }
    return NO;
}

-(BOOL)contains:(DTTimePeriod *)period{
    if ([self.StartDate timeIntervalSinceDate:period.StartDate] >= 0 && [period.EndDate timeIntervalSinceDate:self.EndDate] <= 0) {
        return YES;
    }
    return NO;
}

-(BOOL)overlapsWith:(DTTimePeriod *)period{
    //Outside -> Inside
    if ([self.StartDate timeIntervalSinceDate:period.EndDate] < 0 && period.durationInSeconds > 0) {
        return YES;
    }
    //Enclosing (hugs left)
    else if ([period.StartDate timeIntervalSinceDate:self.StartDate] >= 0 && period.durationInSeconds > 0){
        return YES;
    }
    //Enclosing (hugs right)
    else if([period.EndDate timeIntervalSinceDate:self.EndDate] <= 0 && period.durationInSeconds > 0){
        return YES;
    }
    //Inside -> Out
    else if([period.StartDate timeIntervalSinceDate:self.EndDate] < 0 && period.durationInSeconds > 0){
        return YES;
    }
    return NO;
}

-(BOOL)intersects:(DTTimePeriod *)period{
    //Outside -> Inside
    if ([self.StartDate timeIntervalSinceDate:period.EndDate] <= 0 && period.durationInSeconds > 0) {
        return YES;
    }
    //Enclosing (hugs left)
    else if ([period.StartDate timeIntervalSinceDate:self.StartDate] >= 0 && period.durationInSeconds > 0){
        return YES;
    }
    //Enclosing (hugs right)
    else if([period.EndDate timeIntervalSinceDate:self.EndDate] <= 0 && period.durationInSeconds > 0){
        return YES;
    }
    //Inside -> Out
    else if([period.StartDate timeIntervalSinceDate:self.EndDate] <= 0 && period.durationInSeconds > 0){
        return YES;
    }
    return NO;
}

-(DTTimePeriodRelation)relationToPeriod:(DTTimePeriod *)period{
    
    //Make sure that all start and end points exist for comparison
    if (self.StartDate && self.EndDate && period.StartDate && period.EndDate) {
        //Make sure time periods are of positive durations
        if ([self.StartDate isEarlierThan:self.EndDate] && [period.StartDate isEarlierThan:period.EndDate]) {
            
            //Make comparisons
            if ([period.EndDate isEarlierThan:self.StartDate]) {
                return DTTimePeriodRelationAfter;
            }
            else if ([period.EndDate isEqualToDate:self.StartDate]){
                return DTTimePeriodRelationStartTouching;
            }
            else if ([period.StartDate isEarlierThan:self.StartDate] && [period.EndDate isEarlierThan:self.EndDate]){
                return DTTimePeriodRelationStartInside;
            }
            else if ([period.StartDate isEqualToDate:self.StartDate] && [period.EndDate isLaterThan:self.EndDate]){
                return DTTimePeriodRelationInsideStartTouching;
            }
            else if ([period.StartDate isEqualToDate:self.StartDate] && [period.EndDate isEarlierThan:self.EndDate]){
                return DTTimePeriodRelationEnclosingStartTouching;
            }
            else if ([period.StartDate isLaterThan:self.StartDate] && [period.EndDate isEarlierThan:self.EndDate]){
                return DTTimePeriodRelationEnclosing;
            }
            else if ([period.StartDate isLaterThan:self.StartDate] && [period.EndDate isEqualToDate:self.EndDate]){
                return DTTimePeriodRelationEnclosingEndTouching;
            }
            else if ([period.StartDate isEqualToDate:self.StartDate] && [period.EndDate isEqualToDate:self.EndDate]){
                return DTTimePeriodRelationExactMatch;
            }
            else if ([period.StartDate isEarlierThan:self.StartDate] && [period.EndDate isLaterThan:self.EndDate]){
                return DTTimePeriodRelationInside;
            }
            else if ([period.StartDate isEarlierThan:self.StartDate] && [period.EndDate isEqualToDate:self.EndDate]){
                return DTTimePeriodRelationInsideEndTouching;
            }
            else if ([period.StartDate isEarlierThan:self.EndDate] && [period.EndDate isLaterThan:self.EndDate]){
                return DTTimePeriodRelationEndInside;
            }
            else if ([period.StartDate isEqualToDate:self.EndDate] && [period.EndDate isLaterThan:self.EndDate]){
                return DTTimePeriodRelationEndTouching;
            }
            else if ([period.StartDate isLaterThan:self.EndDate]){
                return DTTimePeriodRelationBefore;
            }
        }
    }
    
    return DTTimePeriodRelationNone;
}

@end
