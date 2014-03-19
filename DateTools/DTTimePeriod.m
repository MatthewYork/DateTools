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
        return [self.StartDate yearsOlderThan:self.EndDate];
    }
    
    return 0;
}

-(NSInteger)durationInWeeks {
    if (self.StartDate && self.EndDate) {
        return [self.StartDate weeksOlderThan:self.EndDate];
    }
    
    return 0;
}

-(NSInteger)durationInDays {
    if (self.StartDate && self.EndDate) {
        return [self.StartDate daysOlderThan:self.EndDate];
    }
    
    return 0;
}

-(NSInteger)durationInHours {
    if (self.StartDate && self.EndDate) {
        return [self.StartDate hoursOlderThan:self.EndDate];
    }
    
    return 0;
}

-(NSInteger)durationInSeconds {
    if (self.StartDate && self.EndDate) {
        return [self.StartDate secondsOlderThan:self.EndDate];
    }
    
    return 0;
}

-(NSInteger)durationInMilliseconds {
    if (self.StartDate && self.EndDate) {
        return [self.StartDate millisecondsOlderThan:self.EndDate];
    }
    
    return 0;
}

#pragma mark - Time Period Relationship

-(BOOL)isSamePeriod:(DTTimePeriod *)period{
    return NO;
}

-(BOOL)isInside:(DTTimePeriod *)period{
    return NO;
}

-(BOOL)overlapsWith:(DTTimePeriod *)period{
    return NO;
}

-(BOOL)intersects:(DTTimePeriod *)period{
    return NO;
}

@end
