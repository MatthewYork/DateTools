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

static const unsigned int allCalendarUnitFlags = NSYearCalendarUnit | NSQuarterCalendarUnit | NSMonthCalendarUnit | NSWeekOfYearCalendarUnit | NSWeekOfMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSEraCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit | NSWeekCalendarUnit | NSYearForWeekOfYearCalendarUnit;

@implementation NSDate (DateTools)

#pragma mark - Time Ago

/**
 *  Takes in a date and returns a string with the most convenient unit of time representing
 *  how far in the past that date is from now.
 *
 *  @param NSDate - Date to be measured from now
 *
 *  @return NSString - Formatted return string
 */
+ (NSString*)timeAgoSinceDate:(NSDate*)date{
    return [date timeAgoSinceDate:[NSDate date] shortformatting:NO];
}

/**
 *  Takes in a date and returns a shortened string with the most convenient unit of time representing
 *  how far in the past that date is from now.
 *
 *  @param NSDate - Date to be measured from now
 *
 *  @return NSString - Formatted return string
 */
+ (NSString*)shortTimeAgoSinceDate:(NSDate*)date{
    return [date timeAgoSinceDate:[NSDate date] shortformatting:YES];
}

/**
 *  Returns a string with the most convenient unit of time representing
 *  how far in the past that date is from now.
 *
 *  @return NSString - Formatted return string
 */
- (NSString*)timeAgoSinceNow{
    return [self timeAgoSinceDate:[NSDate date] shortformatting:NO];
}

/**
 *  Returns a shortened string with the most convenient unit of time representing
 *  how far in the past that date is from now.
 *
 *  @return NSString - Formatted return string
 */
