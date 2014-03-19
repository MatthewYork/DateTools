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
-(NSString *)shortTimeAgoSinceNow;
- (NSString*)timeAgoSinceDate:(NSDate*)date;
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
//Adding
- (NSDate *)dateByAddingYears:(NSInteger)years;
- (NSDate *)dateByAddingMonths:(NSInteger)months;
- (NSDate *)dateByAddingDays:(NSInteger)days;
- (NSDate *)dateByAddingHours:(NSInteger)hours;
- (NSDate *)dateByAddingMinutes:(NSInteger)minutes;
- (NSDate *)dateByAddingSeconds:(NSInteger)seconds;
//Subtracting
- (NSDate *)dateBySubtractingYears:(NSInteger)years;
- (NSDate *)dateBySubtractingMonths:(NSInteger)months;
- (NSDate *)dateBySubtractingDays:(NSInteger)days;
- (NSDate *)dateBySubtractingHours:(NSInteger)hours;
- (NSDate *)dateBySubtractingMinutes:(NSInteger)minutes;
- (NSDate *)dateBySubtractingSeconds:(NSInteger)seconds;


@end
