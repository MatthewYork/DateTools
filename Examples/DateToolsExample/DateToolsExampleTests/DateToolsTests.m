//
//  DateToolsTests.m
//  DateToolsExample
//
//  Created by Matthew York on 3/19/14.
//
//

#import <XCTest/XCTest.h>
#import "NSDate+DateTools.h"

@interface DateToolsTests : XCTestCase
@property NSDateFormatter *formatter;
@property NSDate *controlDate;
@end

@implementation DateToolsTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.formatter = [[NSDateFormatter alloc] init];
    [self.formatter setDateFormat:@"yyyy MM dd HH:mm:ss.SSS"];
    self.controlDate = [self.formatter dateFromString:@"2014 11 05 18:15:12.000"];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - Date Components

- (void)testEra {
    XCTAssertEqual(1, [[NSDate date] era], @"%s Failed", __PRETTY_FUNCTION__);
}

- (void)testYear{
    XCTAssertEqual(2014, self.controlDate.year, @"%s Failed", __PRETTY_FUNCTION__);
}

- (void)testMonth{
    XCTAssertEqual(11, self.controlDate.month, @"%s Failed", __PRETTY_FUNCTION__);
}

- (void)testDay{
    XCTAssertEqual(5, self.controlDate.day, @"%s Failed", __PRETTY_FUNCTION__);
}

- (void)testHour{
    XCTAssertEqual(18, self.controlDate.hour, @"%s Failed", __PRETTY_FUNCTION__);
}

- (void)testMinute{
    XCTAssertEqual(15, self.controlDate.minute, @"%s Failed", __PRETTY_FUNCTION__);
}

- (void)testSecond{
    XCTAssertEqual(12, self.controlDate.second, @"%s Failed", __PRETTY_FUNCTION__);
}

- (void)testWeekday{
    XCTAssertEqual(4, self.controlDate.weekday, @"%s Failed", __PRETTY_FUNCTION__);
}

- (void)testWeekdayOrdinal{
    XCTAssertEqual(1, self.controlDate.weekdayOrdinal, @"%s Failed", __PRETTY_FUNCTION__);
}

- (void)testQuarter{
    //Quarter is a little funky right now
    //XCTAssertEqual(4, self.testDate.quarter, @"%s Failed", __PRETTY_FUNCTION__);
}

- (void)testWeekOfMonth{
    XCTAssertEqual(2, self.controlDate.weekOfMonth, @"%s Failed", __PRETTY_FUNCTION__);
}

- (void)testWeekOfYear{
    XCTAssertEqual(45, self.controlDate.weekOfYear, @"%s Failed", __PRETTY_FUNCTION__);
}

- (void)testYearForWeekOfYear{
    XCTAssertEqual(2014, self.controlDate.yearForWeekOfYear, @"%s Failed", __PRETTY_FUNCTION__);
}

- (void)testDaysInMonth{
    XCTAssertEqual(30, self.controlDate.daysInMonth, @"%s Failed", __PRETTY_FUNCTION__);
}

#pragma mark - Date Editing
#pragma mark Date By Adding
- (void)testDateByAddingYears{
    NSDate *testDate = [self.formatter dateFromString:@"2016 11 05 18:15:12.000"];
    XCTAssertEqual(YES, [[self.controlDate dateByAddingYears:2] isEqualToDate:testDate], @"%s Failed", __PRETTY_FUNCTION__);
}

- (void)testDateByAddingMonths{
    NSDate *testDate = [self.formatter dateFromString:@"2015 01 05 18:15:12.000"];
    XCTAssertEqual(YES, [[self.controlDate dateByAddingMonths:2] isEqualToDate:testDate], @"%s Failed", __PRETTY_FUNCTION__);
}

- (void)testDateByAddingWeeks{
    NSDate *testDate = [self.formatter dateFromString:@"2014 11 12 18:15:12.000"];
    XCTAssertEqual(YES, [[self.controlDate dateByAddingWeeks:1] isEqualToDate:testDate], @"%s Failed", __PRETTY_FUNCTION__);
}
- (void)testDateByAddingDays{
    NSDate *testDate = [self.formatter dateFromString:@"2014 11 07 18:15:12.000"];
    XCTAssertEqual(YES, [[self.controlDate dateByAddingDays:2] isEqualToDate:testDate], @"%s Failed", __PRETTY_FUNCTION__);
}
- (void)testDateByAddingHours{
    NSDate *testDate = [self.formatter dateFromString:@"2014 11 06 6:15:12.000"];
    XCTAssertEqual(YES, [[self.controlDate dateByAddingHours:12] isEqualToDate:testDate], @"%s Failed", __PRETTY_FUNCTION__);
}
- (void)testDateByAddingMinutes{
    NSDate *testDate = [self.formatter dateFromString:@"2014 11 05 18:30:12.000"];
    XCTAssertEqual(YES, [[self.controlDate dateByAddingMinutes:15] isEqualToDate:testDate], @"%s Failed", __PRETTY_FUNCTION__);
}
- (void)testDateByAddingSeconds{
    NSDate *testDate = [self.formatter dateFromString:@"2014 11 05 18:16:12.000"];
    XCTAssertEqual(YES, [[self.controlDate dateByAddingSeconds:60] isEqualToDate:testDate], @"%s Failed", __PRETTY_FUNCTION__);
}

