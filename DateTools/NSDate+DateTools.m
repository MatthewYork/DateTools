//
//  NSDate+DateTools.m
//  DateToolsExample
//
//  Created by Matthew York on 3/19/14.
//
//

#import "NSDate+DateTools.h"

/**
 *  Constant describing the desired length of the string for a shortened time ago unit
 *  Example: If 1 is provided then "week" becomes "w" for the shortenedTimeAgoString
 */
static const NSUInteger SHORT_TIME_AGO_STRING_LENGTH = 1;

@implementation NSDate (DateTools)

#pragma mark - Time Ago

+ (NSString*)timeAgoSinceDate:(NSDate*)date{
    return [[NSDate date] timeAgoSinceDate:date shortformatting:NO];
}

+ (NSString*)shortTimeAgoSinceDate:(NSDate*)date{
    return [[NSDate date] timeAgoSinceDate:date shortformatting:YES];
}

- (NSString*)timeAgoSinceNow{
    return [self timeAgoSinceDate:[NSDate date] shortformatting:NO];
}

-(NSString *)shortTimeAgoSinceNow{
    return [self timeAgoSinceDate:[NSDate date] shortformatting:YES];
}

- (NSString*)timeAgoSinceDate:(NSDate*)date{
    return [self timeAgoSinceDate:date shortformatting:NO];
}

-(NSString *)shortTimeAgoSinceDate:(NSDate *)date{
    return [self timeAgoSinceDate:date shortformatting:YES];
}

-(NSString *)timeAgoSinceDate:(NSDate *)date shortformatting:(BOOL)shortFormatting{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSMinuteCalendarUnit | NSHourCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit;
    NSDate *earliest = [self earlierDate:date];
    NSDate *latest = (earliest == self) ? date : self;
    NSDateComponents *components = [calendar components:unitFlags fromDate:earliest toDate:latest options:0];
    
    NSString *componentName = @"";
    NSInteger componentValue = 0;
    
    if (components.year >= 1) {
        return NSLocalizedString(@"over a year ago", nil);
    }
    else if (components.month >= 1) {
        componentValue = components.month;
        componentName = (components.month == 1)? NSLocalizedString(@"month", nil):NSLocalizedString(@"months", nil);
    }
    else if (components.week >= 1) {
        componentValue = components.week;
        componentName = (components.week == 1)? NSLocalizedString(@"week", nil):NSLocalizedString(@"weeks", nil);
    }
    else if (components.day >= 1) {
        componentValue = components.day;
        componentName = (components.day == 1)? NSLocalizedString(@"day", nil):NSLocalizedString(@"days", nil);
    }
    else if (components.hour >= 1) {
        componentValue = components.hour;
        componentName = (components.hour == 1)? NSLocalizedString(@"hour", nil):NSLocalizedString(@"hours", nil);
    }
    else if (components.minute >= 1) {
        componentValue = components.minute;
        componentName = (components.minute == 1)? NSLocalizedString(@"minute", nil):NSLocalizedString(@"minutes", nil);
    }
    else {
        if (shortFormatting) {
            return NSLocalizedString(@"now", nil);
        }
        else {
            return NSLocalizedString(@"just now", nil);
        }
    }
    
    //If short formatting is requested, only take the first character of your string
    if (shortFormatting) {
        //Make sure that the provided substring length is not too long for the component name
        if (SHORT_TIME_AGO_STRING_LENGTH < componentName.length) {
            componentName = [componentName substringToIndex:SHORT_TIME_AGO_STRING_LENGTH];
        }
        else {
            componentName = [componentName substringToIndex:1];
        }
    }
    
    return [self stringForComponentValue:componentValue withName:componentName shortFormatting:shortFormatting];
}

- (NSString*)stringForComponentValue:(NSInteger)componentValue withName:(NSString*)name shortFormatting:(BOOL)shortFormatting
{
    //If shortened formatting is requested, drop the "ago" part of the time ago
    if (shortFormatting) {
        return [NSString stringWithFormat:@"%d%@", componentValue, name];
    }
    else {
        return [NSString stringWithFormat:@"%d %@ %@", componentValue, name, NSLocalizedString(@"ago", nil)];
    }
    
}

@end
