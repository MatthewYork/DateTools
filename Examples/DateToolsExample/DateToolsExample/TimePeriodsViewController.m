//
//  TimePeriodsViewController.m
//  DateToolsExample
//
//  Created by Matthew York on 3/22/14.
//
//

#import "TimePeriodsViewController.h"

@interface TimePeriodsViewController ()

@end

@implementation TimePeriodsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        // Custom initialization
        self.title = @"Time Periods";
        self.tabBarItem.title = @"Time Periods";
        self.tabBarItem.image = [UIImage imageNamed:@"Recents"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"Recents_filled"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