-(NSString *)shortTimeAgoSinceNow{
    return [self timeAgoSinceDate:[NSDate date] shortformatting:YES];
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
/**
 *  Returns the era of the receiver. (0 for BC, 1 for AD for Gregorian)
 *
 *  @return NSInteger
 */
- (NSInteger)era{
    return [self componentForDate:self type:DTDateComponentEra calendar:nil];
}

/**
 *  Returns the year of the receiver.
 *
 *  @return NSInteger
 */
- (NSInteger)year{
    return [self componentForDate:self type:DTDateComponentYear calendar:nil];
}

/**
 *  Returns the month of the year of the receiver.
 *
 *  @return NSInteger
 */
- (NSInteger)month{
    return [self componentForDate:self type:DTDateComponentMonth calendar:nil];
}

/**
 *  Returns the day of the month of the receiver.
 *
 *  @return NSInteger
 */
- (NSInteger)day{
    return [self componentForDate:self type:DTDateComponentDay calendar:nil];
}

/**
 *  Returns the hour of the day of the receiver. (0-24)
 *
 *  @return NSInteger
 */
- (NSInteger)hour{
    return [self componentForDate:self type:DTDateComponentHour calendar:nil];
}

/**
 *  Returns the minute of the receiver. (0-59)
 *
 *  @return NSInteger
 */
- (NSInteger)minute{
    return [self componentForDate:self type:DTDateComponentMinute calendar:nil];
}

/**
 *  Returns the second of the receiver. (0-59)
 *
 *  @return NSInteger
 */
- (NSInteger)second{
    return [self componentForDate:self type:DTDateComponentSecond calendar:nil];
}

/**
 *  Returns the day of the week of the receiver.
 *
 *  @return NSInteger
 */
- (NSInteger)weekday{
    return [self componentForDate:self type:DTDateComponentWeekday calendar:nil];
}

/**
 *  Returns the ordinal for the day of the week of the receiver.
 *
 *  @return NSInteger
 */
- (NSInteger)weekdayOrdinal{
    return [self componentForDate:self type:DTDateComponentWeekdayOrdinal calendar:nil];
}

/**
 *  Returns the quarter of the receiver.
 *
 *  @return NSInteger
 */
- (NSInteger)quarter{
    return [self componentForDate:self type:DTDateComponentQuarter calendar:nil];
}

/**
 *  Returns the week of the month of the receiver.
 *
 *  @return NSInteger
 */
- (NSInteger)weekOfMonth{
    return [self componentForDate:self type:DTDateComponentWeekOfMonth calendar:nil];
}

/**
 *  Returns the week of the year of the receiver.
 *
 *  @return NSInteger
 */
- (NSInteger)weekOfYear{
    return [self componentForDate:self type:DTDateComponentWeekOfYear calendar:nil];
}

/**
 *  I honestly don't know much about this value...
 *
 *  @return NSInteger
 */
- (NSInteger)yearForWeekOfYear{
    return [self componentForDate:self type:DTDateComponentYearForWeekOfYear calendar:nil];
}

/**
 *  Returns how many days are in the month of the receiver.
 *
 *  @return NSInteger
 */
- (NSInteger)daysInMonth{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange days = [calendar rangeOfUnit:NSDayCalendarUnit
                                  inUnit:NSMonthCalendarUnit
                                 forDate:self];
    return days.length;
}

/**
 *  Returns the day of the year of the receiver. (1-365 or 1-366 for leap year)
 *
 *  @return NSInteger
 */
- (NSInteger)dayOfYear{
    return [self componentForDate:self type:DTDateComponentDayOfYear calendar:nil];
}

/**
 *  Returns how many days are in the year of the receiver.
 *
 *  @return NSInteger
 */
-(NSInteger)daysInYear{
    if (self.isInLeapYear) {
        return 366;
    }
    
    return 365;
}

/**
 *  Returns whether the receiver falls in a leap year.
 *
 *  @return NSInteger
 */
-(BOOL)isInLeapYear{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dateComponents = [calendar components:allCalendarUnitFlags fromDate:self];
    
    if (dateComponents.year%400 == 0){
        return YES;
    }
    else if (dateComponents.year%100 == 0){
        return NO;
    }
    else if (dateComponents.year%4 == 0){
        return YES;
    }
    
    return NO;
}

#pragma mark - Date Components With Calendar
/**
 *  Returns the era of the receiver from a given calendar
 *
 *  @param calendar NSCalendar - The calendar to be used in the calculation
 *
 *  @return NSInteger - represents the era (0 for BC, 1 for AD for Gregorian)
 */
- (NSInteger)eraWithCalendar:(NSCalendar *)calendar{
    return [self componentForDate:self type:DTDateComponentEra calendar:calendar];
}

/**
 *  Returns the year of the receiver from a given calendar
 *
 *  @param calendar NSCalendar - The calendar to be used in the calculation
 *
 *  @return NSInteger - represents the year as an integer
 */
- (NSInteger)yearWithCalendar:(NSCalendar *)calendar{
    return [self componentForDate:self type:DTDateComponentYear calendar:calendar];
}

/**
 *  Returns the month of the receiver from a given calendar
 *
 *  @param calendar NSCalendar - The calendar to be used in the calculation
 *
 *  @return NSInteger - represents the month as an integer
 */
- (NSInteger)monthWithCalendar:(NSCalendar *)calendar{
    return [self componentForDate:self type:DTDateComponentMonth calendar:calendar];
}

/**
 *  Returns the day of the month of the receiver from a given calendar
 *
 *  @param calendar NSCalendar - The calendar to be used in the calculation
 *
 *  @return NSInteger - represents the day of the month as an integer
 */
- (NSInteger)dayWithCalendar:(NSCalendar *)calendar{
    return [self componentForDate:self type:DTDateComponentDay calendar:calendar];
}

/**
 *  Returns the hour of the day of the receiver from a given calendar
 *
 *  @param calendar NSCalendar - The calendar to be used in the calculation
 *
 *  @return NSInteger - represents the hour of the day as an integer
 */
- (NSInteger)hourWithCalendar:(NSCalendar *)calendar{
    return [self componentForDate:self type:DTDateComponentHour calendar:calendar];
}

/**
 *  Returns the minute of the hour of the receiver from a given calendar
 *
 *  @param calendar NSCalendar - The calendar to be used in the calculation
 *
 *  @return NSInteger - represents the minute of the hour as an integer
 */
- (NSInteger)minuteWithCalendar:(NSCalendar *)calendar{
    return [self componentForDate:self type:DTDateComponentMinute calendar:calendar];
}

/**
 *  Returns the second of the receiver from a given calendar
 *
 *  @param calendar NSCalendar - The calendar to be used in the calculation
 *
 *  @return NSInteger - represents the second as an integer
 */
- (NSInteger)secondWithCalendar:(NSCalendar *)calendar{
    return [self componentForDate:self type:DTDateComponentSecond calendar:calendar];
}

/**
 *  Returns the weekday of the receiver from a given calendar
 *
 *  @param calendar NSCalendar - The calendar to be used in the calculation
 *
 *  @return NSInteger - represents the weekday as an integer
 */
- (NSInteger)weekdayWithCalendar:(NSCalendar *)calendar{
    return [self componentForDate:self type:DTDateComponentWeekday calendar:calendar];
}

/**
 *  Returns the weekday ordinal of the receiver from a given calendar
 *
 *  @param calendar NSCalendar - The calendar to be used in the calculation
 *
 *  @return NSInteger - represents the weekday ordinal as an integer
 */
- (NSInteger)weekdayOrdinalWithCalendar:(NSCalendar *)calendar{
    return [self componentForDate:self type:DTDateComponentWeekdayOrdinal calendar:calendar];
}

/**
 *  Returns the quarter of the receiver from a given calendar
 *
 *  @param calendar NSCalendar - The calendar to be used in the calculation
 *
 *  @return NSInteger - represents the quarter as an integer
 */
- (NSInteger)quarterWithCalendar:(NSCalendar *)calendar{
    return [self componentForDate:self type:DTDateComponentQuarter calendar:calendar];
}

/**
 *  Returns the week of the month of the receiver from a given calendar
 *
 *  @param calendar NSCalendar - The calendar to be used in the calculation
 *
 *  @return NSInteger - represents the week of the month as an integer
 */
- (NSInteger)weekOfMonthWithCalendar:(NSCalendar *)calendar{
    return [self componentForDate:self type:DTDateComponentWeekOfMonth calendar:calendar];
}

/**
 *  Returns the week of the year of the receiver from a given calendar
 *
 *  @param calendar NSCalendar - The calendar to be used in the calculation
 *
 *  @return NSInteger - represents the week of the year as an integer
 */
- (NSInteger)weekOfYearWithCalendar:(NSCalendar *)calendar{
    return [self componentForDate:self type:DTDateComponentWeekOfYear calendar:calendar];
}

/**
 *  Returns the year for week of the year (???) of the receiver from a given calendar
 *
 *  @param calendar NSCalendar - The calendar to be used in the calculation
 *
 *  @return NSInteger - represents the year for week of the year as an integer
 */
- (NSInteger)yearForWeekOfYearWithCalendar:(NSCalendar *)calendar{
    return [self componentForDate:self type:DTDateComponentYearForWeekOfYear calendar:calendar];
}

/**
 *  Returns the day of the year of the receiver from a given calendar
 *
 *  @param calendar NSCalendar - The calendar to be used in the calculation
 *
 *  @return NSInteger - represents the day of the year as an integer
 */
- (NSInteger)dayOfYearWithCalendar:(NSCalendar *)calendar{
    return [self componentForDate:self type:DTDateComponentDayOfYear calendar:calendar];
}

/**
 *  Takes in a date, calendar and desired date component and returns the desired NSInteger
 *  representation for that component
 *
 *  @param date      NSDate - The date to be be mined for a desired component
 *  @param component DTDateComponent - The desired component (i.e. year, day, week, etc)
 *  @param calendar  NSCalendar - The calendar to be used in the processing (Defaults to Gregorian)
 *
 *  @return <#return value description#>
 */
-(NSInteger)componentForDate:(NSDate *)date type:(DTDateComponent)component calendar:(NSCalendar *)calendar{
    if (!calendar) {
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    }

    NSDateComponents *dateComponents = [calendar components:allCalendarUnitFlags fromDate:date];
    
    switch (component) {
        case DTDateComponentEra:
            return [dateComponents era];
        case DTDateComponentYear:
            return [dateComponents year];
        case DTDateComponentMonth:
            return [dateComponents month];
        case DTDateComponentDay:
            return [dateComponents day];
        case DTDateComponentHour:
            return [dateComponents hour];
        case DTDateComponentMinute:
            return [dateComponents minute];
        case DTDateComponentSecond:
            return [dateComponents second];
        case DTDateComponentWeekday:
            return [dateComponents weekday];
        case DTDateComponentWeekdayOrdinal:
            return [dateComponents weekdayOrdinal];
        case DTDateComponentQuarter:
            return [dateComponents quarter];
        case DTDateComponentWeekOfMonth:
            return [dateComponents weekOfMonth];
        case DTDateComponentWeekOfYear:
            return [dateComponents weekOfYear];
        case DTDateComponentYearForWeekOfYear:
            return [dateComponents yearForWeekOfYear];
        case DTDateComponentDayOfYear:
            return [calendar ordinalityOfUnit:NSDayCalendarUnit inUnit:NSYearCalendarUnit forDate:date];
        default:
            break;
    }
    
    return 0;
}

#pragma mark - Date Editing
#pragma mark Date By Adding
/**
 *  Returns a date representing the receivers date shifted later by the provided number of years.
 *
 *  @param years NSInteger - Number of years to add
 *
 *  @return NSDate - Date modified by the number of desired years
 */
- (NSDate *)dateByAddingYears:(NSInteger)years{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:years];
    
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

/**
 *  Returns a date representing the receivers date shifted later by the provided number of months.
 *
 *  @param years NSInteger - Number of months to add
 *
 *  @return NSDate - Date modified by the number of desired months
 */
- (NSDate *)dateByAddingMonths:(NSInteger)months{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMonth:months];
    
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

/**
 *  Returns a date representing the receivers date shifted later by the provided number of weeks.
 *
 *  @param years NSInteger - Number of weeks to add
 *
 *  @return NSDate - Date modified by the number of desired weeks
 */
- (NSDate *)dateByAddingWeeks:(NSInteger)weeks{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setWeek:weeks];
    
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

/**
 *  Returns a date representing the receivers date shifted later by the provided number of days.
 *
 *  @param years NSInteger - Number of days to add
 *
 *  @return NSDate - Date modified by the number of desired days
 */
- (NSDate *)dateByAddingDays:(NSInteger)days{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:days];
    
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

/**
 *  Returns a date representing the receivers date shifted later by the provided number of hours.
 *
 *  @param years NSInteger - Number of hours to add
 *
 *  @return NSDate - Date modified by the number of desired hours
 */
- (NSDate *)dateByAddingHours:(NSInteger)hours{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setHour:hours];
    
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

/**
 *  Returns a date representing the receivers date shifted later by the provided number of minutes.
 *
 *  @param years NSInteger - Number of minutes to add
 *
 *  @return NSDate - Date modified by the number of desired minutes
 */
- (NSDate *)dateByAddingMinutes:(NSInteger)minutes{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMinute:minutes];
    
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

/**
 *  Returns a date representing the receivers date shifted later by the provided number of seconds.
 *
 *  @param years NSInteger - Number of seconds to add
 *
 *  @return NSDate - Date modified by the number of desired seconds
 */
- (NSDate *)dateByAddingSeconds:(NSInteger)seconds{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setSecond:seconds];
    
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

#pragma mark Date By Subtracting
/**
 *  Returns a date representing the receivers date shifted earlier by the provided number of years.
 *
 *  @param years NSInteger - Number of years to subtract
 *
 *  @return NSDate - Date modified by the number of desired years
 */
- (NSDate *)dateBySubtractingYears:(NSInteger)years{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:-1*years];
    
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

/**
 *  Returns a date representing the receivers date shifted earlier by the provided number of months.
 *
 *  @param years NSInteger - Number of months to subtract
 *
 *  @return NSDate - Date modified by the number of desired months
 */
- (NSDate *)dateBySubtractingMonths:(NSInteger)months{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMonth:-1*months];
    
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

/**
 *  Returns a date representing the receivers date shifted earlier by the provided number of weeks.
 *
 *  @param years NSInteger - Number of weeks to subtract
 *
 *  @return NSDate - Date modified by the number of desired weeks
 */
- (NSDate *)dateBySubtractingWeeks:(NSInteger)weeks{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setWeek:-1*weeks];
    
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

/**
 *  Returns a date representing the receivers date shifted earlier by the provided number of days.
 *
 *  @param years NSInteger - Number of days to subtract
 *
 *  @return NSDate - Date modified by the number of desired days
 */
- (NSDate *)dateBySubtractingDays:(NSInteger)days{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:-1*days];
    
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

/**
 *  Returns a date representing the receivers date shifted earlier by the provided number of hours.
 *
 *  @param years NSInteger - Number of hours to subtract
 *
 *  @return NSDate - Date modified by the number of desired hours
 */
- (NSDate *)dateBySubtractingHours:(NSInteger)hours{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setHour:-1*hours];
    
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

/**
 *  Returns a date representing the receivers date shifted earlier by the provided number of minutes.
 *
 *  @param years NSInteger - Number of minutes to subtract
 *
 *  @return NSDate - Date modified by the number of desired minutes
 */
- (NSDate *)dateBySubtractingMinutes:(NSInteger)minutes{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMinute:-1*minutes];
    
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

/**
 *  Returns a date representing the receivers date shifted earlier by the provided number of seconds.
 *
 *  @param years NSInteger - Number of seconds to subtract
 *
 *  @return NSDate - Date modified by the number of desired seconds
 */
- (NSDate *)dateBySubtractingSeconds:(NSInteger)seconds{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setSecond:-1*seconds];
    
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

#pragma mark - Date Comparison
#pragma mark Time From
-(NSInteger)yearsFrom:(NSDate *)date{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *currentComponents = [calendar components:allCalendarUnitFlags fromDate:self];
    NSDateComponents *compareComponents = [calendar components:allCalendarUnitFlags fromDate:date];
    
    if (currentComponents.year < compareComponents.year) {
        if ([self dayOfYear] > [date dayOfYear]) {
            return currentComponents.year - compareComponents.year + 1;
        }
        else {
            return currentComponents.year - compareComponents.year;
        }
    }
    else if(currentComponents.year > compareComponents.year){
        if ([date dayOfYear] > [self dayOfYear]) {
            return currentComponents.year - compareComponents.year - 1;
        }
        else {
            return currentComponents.year - compareComponents.year;
        }
    }
    
    return 0;
}

-(NSInteger)weeksFrom:(NSDate *)date{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *currentComponents = [calendar components:allCalendarUnitFlags fromDate:self];
    NSDateComponents *compareComponents = [calendar components:allCalendarUnitFlags fromDate:date];
    
    NSInteger yearsFrom = [self yearsFrom:date];
    
    if (yearsFrom == 0) {
        if (currentComponents.year - compareComponents.year < 0) {
            return (365-[self dayOfYear] + [date dayOfYear])/7;
        }
        else if (currentComponents.year - compareComponents.year > 0){
            return  (365-[date dayOfYear] + [self dayOfYear])/7;
        }
        else {
            return currentComponents.weekOfYear - compareComponents.weekOfYear;
        }
    }
    else if (yearsFrom > 0){
        return yearsFrom*52 + ([self dayOfYear] - [date dayOfYear])/7;
    }
    else if (yearsFrom < 0){
        return yearsFrom*52 - ([date dayOfYear] - [self dayOfYear])/7;
    }

    return 0;
}

-(NSInteger)daysFrom:(NSDate *)date{
    return ([self timeIntervalSinceDate:date])/SECONDS_IN_DAY;
}

-(NSInteger)hoursFrom:(NSDate *)date{
    return ([self timeIntervalSinceDate:date])/SECONDS_IN_HOUR;
}

-(NSInteger)minutesFrom:(NSDate *)date{
    return ([self timeIntervalSinceDate:date])/SECONDS_IN_MINUTE;
}

-(NSInteger)secondsFrom:(NSDate *)date{
    return [self timeIntervalSinceDate:date];
}

#pragma mark Time Until
-(NSInteger)yearsUntil{
    return [self yearsLaterThan:[NSDate date]];
}

-(NSInteger)weeksUntil{
    return [self weeksLaterThan:[NSDate date]];
}

-(NSInteger)daysUntil{
    return [self daysLaterThan:[NSDate date]];
}

-(NSInteger)hoursUntil{
    return [self hoursLaterThan:[NSDate date]];
}

-(NSInteger)minutesUntil{
    return [self minutesLaterThan:[NSDate date]];
}

-(NSInteger)secondsUntil{
    return [self secondsLaterThan:[NSDate date]];
}

#pragma mark Time Ago
-(NSInteger)yearsAgo{
    return [self yearsEarlierThan:[NSDate date]];
}

-(NSInteger)weeksAgo{
    return [self weeksEarlierThan:[NSDate date]];
}

-(NSInteger)daysAgo{
    return [self daysEarlierThan:[NSDate date]];
}

-(NSInteger)hoursAgo{
    return [self hoursEarlierThan:[NSDate date]];
}

-(NSInteger)minutesAgo{
    return [self minutesEarlierThan:[NSDate date]];
}

-(NSInteger)secondsAgo{
    return [self secondsEarlierThan:[NSDate date]];
}

#pragma mark Earlier Than
-(NSInteger)yearsEarlierThan:(NSDate *)date{
    return ABS(MIN([self yearsFrom:date], 0));
}

-(NSInteger)weeksEarlierThan:(NSDate *)date{
    return ABS(MIN([self weeksFrom:date], 0));
}

-(NSInteger)daysEarlierThan:(NSDate *)date{
    return ABS(MIN([self daysFrom:date], 0));
}

-(NSInteger)hoursEarlierThan:(NSDate *)date{
    return ABS(MIN([self hoursFrom:date], 0));
}

-(NSInteger)minutesEarlierThan:(NSDate *)date{
    return ABS(MIN([self minutesFrom:date], 0));
}

-(NSInteger)secondsEarlierThan:(NSDate *)date{
    return ABS(MIN([self secondsFrom:date], 0));
}

#pragma mark Later Than
-(NSInteger)yearsLaterThan:(NSDate *)date{
    return MAX([self yearsFrom:date], 0);
}

-(NSInteger)weeksLaterThan:(NSDate *)date{
    return MAX([self weeksFrom:date], 0);
}

-(NSInteger)daysLaterThan:(NSDate *)date{
    return MAX([self daysFrom:date], 0);
}

-(NSInteger)hoursLaterThan:(NSDate *)date{
    return MAX([self hoursFrom:date], 0);
}

-(NSInteger)minutesLaterThan:(NSDate *)date{
    return MAX([self minutesFrom:date], 0);
}

-(NSInteger)secondsLaterThan:(NSDate *)date{
    return MAX([self secondsFrom:date], 0);
}


#pragma mark Comparators
-(BOOL)isEarlierThan:(NSDate *)date{
    if (self.timeIntervalSince1970 < date.timeIntervalSince1970) {
        return YES;
    }
    return NO;
}

-(BOOL)isLaterThan:(NSDate *)date{
    if (self.timeIntervalSince1970 > date.timeIntervalSince1970) {
        return YES;
    }
    return NO;
}

-(BOOL)isEarlierThanOrEqualToDate:(NSDate *)date{
    if (self.timeIntervalSince1970 <= date.timeIntervalSince1970) {
        return YES;
    }
    return NO;
}

-(BOOL)isLaterThanOrEqualToDate:(NSDate *)date{
    if (self.timeIntervalSince1970 >= date.timeIntervalSince1970) {
        return YES;
    }
    return NO;
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

#pragma mark - Helpers
+(BOOL)isLeapYear:(NSInteger)year{
    if (year*400){
        return YES;
    }
    else if (year%100){
        return NO;
    }
    else if (year%4){
        return YES;
    }
    
    return NO;
}
@end
