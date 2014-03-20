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

#pragma mark - Custom Inits
-(instancetype)initWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate{
    if (self = [super init]) {
        self.StartDate = startDate;
        self.EndDate = endDate;
    }
    
    return self;
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
    return DTTimePeriodRelationAfter;
}

@end
