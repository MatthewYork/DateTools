//
//  NSDate+DateTools.h
//  DateToolsExample
//
//  Created by Matthew York on 3/19/14.
//
//

#import <Foundation/Foundation.h>

@interface NSDate (DateTools)

#pragma mark - Time Ago
+ (NSString*)timeAgoSinceDate:(NSDate*)date;
+ (NSString*)shortTimeAgoSinceDate:(NSDate*)date;
- (NSString*)timeAgoSinceNow;
-(NSString *)shortTimeAgoSinceNow;
- (NSString*)timeAgoSinceDate:(NSDate*)date;
-(NSString *)shortTimeAgoSinceDate:(NSDate *)date;

@end
