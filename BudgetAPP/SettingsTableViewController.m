//
//  SettingsTableViewController.m
//  BudgetAPP
//
//  Created by Wo Jun Feng on 10/15/15.
//  Copyright © 2015 Wo Jun Feng. All rights reserved.
//

#import "SettingsTableViewController.h"

@interface SettingsTableViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *startDatePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *endDatePicker;

@end

@implementation SettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //set date picker text color to white
    [self setWhiteColorForDatePicker:self.startDatePicker];
//    [self setWhiteColorForDatePicker:self.endDatePicker];
    
//    [self.startDatePicker setBackgroundColor:[UIColor clearColor]];
//    [self.startDatePicker setTintColor:[UIColor clearColor]];


    //set the navigation controller tile color to FIS blue
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor colorWithRed:0.3216 green:0.749 blue:1.0 alpha:1.0]}];
    
}


- (void)setWhiteColorForDatePicker:(UIDatePicker *)datePicker{
    [datePicker setValue:[UIColor whiteColor] forKeyPath:@"textColor"];
    SEL selector = NSSelectorFromString( @"setHighlightsToday:" );
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature :
                                [UIDatePicker
                                 instanceMethodSignatureForSelector:selector]];
    BOOL no = NO;
    [invocation setSelector:selector];
    [invocation setArgument:&no atIndex:2];
    [invocation invokeWithTarget:datePicker];
}



@end
