//
//  NSDate+DateTools.m
//  DateToolsExample
//
//  Created by Matthew York on 3/19/14.
//
//

#import "NSDate+DateTools.h"

typedef NS_ENUM(NSUInteger, DTDateComponent){
    DTDateComponentEra,
    DTDateComponentYear,
    DTDateComponentMonth,
    DTDateComponentDay,
    DTDateComponentHour,
    DTDateComponentMinute,
    DTDateComponentSecond,
    DTDateComponentWeekday,
    DTDateComponentWeekdayOrdinal,
    DTDateComponentQuarter,
    DTDateComponentWeekOfMonth,
    DTDateComponentWeekOfYear,
    DTDateComponentYearForWeekOfYear,
    DTDateComponentDayOfYear
};

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

- (NSString*)timeAgoSinceDate:(NSDate*)date{
    return [self timeAgoSinceDate:date shortformatting:NO];
}

-(NSString *)shortTimeAgoSinceNow{
    return [self timeAgoSinceDate:[NSDate date] shortformatting:YES];
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

#pragma mark - Date Components Without Calendar

- (NSInteger)era{
    return [self componentForDate:self type:DTDateComponentEra calendar:nil];
}

- (NSInteger)year{
    return [self componentForDate:self type:DTDateComponentYear calendar:nil];
}

- (NSInteger)month{
    return [self componentForDate:self type:DTDateComponentMonth calendar:nil];
}

- (NSInteger)day{
    return [self componentForDate:self type:DTDateComponentDay calendar:nil];
}

- (NSInteger)hour{
    return [self componentForDate:self type:DTDateComponentHour calendar:nil];
}

- (NSInteger)minute{
    return [self componentForDate:self type:DTDateComponentMinute calendar:nil];
}

- (NSInteger)second{
    return [self componentForDate:self type:DTDateComponentSecond calendar:nil];
}

- (NSInteger)weekday{
    return [self componentForDate:self type:DTDateComponentWeekday calendar:nil];
}

- (NSInteger)weekdayOrdinal{
    return [self componentForDate:self type:DTDateComponentWeekdayOrdinal calendar:nil];
}

- (NSInteger)quarter{
    return [self componentForDate:self type:DTDateComponentQuarter calendar:nil];
}

- (NSInteger)weekOfMonth{
    return [self componentForDate:self type:DTDateComponentWeekOfMonth calendar:nil];
}

- (NSInteger)weekOfYear{
    return [self componentForDate:self type:DTDateComponentWeekOfYear calendar:nil];
}

- (NSInteger)yearForWeekOfYear{
    return [self componentForDate:self type:DTDateComponentYearForWeekOfYear calendar:nil];
}

- (NSInteger)dayOfYear{
    return [self componentForDate:self type:DTDateComponentDayOfYear calendar:nil];
}

- (NSInteger)daysInMonth{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange days = [calendar rangeOfUnit:NSDayCalendarUnit
                           inUnit:NSMonthCalendarUnit
                          forDate:self];
    return days.length;
}

#pragma mark - Date Components With Calendar

- (NSInteger)eraWithcalendar:(NSCalendar *)calendar{
    return [self componentForDate:self type:DTDateComponentEra calendar:calendar];
}

- (NSInteger)yearWithcalendar:(NSCalendar *)calendar{
    return [self componentForDate:self type:DTDateComponentYear calendar:calendar];
}

- (NSInteger)monthWithcalendar:(NSCalendar *)calendar{
    return [self componentForDate:self type:DTDateComponentMonth calendar:calendar];
}

- (NSInteger)dayWithcalendar:(NSCalendar *)calendar{
    return [self componentForDate:self type:DTDateComponentDay calendar:calendar];
}

- (NSInteger)hourWithcalendar:(NSCalendar *)calendar{
    return [self componentForDate:self type:DTDateComponentHour calendar:calendar];
}

- (NSInteger)minuteWithcalendar:(NSCalendar *)calendar{
    return [self componentForDate:self type:DTDateComponentMinute calendar:calendar];
}

- (NSInteger)secondWithcalendar:(NSCalendar *)calendar{
    return [self componentForDate:self type:DTDateComponentSecond calendar:calendar];
}

- (NSInteger)weekdayWithcalendar:(NSCalendar *)calendar{
    return [self componentForDate:self type:DTDateComponentWeekday calendar:calendar];
}

- (NSInteger)weekdayOrdinalWithcalendar:(NSCalendar *)calendar{
    return [self componentForDate:self type:DTDateComponentWeekdayOrdinal calendar:calendar];
}

- (NSInteger)quarterWithcalendar:(NSCalendar *)calendar{
    return [self componentForDate:self type:DTDateComponentQuarter calendar:calendar];
}

- (NSInteger)weekOfMonthWithcalendar:(NSCalendar *)calendar{
    return [self componentForDate:self type:DTDateComponentWeekOfMonth calendar:calendar];
}

- (NSInteger)weekOfYearWithcalendar:(NSCalendar *)calendar{
    return [self componentForDate:self type:DTDateComponentWeekOfYear calendar:calendar];
}

- (NSInteger)yearForWeekOfYearWithcalendar:(NSCalendar *)calendar{
    return [self componentForDate:self type:DTDateComponentYearForWeekOfYear calendar:calendar];
}

- (NSInteger)dayOfYearWithcalendar:(NSCalendar *)calendar{
    return [self componentForDate:self type:DTDateComponentDayOfYear calendar:calendar];
}

-(NSInteger)componentForDate:(NSDate *)date type:(DTDateComponent)component calendar:(NSCalendar *)calendar{
    if (!calendar) {
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    }
    NSDateComponents *weekdayComponents =[calendar components:NSWeekdayCalendarUnit fromDate:date];
    
    switch (component) {
        case DTDateComponentEra:
            return [weekdayComponents era];
        case DTDateComponentYear:
            return [weekdayComponents year];
        case DTDateComponentMonth:
            return [weekdayComponents month];
        case DTDateComponentDay:
            return [weekdayComponents day];
        case DTDateComponentHour:
            return [weekdayComponents hour];
        case DTDateComponentMinute:
            return [weekdayComponents minute];
        case DTDateComponentSecond:
            return [weekdayComponents second];
        case DTDateComponentWeekday:
            return [weekdayComponents weekday];
        case DTDateComponentWeekdayOrdinal:
            return [weekdayComponents weekdayOrdinal];
        case DTDateComponentQuarter:
            return [weekdayComponents quarter];
        case DTDateComponentWeekOfMonth:
            return [weekdayComponents month];
        case DTDateComponentWeekOfYear:
            return [weekdayComponents year];
        case DTDateComponentYearForWeekOfYear:
            return [weekdayComponents weekOfYear];
        case DTDateComponentDayOfYear:
            return [calendar ordinalityOfUnit:NSDayCalendarUnit inUnit:NSYearCalendarUnit forDate:self];
        default:
            break;
    }
    
    return 0;
}

#pragma mark - Date Editing
#pragma mark Date By Adding
- (NSDate *)dateByAddingYears:(NSInteger)years{
    return [self dateByAddingTimeInterval:SECONDS_IN_YEAR*years];
}

- (NSDate *)dateByAddingMonths:(NSInteger)months{
    //Create a date formatter for manipulation
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy MM"];
    
    //Calculate how many years and months to add
    NSInteger yearsToAdd = months/12;
    NSInteger monthsToAdd = months%12;
    
    NSArray *dateComponents = [[formatter stringFromDate:self] componentsSeparatedByString:@" "];
    if (dateComponents.count == 2) {
        //Convert back to years for manipulations
        NSInteger currentYear = [dateComponents[0] integerValue];
        NSInteger currentMonth = [dateComponents[1] integerValue];
        
        //Create new string with years and months added
        NSString *newDateString = [NSString stringWithFormat:@"%d %d", currentYear+yearsToAdd, currentMonth+monthsToAdd];
        
        //Return the updated date
        return [formatter dateFromString:newDateString];
    }
    
    return self;
}

- (NSDate *)dateByAddingWeeks:(NSInteger)weeks{
    return [self dateByAddingTimeInterval:SECONDS_IN_WEEK*weeks];
}

- (NSDate *)dateByAddingDays:(NSInteger)days{
    return [self dateByAddingTimeInterval:SECONDS_IN_DAY*days];
}

- (NSDate *)dateByAddingHours:(NSInteger)hours{
    return [self dateByAddingTimeInterval:SECONDS_IN_HOUR*hours];
}

- (NSDate *)dateByAddingMinutes:(NSInteger)minutes{
    return [self dateByAddingTimeInterval:SECONDS_IN_MINUTE*minutes];
}

- (NSDate *)dateByAddingSeconds:(NSInteger)seconds{
    return [self dateByAddingTimeInterval:seconds];
}

#pragma mark Date By Subtracting
- (NSDate *)dateBySubtractingYears:(NSInteger)years{
    return [self dateByAddingTimeInterval:-1*SECONDS_IN_YEAR*years];
}

- (NSDate *)dateBySubtractingMonths:(NSInteger)months{
    //Create a date formatter for manipulation
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy MM"];
    
    //Calculate how many years and months to add
    NSInteger yearsToSubtract = months/12;
    NSInteger monthsToSubtract = months%12;
    
    NSArray *dateComponents = [[formatter stringFromDate:self] componentsSeparatedByString:@" "];
    if (dateComponents.count == 2) {
        //Convert back to years for manipulations
        NSInteger currentYear = [dateComponents[0] integerValue];
        NSInteger currentMonth = [dateComponents[1] integerValue];
        
        //Create new string with years and months added
        NSString *newDateString = [NSString stringWithFormat:@"%d %d", currentYear-yearsToSubtract, currentMonth-monthsToSubtract];
        
        //Return the updated date
        return [formatter dateFromString:newDateString];
    }
    
    return self;
}

- (NSDate *)dateBySubtractingWeeks:(NSInteger)weeks{
    return [self dateByAddingTimeInterval:-1*SECONDS_IN_WEEK*weeks];
}

- (NSDate *)dateBySubtractingDays:(NSInteger)days{
    return [self dateByAddingTimeInterval:-1*SECONDS_IN_DAY*days];
}

- (NSDate *)dateBySubtractingHours:(NSInteger)hours{
    return [self dateByAddingTimeInterval:-1*SECONDS_IN_HOUR*hours];
}

- (NSDate *)dateBySubtractingMinutes:(NSInteger)minutes{
    return [self dateByAddingTimeInterval:-1*SECONDS_IN_MINUTE*minutes];
}

- (NSDate *)dateBySubtractingSeconds:(NSInteger)seconds{
    return [self dateByAddingTimeInterval:-1*seconds];
}

#pragma mark - Date Comparison
#pragma mark Time From
-(NSInteger)yearsFrom:(NSDate *)date{
    return ([self timeIntervalSinceDate:date])/SECONDS_IN_YEAR;
}

-(NSInteger)weeksFrom:(NSDate *)date{
    return ([self timeIntervalSinceDate:date])/SECONDS_IN_WEEK;
}

-(NSInteger)daysFrom:(NSDate *)date{
    return ([self timeIntervalSinceDate:date])/SECONDS_IN_DAY;
}

-(NSInteger)hoursFrom:(NSDate *)date{
    return ([self timeIntervalSinceDate:date])/SECONDS_IN_HOUR;
}

-(NSInteger)secondsFrom:(NSDate *)date{
    return [self timeIntervalSinceDate:date];
}

-(NSInteger)yearsFromNow{
    return ([self timeIntervalSinceDate:[NSDate date]])/SECONDS_IN_YEAR;
}

-(NSInteger)weeksFromNow{
    return ([self timeIntervalSinceDate:[NSDate date]])/SECONDS_IN_WEEK;
}

-(NSInteger)daysFromNow{
    return ([self timeIntervalSinceDate:[NSDate date]])/SECONDS_IN_DAY;
}

-(NSInteger)hoursFromNow{
    return ([self timeIntervalSinceDate:[NSDate date]])/SECONDS_IN_HOUR;
}

-(NSInteger)secondsFromNow{
    return [self timeIntervalSinceDate:[NSDate date]];
}

#pragma mark Older Than
-(NSInteger)yearsOlderThan:(NSDate *)date{
    return ABS(MIN([self timeIntervalSinceDate:date]/SECONDS_IN_YEAR, 0));
}

-(NSInteger)weeksOlderThan:(NSDate *)date{
    return ABS(MIN([self timeIntervalSinceDate:date]/SECONDS_IN_WEEK, 0));
}

-(NSInteger)daysOlderThan:(NSDate *)date{
    return ABS(MIN([self timeIntervalSinceDate:date]/SECONDS_IN_DAY, 0));
}

-(NSInteger)hoursOlderThan:(NSDate *)date{
    return ABS(MIN([self timeIntervalSinceDate:date]/SECONDS_IN_HOUR, 0));
}

-(NSInteger)minutesOlderThan:(NSDate *)date{
    return ABS(MIN([self timeIntervalSinceDate:date]/SECONDS_IN_MINUTE, 0));
}

-(NSInteger)secondsOlderThan:(NSDate *)date{
    return ABS(MIN([self timeIntervalSinceDate:date], 0));
}

#pragma mark Younger Than
-(NSInteger)yearsYoungerThan:(NSDate *)date{
    return MAX([self timeIntervalSinceDate:date]/SECONDS_IN_YEAR, 0);
}

-(NSInteger)weeksYoungerThan:(NSDate *)date{
    return MAX([self timeIntervalSinceDate:date]/SECONDS_IN_WEEK, 0);
}

-(NSInteger)daysYoungerThan:(NSDate *)date{
    return MAX([self timeIntervalSinceDate:date]/SECONDS_IN_YEAR, 0);
}

-(NSInteger)hoursYoungerThan:(NSDate *)date{
    return MAX([self timeIntervalSinceDate:date]/SECONDS_IN_HOUR, 0);
}

-(NSInteger)minutesYoungerThan:(NSDate *)date{
    return MAX([self timeIntervalSinceDate:date]/SECONDS_IN_MINUTE, 0);
}

-(NSInteger)secondsYoungerThan:(NSDate *)date{
    return MAX([self timeIntervalSinceDate:date], 0);
}

#pragma mark - Formatted Dates
#pragma mark Formatted With Style
-(NSString *)formattedDateWithStyle:(NSDateFormatterStyle)style{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:style];
    return [formatter stringFromDate:self];
}

