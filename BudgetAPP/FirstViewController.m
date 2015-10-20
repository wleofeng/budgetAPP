//
//  FirstViewController.m
//  BudgetAPP
//
//  Created by Wo Jun Feng on 10/14/15.
//  Copyright © 2015 Wo Jun Feng. All rights reserved.
//

#import "FirstViewController.h"
#import "BudgetListItem.h"
#import "DataStore.h"

@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *startDatePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *endDatePicker;
//@property (weak, nonatomic) IBOutlet UILabel *mainBudgetTextView;
//@property (weak, nonatomic) IBOutlet UILabel *sideBudgetTextView;
@property (weak, nonatomic) IBOutlet UILabel *sideBudgetAmountTextView;
@property (weak, nonatomic) IBOutlet UILabel *mainBudgetAmountTextView;

@property (nonatomic, strong) NSMutableArray *budgetList;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //set date picker text color to white
    [self setWhiteColorForDatePicker:self.startDatePicker];
    [self setWhiteColorForDatePicker:self.endDatePicker];
    
    //set the navigation controller tile color to FIS blue
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor colorWithRed:0.3216 green:0.749 blue:1.0 alpha:1.0]}];

    
    //display total budget
    self.budgetList = [DataStore sharedDataStore].budgetListItems;

//    self.sideBudgetAmountTextView.text = @"2100012.80";
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    NSDecimalNumber* total = [[NSDecimalNumber alloc] initWithString:[NSString stringWithFormat:@"%f", 0.0]];

    for (BudgetListItem *item in self.budgetList) {
        total = [total decimalNumberByAdding:item.amount];
    }
    
    self.mainBudgetAmountTextView.text = [total stringValue];
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
