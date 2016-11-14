//
//  ViewController.m
//  Objective-C
//
//  Created by Andrew Breckenridge on 11/14/16.
//  Copyright © 2016 DateTools. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //Time ago test
    NSLog(@"10 months Ago: %@", [[NSDate date] dateBySubtractingMonths:10].timeAgoSinceNow);
    NSLog(@"8 weeks Ago: %@", [[NSDate date] dateBySubtractingWeeks:8].timeAgoSinceNow);
    NSLog(@"3 days Ago: %@", [[NSDate date] dateBySubtractingDays:3].timeAgoSinceNow);
    NSLog(@"2 hours Ago: %@", [[NSDate date] dateBySubtractingHours:2].timeAgoSinceNow);
    NSLog(@"5 minutes Ago: %@", [[NSDate date] dateBySubtractingMinutes:5].timeAgoSinceNow);
    NSLog(@"1 second Ago: %@", [[NSDate date] dateBySubtractingSeconds:1].timeAgoSinceNow);
    NSLog(@"now Ago: %@", [NSDate date].timeAgoSinceNow);

    //Short time ago test
    NSLog(@"10 months Ago: %@", [[NSDate date] dateBySubtractingMonths:10].shortTimeAgoSinceNow);
    NSLog(@"8 weeks Ago: %@", [[NSDate date] dateBySubtractingWeeks:8].shortTimeAgoSinceNow);
    NSLog(@"3 days Ago: %@", [[NSDate date] dateBySubtractingDays:3].shortTimeAgoSinceNow);
    NSLog(@"2 hours Ago: %@", [[NSDate date] dateBySubtractingHours:2].shortTimeAgoSinceNow);
    NSLog(@"5 minutes Ago: %@", [[NSDate date] dateBySubtractingMinutes:5].shortTimeAgoSinceNow);
    NSLog(@"1 second Ago: %@", [[NSDate date] dateBySubtractingSeconds:1].shortTimeAgoSinceNow);
    NSLog(@"now Ago: %@", [NSDate date].timeAgoSinceNow);

    //Test formatters
    NSString *dateStringFormatTest = [[NSDate date] formattedDateWithFormat:@"dd MMM, yyyy"];
    NSString *dateStringStyleTest = [[NSDate date] formattedDateWithStyle:NSDateFormatterLongStyle timeZone:[NSTimeZone localTimeZone] locale:[NSLocale currentLocale]];
    NSString *dateStringStyleTest2 = [[NSDate date] formattedDateWithStyle:NSDateFormatterShortStyle timeZone:[NSTimeZone localTimeZone] locale:[NSLocale currentLocale]];
    NSLog(@"%@", dateStringFormatTest);
    NSLog(@"%@", dateStringStyleTest);
    NSLog(@"%@", dateStringStyleTest2);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
