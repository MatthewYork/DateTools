//
//  DTTimePeriodTests.m
//  DateToolsExample
//
//  Created by Matthew York on 3/19/14.
//
//

#import <XCTest/XCTest.h>
#import "DTTimePeriod.h"
#import "NSDate+DateTools.h"

@interface DTTimePeriodTests : XCTestCase
@property NSDateFormatter *formatter;
@property DTTimePeriod *controlTimePeriod;
@end

@implementation DTTimePeriodTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.controlTimePeriod = [[DTTimePeriod alloc] init];
    
    //Create TimePeriod that is 1 year long
     self.formatter = [[NSDateFormatter alloc] init];
    [self.formatter setDateFormat:@"yyyy MM dd HH:mm:ss.SSS"];
    self.controlTimePeriod.StartDate = [self.formatter dateFromString:@"2014 11 05 18:15:12.000"];
    self.controlTimePeriod.EndDate = [self.formatter dateFromString:@"2016 11 05 18:15:12.000"];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - Custom Init / Factory Methods
-(void)testBasicInitsAndFactoryMethods{
    //Basic init
    DTTimePeriod *testPeriodInit = [[DTTimePeriod alloc] initWithStartDate:self.controlTimePeriod.StartDate endDate:self.controlTimePeriod.EndDate];
    XCTAssertTrue([self.controlTimePeriod.StartDate isEqualToDate:testPeriodInit.StartDate] && [self.controlTimePeriod.EndDate isEqualToDate:testPeriodInit.EndDate],  @"%s Failed", __PRETTY_FUNCTION__);
    
    //Basic factory
    DTTimePeriod *testPeriodFactoryInit = [DTTimePeriod timePeriodWithStartDate:self.controlTimePeriod.StartDate endDate:self.controlTimePeriod.EndDate];
    XCTAssertTrue([self.controlTimePeriod.StartDate isEqualToDate:testPeriodFactoryInit.StartDate] && [self.controlTimePeriod.EndDate isEqualToDate:testPeriodFactoryInit.EndDate],  @"%s Failed", __PRETTY_FUNCTION__);
}
-(void)testFactoryStartingAt{
    //Test dates
    NSDate *startLaterSecond = [self.formatter dateFromString:@"2014 11 05 18:15:13.000"];
    NSDate *startLaterMinute = [self.formatter dateFromString:@"2014 11 05 18:16:12.000"];
    NSDate *startLaterHour = [self.formatter dateFromString:@"2014 11 05 19:15:12.000"];
    NSDate *startLaterDay = [self.formatter dateFromString:@"2014 11 06 18:15:12.000"];
    NSDate *startLaterWeek = [self.formatter dateFromString:@"2014 11 12 18:15:12.000"];
    NSDate *startLaterMonth = [self.formatter dateFromString:@"2014 12 05 18:15:12.000"];
    NSDate *startLaterYear = [self.formatter dateFromString:@"2015 11 05 18:15:12.000"];
    
    //Starting At
    //Second time period
    DTTimePeriod *testPeriodSecond  = [DTTimePeriod timePeriodWithSize:DTTimePeriodSizeSecond startingAt:self.controlTimePeriod.StartDate];
    XCTAssertTrue([testPeriodSecond.StartDate isEqualToDate:self.controlTimePeriod.StartDate] && [testPeriodSecond.EndDate isEqualToDate:startLaterSecond],  @"%s Failed", __PRETTY_FUNCTION__);
    
    //Minute time period
    DTTimePeriod *testPeriodMinute  = [DTTimePeriod timePeriodWithSize:DTTimePeriodSizeMinute startingAt:self.controlTimePeriod.StartDate];
    XCTAssertTrue([testPeriodMinute.StartDate isEqualToDate:self.controlTimePeriod.StartDate] && [testPeriodMinute.EndDate isEqualToDate:startLaterMinute],  @"%s Failed", __PRETTY_FUNCTION__);
    
    //Hour time period
    DTTimePeriod *testPeriodHour  = [DTTimePeriod timePeriodWithSize:DTTimePeriodSizeHour startingAt:self.controlTimePeriod.StartDate];
    XCTAssertTrue([testPeriodHour.StartDate isEqualToDate:self.controlTimePeriod.StartDate] && [testPeriodHour.EndDate isEqualToDate:startLaterHour],  @"%s Failed", __PRETTY_FUNCTION__);
    
    //Day time period
    DTTimePeriod *testPeriodDay  = [DTTimePeriod timePeriodWithSize:DTTimePeriodSizeDay startingAt:self.controlTimePeriod.StartDate];
    XCTAssertTrue([testPeriodDay.StartDate isEqualToDate:self.controlTimePeriod.StartDate] && [testPeriodDay.EndDate isEqualToDate:startLaterDay],  @"%s Failed", __PRETTY_FUNCTION__);
    
    //Week time period
    DTTimePeriod *testPeriodWeek  = [DTTimePeriod timePeriodWithSize:DTTimePeriodSizeWeek startingAt:self.controlTimePeriod.StartDate];
    XCTAssertTrue([testPeriodWeek.StartDate isEqualToDate:self.controlTimePeriod.StartDate] && [testPeriodWeek.EndDate isEqualToDate:startLaterWeek],  @"%s Failed", __PRETTY_FUNCTION__);
    
    //Month time period
    DTTimePeriod *testPeriodMonth  = [DTTimePeriod timePeriodWithSize:DTTimePeriodSizeMonth startingAt:self.controlTimePeriod.StartDate];
    XCTAssertTrue([testPeriodMonth.StartDate isEqualToDate:self.controlTimePeriod.StartDate] && [testPeriodMonth.EndDate isEqualToDate:startLaterMonth],  @"%s Failed", __PRETTY_FUNCTION__);
    
    //Year time period
    DTTimePeriod *testPeriodYear  = [DTTimePeriod timePeriodWithSize:DTTimePeriodSizeYear startingAt:self.controlTimePeriod.StartDate];
    XCTAssertTrue([testPeriodYear.StartDate isEqualToDate:self.controlTimePeriod.StartDate] && [testPeriodYear.EndDate isEqualToDate:startLaterYear],  @"%s Failed", __PRETTY_FUNCTION__);
}
-(void)testFactoryEndingAt {
    //Test End dates
    NSDate *endEarlierSecond = [self.formatter dateFromString:@"2016 11 05 18:15:11.000"];
    NSDate *endEarlierMinute = [self.formatter dateFromString:@"2016 11 05 18:14:12.000"];
    NSDate *endEarlierHour = [self.formatter dateFromString:@"2016 11 05 17:15:12.000"];
    NSDate *endEarlierDay = [self.formatter dateFromString:@"2016 11 04 18:15:12.000"];
    NSDate *endEarlierWeek = [self.formatter dateFromString:@"2016 10 29 18:15:12.000"];
    NSDate *endEarlierMonth = [self.formatter dateFromString:@"2016 10 05 18:15:12.000"];
    NSDate *endEarlierYear = [self.formatter dateFromString:@"2015 11 05 18:15:12.000"];
    
    //Ending At
    //Second time period
    DTTimePeriod *testPeriodSecond  = [DTTimePeriod timePeriodWithSize:DTTimePeriodSizeSecond endingAt:self.controlTimePeriod.EndDate];
    XCTAssertTrue([testPeriodSecond.StartDate isEqualToDate:endEarlierSecond] && [testPeriodSecond.EndDate isEqualToDate:self.controlTimePeriod.EndDate],  @"%s Failed", __PRETTY_FUNCTION__);
    
    //Minute time period
    DTTimePeriod *testPeriodMinute  = [DTTimePeriod timePeriodWithSize:DTTimePeriodSizeMinute endingAt:self.controlTimePeriod.EndDate];
    XCTAssertTrue([testPeriodMinute.StartDate isEqualToDate:endEarlierMinute] && [testPeriodMinute.EndDate isEqualToDate:self.controlTimePeriod.EndDate],  @"%s Failed", __PRETTY_FUNCTION__);
    
    //Hour time period
    DTTimePeriod *testPeriodHour  = [DTTimePeriod timePeriodWithSize:DTTimePeriodSizeHour endingAt:self.controlTimePeriod.EndDate];
    XCTAssertTrue([testPeriodHour.StartDate isEqualToDate:endEarlierHour] && [testPeriodHour.EndDate isEqualToDate:self.controlTimePeriod.EndDate],  @"%s Failed", __PRETTY_FUNCTION__);
    
    //Day time period
    DTTimePeriod *testPeriodDay  = [DTTimePeriod timePeriodWithSize:DTTimePeriodSizeDay endingAt:self.controlTimePeriod.EndDate];
    XCTAssertTrue([testPeriodDay.StartDate isEqualToDate:endEarlierDay] && [testPeriodDay.EndDate isEqualToDate:self.controlTimePeriod.EndDate],  @"%s Failed", __PRETTY_FUNCTION__);
    
    //Week time period
    DTTimePeriod *testPeriodWeek  = [DTTimePeriod timePeriodWithSize:DTTimePeriodSizeWeek endingAt:self.controlTimePeriod.EndDate];
    XCTAssertTrue([testPeriodWeek.StartDate isEqualToDate:endEarlierWeek] && [testPeriodWeek.EndDate isEqualToDate:self.controlTimePeriod.EndDate],  @"%s Failed", __PRETTY_FUNCTION__);
    
    //Month time period
    DTTimePeriod *testPeriodMonth  = [DTTimePeriod timePeriodWithSize:DTTimePeriodSizeMonth endingAt:self.controlTimePeriod.EndDate];
    XCTAssertTrue([testPeriodMonth.StartDate isEqualToDate:endEarlierMonth] && [testPeriodMonth.EndDate isEqualToDate:self.controlTimePeriod.EndDate],  @"%s Failed", __PRETTY_FUNCTION__);
    
    //Year time period
    DTTimePeriod *testPeriodYear  = [DTTimePeriod timePeriodWithSize:DTTimePeriodSizeYear endingAt:self.controlTimePeriod.EndDate];
    XCTAssertTrue([testPeriodYear.StartDate isEqualToDate:endEarlierYear] && [testPeriodYear.EndDate isEqualToDate:self.controlTimePeriod.EndDate],  @"%s Failed", __PRETTY_FUNCTION__);
}

