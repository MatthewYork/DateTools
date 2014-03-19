//
//  NSDate+DateTools.h
//  DateToolsExample
//
//  Created by Matthew York on 3/19/14.
//
//

#import <Foundation/Foundation.h>
#import "DTConstants.h"

@interface NSDate (DateTools)

#pragma mark - Time Ago
+ (NSString*)timeAgoSinceDate:(NSDate*)date;
+ (NSString*)shortTimeAgoSinceDate:(NSDate*)date;
- (NSString*)timeAgoSinceNow;
- (NSString*)timeAgoSinceDate:(NSDate*)date;
-(NSString *)shortTimeAgoSinceNow;
-(NSString *)shortTimeAgoSinceDate:(NSDate *)date;

#pragma mark - Date Components Without Calendar
- (NSInteger)era;
- (NSInteger)year;
- (NSInteger)month;
- (NSInteger)day;
- (NSInteger)hour;
- (NSInteger)minute;
- (NSInteger)second;
- (NSInteger)weekday;
- (NSInteger)weekdayOrdinal;
- (NSInteger)quarter;
- (NSInteger)weekOfMonth;
- (NSInteger)weekOfYear;
- (NSInteger)yearForWeekOfYear;
- (NSInteger)daysInMonth;

#pragma mark - Date Components With Calendar
- (NSInteger)eraWithcalendar:(NSCalendar *)calendar;
- (NSInteger)yearWithcalendar:(NSCalendar *)calendar;
- (NSInteger)monthWithcalendar:(NSCalendar *)calendar;
- (NSInteger)dayWithcalendar:(NSCalendar *)calendar;
- (NSInteger)hourWithcalendar:(NSCalendar *)calendar;
- (NSInteger)minuteWithcalendar:(NSCalendar *)calendar;
- (NSInteger)secondWithcalendar:(NSCalendar *)calendar;
- (NSInteger)weekdayWithcalendar:(NSCalendar *)calendar;
- (NSInteger)weekdayOrdinalWithcalendar:(NSCalendar *)calendar;
- (NSInteger)quarterWithcalendar:(NSCalendar *)calendar;
- (NSInteger)weekOfMonthWithcalendar:(NSCalendar *)calendar;
- (NSInteger)weekOfYearWithcalendar:(NSCalendar *)calendar;
- (NSInteger)yearForWeekOfYearWithcalendar:(NSCalendar *)calendar;

#pragma mark - Date Editing
#pragma mark Date By Adding
- (NSDate *)dateByAddingYears:(NSInteger)years;
- (NSDate *)dateByAddingMonths:(NSInteger)months;
- (NSDate *)dateByAddingWeeks:(NSInteger)weeks;
- (NSDate *)dateByAddingDays:(NSInteger)days;
- (NSDate *)dateByAddingHours:(NSInteger)hours;
- (NSDate *)dateByAddingMinutes:(NSInteger)minutes;
- (NSDate *)dateByAddingSeconds:(NSInteger)seconds;
- (NSDate *)dateByAddingMilliseconds:(NSInteger)milliseconds;
#pragma mark Date By Subtracting
- (NSDate *)dateBySubtractingYears:(NSInteger)years;
- (NSDate *)dateBySubtractingMonths:(NSInteger)months;
- (NSDate *)dateBySubtractingWeeks:(NSInteger)weeks;
- (NSDate *)dateBySubtractingDays:(NSInteger)days;
- (NSDate *)dateBySubtractingHours:(NSInteger)hours;
- (NSDate *)dateBySubtractingMinutes:(NSInteger)minutes;
- (NSDate *)dateBySubtractingSeconds:(NSInteger)seconds;
- (NSDate *)dateBySubtractingMilliseconds:(NSInteger)milliseconds;

#pragma mark - Date Comparison
#pragma mark Time From
-(NSInteger)yearsFrom:(NSDate *)date;
-(NSInteger)weeksFrom:(NSDate *)date;
-(NSInteger)daysFrom:(NSDate *)date;
-(NSInteger)hoursFrom:(NSDate *)date;
-(NSInteger)secondsFrom:(NSDate *)date;
-(NSInteger)millisecondsFrom:(NSDate *)date;
-(NSInteger)yearsFromNow;
-(NSInteger)weeksFromNow;
-(NSInteger)daysFromNow;
-(NSInteger)hoursFromNow;
-(NSInteger)secondsFromNow;
-(NSInteger)millisecondsFromNow;
#pragma mark Older Than
-(NSInteger)yearsOlderThan:(NSDate *)date;
-(NSInteger)weeksOlderThan:(NSDate *)date;
-(NSInteger)daysOlderThan:(NSDate *)date;
-(NSInteger)hoursOlderThan:(NSDate *)date;
-(NSInteger)minutesOlderThan:(NSDate *)date;
-(NSInteger)secondsOlderThan:(NSDate *)date;
-(NSInteger)millisecondsOlderThan:(NSDate *)date;
#pragma mark Younger Than
-(NSInteger)yearsYoungerThan:(NSDate *)date;
-(NSInteger)weeksYoungerThan:(NSDate *)date;
-(NSInteger)daysYoungerThan:(NSDate *)date;
-(NSInteger)hoursYoungerThan:(NSDate *)date;
-(NSInteger)minutesYoungerThan:(NSDate *)date;
-(NSInteger)secondsYoungerThan:(NSDate *)date;
-(NSInteger)millisecondsYoungerThan:(NSDate *)date;

#pragma mark - Formatted Dates
#pragma mark Formatted With Style
-(NSString *)formattedDateWithStyle:(NSDateFormatterStyle)style;
-(NSString *)formattedDateWithStyle:(NSDateFormatterStyle)style timeZone:(NSTimeZone *)timeZone;
-(NSString *)formattedDateWithStyle:(NSDateFormatterStyle)style locale:(NSLocale *)locale;
-(NSString *)formattedDateWithStyle:(NSDateFormatterStyle)style timeZone:(NSTimeZone *)timeZone locale:(NSLocale *)locale;
#pragma mark Formatted With Format
-(NSString *)formattedDateWithFormat:(NSString *)format;
-(NSString *)formattedDateWithFormat:(NSString *)format timeZone:(NSTimeZone *)timeZone;
-(NSString *)formattedDateWithFormat:(NSString *)format locale:(NSLocale *)locale;
-(NSString *)formattedDateWithFormat:(NSString *)format timeZone:(NSTimeZone *)timeZone locale:(NSLocale *)locale;
@end
