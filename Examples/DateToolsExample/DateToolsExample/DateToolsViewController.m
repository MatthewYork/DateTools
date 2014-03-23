//
//  DateToolsViewController.m
//  DateToolsExample
//
//  Created by Matthew York on 3/22/14.
//
//

#import "DateToolsViewController.h"

@interface DateToolsViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *MasterScrollView;

@end

@implementation DateToolsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"NSDate+DateTools";
        self.tabBarItem.title = @"NSDate+DateTools";
        self.tabBarItem.image = [UIImage imageNamed:@"Calendar"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"Calendar_filled"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self createViews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createViews{
    
}

@end