#pragma mark Date By Subtracting
- (void)testDateBySubtractingYears{
    NSDate *testDate = [self.formatter dateFromString:@"2000 11 05 18:15:12.000"];
    XCTAssertEqual(YES, [[self.controlDate dateBySubtractingYears:14] isEqualToDate:testDate], @"%s Failed", __PRETTY_FUNCTION__);
}

- (void)testDateBySubtractingMonths{
    NSDate *testDate = [self.formatter dateFromString:@"2014 4 05 18:15:12.000"];
    XCTAssertEqual(YES, [[self.controlDate dateBySubtractingMonths:7] isEqualToDate:testDate], @"%s Failed", __PRETTY_FUNCTION__);
}

- (void)testDateBySubtractingWeeks{
    NSDate *testDate = [self.formatter dateFromString:@"2014 10 29 18:15:12.000"];
    XCTAssertEqual(YES, [[self.controlDate dateBySubtractingWeeks:1] isEqualToDate:testDate], @"%s Failed", __PRETTY_FUNCTION__);
}

- (void)testDateBySubtractingDays{
    NSDate *testDate = [self.formatter dateFromString:@"2014 11 01 18:15:12.000"];
    XCTAssertEqual(YES, [[self.controlDate dateBySubtractingDays:4] isEqualToDate:testDate], @"%s Failed", __PRETTY_FUNCTION__);
}

- (void)testDateBySubtractingHours{
    NSDate *testDate = [self.formatter dateFromString:@"2014 11 05 00:15:12.000"];
    XCTAssertEqual(YES, [[self.controlDate dateBySubtractingHours:18] isEqualToDate:testDate], @"%s Failed", __PRETTY_FUNCTION__);
}

- (void)testDateBySubtractingMinutes{
    NSDate *testDate = [self.formatter dateFromString:@"2014 11 05 17:45:12.000"];
    XCTAssertEqual(YES, [[self.controlDate dateBySubtractingMinutes:30] isEqualToDate:testDate], @"%s Failed", __PRETTY_FUNCTION__);
}

- (void)testDateBySubtractingSeconds{
    NSDate *testDate = [self.formatter dateFromString:@"2014 11 05 18:14:12.000"];
    XCTAssertEqual(YES, [[self.controlDate dateBySubtractingSeconds:60] isEqualToDate:testDate], @"%s Failed", __PRETTY_FUNCTION__);
}

#pragma mark - Date Comparison
#pragma mark Time From
-(void)testYearsFrom{
    NSDate *testDate = [self.formatter dateFromString:@"2015 11 05 18:15:12.000"];
    XCTAssertEqual(-1, [self.controlDate yearsFrom:testDate], @"%s Failed", __PRETTY_FUNCTION__);
}

-(void)testWeeksFrom{
    //Same week
    NSDate *testSameDate = [self.formatter dateFromString:@"2014 11 06 18:15:12.000"];
    XCTAssertEqual(0, [self.controlDate weeksFrom:testSameDate], @"%s Failed", __PRETTY_FUNCTION__);
    
    //Same year
    NSDate *testDate = [self.formatter dateFromString:@"2014 11 12 18:15:12.000"];
    XCTAssertEqual(-1, [self.controlDate weeksFrom:testDate], @"%s Failed", __PRETTY_FUNCTION__);
    
    //Eariler year
    NSDate *testDate2 = [self.formatter dateFromString:@"2013 11 12 18:15:12.000"];
    XCTAssertEqual(51, [self.controlDate weeksFrom:testDate2], @"%s Failed", __PRETTY_FUNCTION__);
    
    //Later year
    NSDate *testDate3 = [self.formatter dateFromString:@"2015 11 12 18:15:12.000"];
    XCTAssertEqual(-53, [self.controlDate weeksFrom:testDate3], @"%s Failed", __PRETTY_FUNCTION__);
}

-(void)testDaysFrom{
    //Same day
    NSDate *testSameDate = [self.formatter dateFromString:@"2014 11 05 18:15:12.000"];
    XCTAssertEqual(0, [self.controlDate daysFrom:testSameDate], @"%s Failed", __PRETTY_FUNCTION__);
    
    //Same year
    NSDate *testDate = [self.formatter dateFromString:@"2014 11 12 18:15:12.000"];
    XCTAssertEqual(-7, [self.controlDate daysFrom:testDate], @"%s Failed", __PRETTY_FUNCTION__);
    
    //Eariler year
    NSDate *testDate2 = [self.formatter dateFromString:@"2013 11 12 18:15:12.000"];
    XCTAssertEqual(358, [self.controlDate daysFrom:testDate2], @"%s Failed", __PRETTY_FUNCTION__);
    
    //Later year
    NSDate *testDate3 = [self.formatter dateFromString:@"2015 11 12 18:15:12.000"];
    XCTAssertEqual(-372, [self.controlDate daysFrom:testDate3], @"%s Failed", __PRETTY_FUNCTION__);
}

-(void)testHoursFrom{
    NSDate *testDate = [self.formatter dateFromString:@"2014 11 05 20:15:12.000"];
    XCTAssertEqual(-2, [self.controlDate hoursFrom:testDate], @"%s Failed", __PRETTY_FUNCTION__);
}

-(void)testSecondsFrom{
    NSDate *testDate = [self.formatter dateFromString:@"2014 11 05 15:15:12.000"];
    XCTAssertEqual(10800, [self.controlDate secondsFrom:testDate], @"%s Failed", __PRETTY_FUNCTION__);
}

@end