-(NSString *)formattedDateWithStyle:(NSDateFormatterStyle)style timeZone:(NSTimeZone *)timeZone{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:style];
    [formatter setTimeZone:timeZone];
    return [formatter stringFromDate:self];
}

-(NSString *)formattedDateWithStyle:(NSDateFormatterStyle)style locale:(NSLocale *)locale{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:style];
    [formatter setLocale:locale];
    return [formatter stringFromDate:self];
}

-(NSString *)formattedDateWithStyle:(NSDateFormatterStyle)style timeZone:(NSTimeZone *)timeZone locale:(NSLocale *)locale{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:style];
    [formatter setTimeZone:timeZone];
    [formatter setLocale:locale];
    return [formatter stringFromDate:self];
}

#pragma mark Formatted With Format
-(NSString *)formattedDateWithFormat:(NSString *)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:self];
}

-(NSString *)formattedDateWithFormat:(NSString *)format timeZone:(NSTimeZone *)timeZone{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    [formatter setTimeZone:timeZone];
    return [formatter stringFromDate:self];
}

-(NSString *)formattedDateWithFormat:(NSString *)format locale:(NSLocale *)locale{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    [formatter setLocale:locale];
    return [formatter stringFromDate:self];
}

-(NSString *)formattedDateWithFormat:(NSString *)format timeZone:(NSTimeZone *)timeZone locale:(NSLocale *)locale{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
     [formatter setTimeZone:timeZone];
    [formatter setLocale:locale];
    return [formatter stringFromDate:self];
}
@end
