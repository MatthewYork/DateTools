//
//  DTTimeLaterTests.m
//  DateToolsTests
//
//

#import <XCTest/XCTest.h>
#import "NSDate+DateTools.h"

@interface DTTimeLaterTests : XCTestCase
@property NSDateFormatter *formatter;
@property NSDate *date0;
@property NSDate *date1;
@end

@implementation DTTimeLaterTests

- (void)setUp
{
    [super setUp];

    self.formatter = [[NSDateFormatter alloc] init];
    [self.formatter setDateFormat:@"yyyy MM dd HH:mm:ss.SSS"];
    self.date0 = [self.formatter dateFromString:@"2014 11 07 18:15:12.000"];
    self.date1 = [self.formatter dateFromString:@"2014 11 05 18:15:12.000"];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testBasicLongTimeLater
{
    NSString *now = [self.date0 timeLaterFromDate:self.date0];

    XCTAssert(now && now.length > 0, @"'Now' is nil or empty.");


    NSString *later = [self.date1 timeLaterFromDate:self.date0];

    XCTAssert(later && later.length > 0, @"Later is nil or empty.");
}

- (void)testLongTimeLater2Days
{
    self.date0 = [self.formatter dateFromString:@"2014 11 07 18:15:12.000"];
    self.date1 = [self.formatter dateFromString:@"2014 11 05 18:15:12.000"];
    NSString *later = [self.date0 timeLaterFromDate:self.date1];
    XCTAssertEqualObjects(later, DateToolsLocalizedStrings(@"In 2 days"));
}

- (void)testLongTimeLater1DayAndHalf
{
    self.date0 = [self.formatter dateFromString:@"2014 11 07 18:15:12.000"];
    self.date1 = [self.formatter dateFromString:@"2014 11 06 9:15:12.000"];
    NSString *later = [self.date0 timeLaterFromDate:self.date1];
    XCTAssertEqualObjects(later, DateToolsLocalizedStrings(@"Tomorrow"));
}

- (void)testLongTimeLaterExactlyTomorrow
{
    self.date0 = [self.formatter dateFromString:@"2014 11 07 18:15:12.000"];
    self.date1 = [self.formatter dateFromString:@"2014 11 06 18:15:12.000"];
    NSString *later = [self.date0 timeLaterFromDate:self.date1];
    XCTAssertEqualObjects(later, DateToolsLocalizedStrings(@"Tomorrow"));
}

- (void)testLongTimeLaterLessThan24hoursButTomorrow
{
    self.date0 = [self.formatter dateFromString:@"2014 11 07 18:15:12.000"];
    self.date1 = [self.formatter dateFromString:@"2014 11 06 20:15:12.000"];
    NSString *later = [self.date0 timeLaterFromDate:self.date1];
    XCTAssertEqualObjects(later, DateToolsLocalizedStrings(@"In 22 hours"));
}

- (void)testLongTimeLaterLessThan24hoursSameDay
{
    self.date0 = [self.formatter dateFromString:@"2014 11 07 18:15:12.000"];
    self.date1 = [self.formatter dateFromString:@"2014 11 07 10:15:12.000"];
    NSString *later = [self.date0 timeLaterFromDate:self.date1];
    XCTAssertEqualObjects(later, DateToolsLocalizedStrings(@"In 8 hours"));
}

- (void)testLongTimeLaterBetween24And48Hours
{
    self.date0 = [self.formatter dateFromString:@"2014 11 08 18:15:12.000"];
    self.date1 = [self.formatter dateFromString:@"2014 11 07 10:15:12.000"];
    NSString *later = [self.date0 timeLaterFromDate:self.date1];
    XCTAssertEqualObjects(later, DateToolsLocalizedStrings(@"Tomorrow"));
}

- (void)testBasicShortTimeLater
{
    NSString *now = [self.date0 shortTimeLaterFromDate:self.date0];

    XCTAssert(now && now.length > 0, @"'Now' is nil or empty.");


    NSString *later = [self.date1 shortTimeLaterFromDate:self.date0];

    XCTAssert(later && later.length > 0, @"Later is nil or empty.");
}


- (void)testShortTimeLater2Days
{
    self.date0 = [self.formatter dateFromString:@"2014 11 07 18:15:12.000"];
    self.date1 = [self.formatter dateFromString:@"2014 11 05 18:15:12.000"];
    NSString *later = [self.date0 shortTimeLaterFromDate:self.date1];
    XCTAssertEqualObjects(later, DateToolsLocalizedStrings(@"2d"));
}

- (void)testShortTimeLater1DayAndHalf
{
    self.date0 = [self.formatter dateFromString:@"2014 11 07 18:15:12.000"];
    self.date1 = [self.formatter dateFromString:@"2014 11 06 9:15:12.000"];
    NSString *later = [self.date0 shortTimeLaterFromDate:self.date1];
    XCTAssertEqualObjects(later, DateToolsLocalizedStrings(@"1d"));
}

- (void)testShortTimeLaterExactlyTomorrow
{
    self.date0 = [self.formatter dateFromString:@"2014 11 07 18:15:12.000"];
    self.date1 = [self.formatter dateFromString:@"2014 11 06 18:15:12.000"];
    NSString *later = [self.date0 shortTimeLaterFromDate:self.date1];
    XCTAssertEqualObjects(later, DateToolsLocalizedStrings(@"1d"));
}

- (void)testShortTimeLaterLessThan24hoursButTomorrow
{
    self.date0 = [self.formatter dateFromString:@"2014 11 07 18:15:12.000"];
    self.date1 = [self.formatter dateFromString:@"2014 11 06 20:15:12.000"];
    NSString *later = [self.date0 shortTimeLaterFromDate:self.date1];
    XCTAssertEqualObjects(later, DateToolsLocalizedStrings(@"22h"));
}

- (void)testShortTimeLaterLessThan24hoursSameDay
{
    self.date0 = [self.formatter dateFromString:@"2014 11 07 18:15:12.000"];
    self.date1 = [self.formatter dateFromString:@"2014 11 07 10:15:12.000"];
    NSString *later = [self.date0 shortTimeLaterFromDate:self.date1];
    XCTAssertEqualObjects(later, DateToolsLocalizedStrings(@"8h"));
}

- (void)testShortTimeLaterBetween24And48Hours
{
    self.date0 = [self.formatter dateFromString:@"2014 11 08 18:15:12.000"];
    self.date1 = [self.formatter dateFromString:@"2014 11 07 10:15:12.000"];
    NSString *later = [self.date0 shortTimeLaterFromDate:self.date1];
    XCTAssertEqualObjects(later, DateToolsLocalizedStrings(@"1d"));
}

@end
