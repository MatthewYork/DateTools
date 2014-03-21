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

-(BOOL)isMoment{
    if (self.StartDate && self.EndDate) {
        if ([self.StartDate isEqualToDate:self.EndDate]) {
            return YES;
        }
    }
    
    return NO;
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

-(NSInteger)durationInMinutes {
    if (self.StartDate && self.EndDate) {
        return [self.StartDate minutesEarlierThan:self.EndDate];
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
    if ([period.StartDate isEarlierThanOrEqualToDate:self.StartDate] && [period.EndDate isLaterThanOrEqualToDate:self.EndDate]) {
        return YES;
    }
    return NO;
}

-(BOOL)contains:(DTTimePeriod *)period{
    if ([self.StartDate isEarlierThanOrEqualToDate:period.StartDate] && [self.EndDate isLaterThanOrEqualToDate:period.EndDate]) {
        return YES;
    }
    return NO;
}

-(BOOL)overlapsWith:(DTTimePeriod *)period{
    //Outside -> Inside
    if ([period.StartDate isEarlierThan:self.StartDate] && [period.EndDate isLaterThan:self.StartDate]) {
        return YES;
    }
    //Enclosing
    else if ([period.StartDate isLaterThanOrEqualToDate:self.StartDate] && [period.EndDate isEarlierThanOrEqualToDate:self.EndDate]){
        return YES;
    }
    //Inside -> Out
    else if([period.StartDate isEarlierThan:self.EndDate] && [period.EndDate isLaterThan:self.EndDate]){
        return YES;
    }
    return NO;
}

-(BOOL)intersects:(DTTimePeriod *)period{
    //Outside -> Inside
    if ([period.StartDate isEarlierThan:self.StartDate] && [period.EndDate isLaterThanOrEqualToDate:self.StartDate]) {
        return YES;
    }
    //Enclosing
    else if ([period.StartDate isLaterThanOrEqualToDate:self.StartDate] && [period.EndDate isEarlierThanOrEqualToDate:self.EndDate]){
        return YES;
    }
    //Inside -> Out
    else if([period.StartDate isEarlierThanOrEqualToDate:self.EndDate] && [period.EndDate isLaterThan:self.EndDate]){
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

#pragma mark - Date Relationships
-(BOOL)containsDate:(NSDate *)date interval:(DTTimePeriodInterval)interval{
    if (interval == DTTimePeriodIntervalOpen) {
        if ([self.StartDate isEarlierThan:date] && [self.EndDate isLaterThan:date]) {
            return YES;
        }
        else {
            return NO;
        }
    }
    else if (interval == DTTimePeriodIntervalClosed){
        if ([self.StartDate isEarlierThanOrEqualToDate:date] && [self.EndDate isLaterThanOrEqualToDate:date]) {
            return YES;
        }
        else {
            return NO;
        }
    }
    
    return NO;
}

#pragma mark - Period Manipulation
-(void)shiftEarlierWithSize:(DTTimePeriodSize)size{
    [self shiftEarlierWithSize:size amount:1];
}
-(void)shiftEarlierWithSize:(DTTimePeriodSize)size amount:(NSInteger)amount{
    self.StartDate = [DTTimePeriod dateWithSubtractedTime:size amount:amount baseDate:self.StartDate];
    self.EndDate = [DTTimePeriod dateWithSubtractedTime:size amount:amount baseDate:self.EndDate];
}
-(void)shiftLaterWithSize:(DTTimePeriodSize)size{
    [self shiftLaterWithSize:size amount:1];
}
-(void)shiftLaterWithSize:(DTTimePeriodSize)size amount:(NSInteger)amount{
    self.StartDate = [DTTimePeriod dateWithAddedTime:size amount:amount baseDate:self.StartDate];
    self.EndDate = [DTTimePeriod dateWithAddedTime:size amount:amount baseDate:self.EndDate];
}

#pragma mark Lengthen / Shorten
-(void)lengthenWithAnchorDate:(DTTimePeriodAnchor)anchor size:(DTTimePeriodSize)size{
    [self lengthenWithAnchorDate:anchor size:size amount:1];
}
-(void)lengthenWithAnchorDate:(DTTimePeriodAnchor)anchor size:(DTTimePeriodSize)size amount:(NSInteger)amount{
    switch (anchor) {
        case DTTimePeriodAnchorStart:
            self.EndDate = [DTTimePeriod dateWithAddedTime:size amount:amount baseDate:self.EndDate];
            break;
        case DTTimePeriodAnchorCenter:
            self.StartDate = [DTTimePeriod dateWithSubtractedTime:size amount:amount/2 baseDate:self.StartDate];
            self.EndDate = [DTTimePeriod dateWithAddedTime:size amount:amount/2 baseDate:self.EndDate];
            break;
        case DTTimePeriodAnchorEnd:
            self.StartDate = [DTTimePeriod dateWithSubtractedTime:size amount:amount baseDate:self.StartDate];
            break;
        default:
            break;
    }
}
-(void)shortenWithAnchorDate:(DTTimePeriodAnchor)anchor size:(DTTimePeriodSize)size{
    [self shortenWithAnchorDate:anchor size:size amount:1];
}
-(void)shortenWithAnchorDate:(DTTimePeriodAnchor)anchor size:(DTTimePeriodSize)size amount:(NSInteger)amount{
    switch (anchor) {
        case DTTimePeriodAnchorStart:
            self.EndDate = [DTTimePeriod dateWithSubtractedTime:size amount:amount baseDate:self.EndDate];
            break;
        case DTTimePeriodAnchorCenter:
            self.StartDate = [DTTimePeriod dateWithAddedTime:size amount:amount/2 baseDate:self.StartDate];
            self.EndDate = [DTTimePeriod dateWithSubtractedTime:size amount:amount/2 baseDate:self.EndDate];
            break;
        case DTTimePeriodAnchorEnd:
            self.StartDate = [DTTimePeriod dateWithAddedTime:size amount:amount baseDate:self.StartDate];
            break;
        default:
            break;
    }
}
@end
