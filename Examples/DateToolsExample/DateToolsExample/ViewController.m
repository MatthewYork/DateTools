//
//  ViewController.m
//  DateToolsExample
//
//  Created by Matthew York on 3/19/14.
//
//

#import "ViewController.h"
#import "NSDate+DateTools.h"
#import "DTTimePeriodCollection.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    DTTimePeriodCollection *collection = [DTTimePeriodCollection collection];
    [collection insertTimePeriod:[DTTimePeriod timePeriodWithAllTime] atIndex:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
