//
//  DTTimeAgoTests.m
//  DateToolsTests
//
//  Created by kevin on 2014.04.05.
//
//

#import <XCTest/XCTest.h>
#import "NSDate+DateTools.h"

@interface DTTimeAgoTests : XCTestCase
@property NSDateFormatter *formatter;
@property NSDate *date0;
@property NSDate *date1;
@end

@implementation DTTimeAgoTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.formatter = [[NSDateFormatter alloc] init];
    [self.formatter setDateFormat:@"yyyy MM dd HH:mm:ss.SSS"];
    self.date0 = [self.formatter dateFromString:@"2014 11 05 18:15:12.000"];
    self.date1 = [self.formatter dateFromString:@"2014 11 07 18:15:12.000"];
    
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testBasicLongTimeAgo
{
    NSString *now = [self.date0 timeAgoSinceDate:self.date0];
    
    XCTAssert(now && now.length > 0, @"'Now' is nil or empty.");
    
    
    NSString *ago = [self.date1 timeAgoSinceDate:self.date0];
    
    XCTAssert(ago && ago.length > 0, @"Ago is nil or empty.");
}

- (void)testBasicShortTimeAgo
{
    NSString *now = [self.date0 shortTimeAgoSinceDate:self.date0];
    
    XCTAssert(now && now.length > 0, @"'Now' is nil or empty.");
    
    
    NSString *ago = [self.date1 shortTimeAgoSinceDate:self.date0];
    
    XCTAssert(ago && ago.length > 0, @"Ago is nil or empty.");
}

- (void)testLongTimeAgoLocalizationsAccessible
{
    NSString *en_local = @"Yesterday";
    NSString *ja_local = @"昨日";

    NSString *key = en_local;
    
    NSString *path = [NSBundle.mainBundle.bundlePath stringByAppendingPathComponent:@"DateTools.bundle/ja.lproj"];
    NSBundle *bundle = [NSBundle bundleWithPath:path];
    
    NSString *ja_result = NSLocalizedStringFromTableInBundle(key, @"DateTools", bundle, nil);
    
    XCTAssertEqualObjects(ja_local, ja_result, @"Could not access localizations.");
}


@end