#pragma mark - Time Period Information
-(void)testHasStartDate{
    //Has start date
    XCTAssertTrue([self.controlTimePeriod hasStartDate],  @"%s Failed", __PRETTY_FUNCTION__);
    
    //Deosn't have start date
    DTTimePeriod *testPeriod = [DTTimePeriod timePeriodWithStartDate:nil endDate:self.controlTimePeriod.EndDate];
    XCTAssertFalse([testPeriod hasStartDate],  @"%s Failed", __PRETTY_FUNCTION__);
}
-(void)testHasEndDate{
    //Has end date
    XCTAssertTrue([self.controlTimePeriod hasEndDate],  @"%s Failed", __PRETTY_FUNCTION__);
    
    //Deosn't have end date
    DTTimePeriod *testPeriod = [DTTimePeriod timePeriodWithStartDate:self.controlTimePeriod.StartDate endDate:nil];
    XCTAssertFalse([testPeriod hasEndDate],  @"%s Failed", __PRETTY_FUNCTION__);
}
-(void)testDurationInYears{
    XCTAssertEqual(2, [self.controlTimePeriod durationInYears],  @"%s Failed", __PRETTY_FUNCTION__);
}
-(void)testDurationInWeeks{
    XCTAssertEqual(104, [self.controlTimePeriod durationInWeeks],  @"%s Failed", __PRETTY_FUNCTION__);
}
-(void)testDurationInDays{
    XCTAssertEqual(730, [self.controlTimePeriod durationInDays],  @"%s Failed", __PRETTY_FUNCTION__);
}
-(void)testDurationInHours{
    DTTimePeriod *testPeriod = [DTTimePeriod timePeriodWithStartDate:self.controlTimePeriod.StartDate endDate:[self.controlTimePeriod.StartDate dateByAddingHours:4]];
    XCTAssertEqual(4, [testPeriod durationInHours],  @"%s Failed", __PRETTY_FUNCTION__);
}
-(void)testDurationInMinutes{
    DTTimePeriod *testPeriod = [DTTimePeriod timePeriodWithStartDate:self.controlTimePeriod.StartDate endDate:[self.controlTimePeriod.StartDate dateByAddingHours:4]];
    XCTAssertEqual(240, [testPeriod durationInMinutes],  @"%s Failed", __PRETTY_FUNCTION__);
}
-(void)testDurationInSeconds{
    DTTimePeriod *testPeriod = [DTTimePeriod timePeriodWithStartDate:self.controlTimePeriod.StartDate endDate:[self.controlTimePeriod.StartDate dateByAddingHours:4]];
    XCTAssertEqual(14400, [testPeriod durationInSeconds],  @"%s Failed", __PRETTY_FUNCTION__);
}

