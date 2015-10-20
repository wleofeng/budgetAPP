//
//  SettingsAddNewBudgetViewController.m
//  BudgetAPP
//
//  Created by Wo Jun Feng on 10/20/15.
//  Copyright © 2015 Wo Jun Feng. All rights reserved.
//

#import "SettingsAddNewBudgetViewController.h"
#import "BudgetListItem.h"
#import "DataStore.h"

@interface SettingsAddNewBudgetViewController ()
@property (weak, nonatomic) IBOutlet UITextField *budgetSourceTextField;
@property (weak, nonatomic) IBOutlet UITextField *budgetAmountTextField;

@end

@implementation SettingsAddNewBudgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)doneButtonTapped:(id)sender {
    NSString *source = self.budgetSourceTextField.text;
    NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:self.budgetAmountTextField.text];
    
    BudgetListItem *newItem = [[BudgetListItem alloc]initWithSource:source amount:amount];
    DataStore *dataStore = [DataStore sharedDataStore];
    [dataStore.budgetListItems addObject:newItem];

    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