#pragma mark - Time Period Relationship
-(void)testIsSamePeriod{
    //Same
    XCTAssertTrue([self.controlTimePeriod isSamePeriod:self.controlTimePeriod],  @"%s Failed", __PRETTY_FUNCTION__);
    
    //Different ending
    DTTimePeriod *differentEndPeriod = [DTTimePeriod timePeriodWithStartDate:self.controlTimePeriod.StartDate endDate:[self.controlTimePeriod.EndDate dateByAddingYears:1]];
    XCTAssertFalse([self.controlTimePeriod isSamePeriod:differentEndPeriod],  @"%s Failed", __PRETTY_FUNCTION__);
    
    //Different beginning
    DTTimePeriod *differentStartPeriod = [DTTimePeriod timePeriodWithStartDate:[self.controlTimePeriod.StartDate dateBySubtractingYears:1] endDate:self.controlTimePeriod.EndDate];
    XCTAssertFalse([self.controlTimePeriod isSamePeriod:differentStartPeriod],  @"%s Failed", __PRETTY_FUNCTION__);
    
    //Both endings different
    DTTimePeriod *differentStartAndEndPeriod = [DTTimePeriod timePeriodWithStartDate:[self.controlTimePeriod.StartDate dateBySubtractingYears:1] endDate:[self.controlTimePeriod.EndDate dateBySubtractingWeeks:1]];
    XCTAssertFalse([self.controlTimePeriod isSamePeriod:differentStartAndEndPeriod],  @"%s Failed", __PRETTY_FUNCTION__);
}
-(void)testIsInside{
    
}
-(void)testContains{
    
}
-(void)testOverlapsWith{
    
}
-(void)testIntersects{
    
}
-(void)testRelationToPeriod{
    
}

#pragma mark - Date Relationships
-(void)testContainsDate{
    
}
@end
