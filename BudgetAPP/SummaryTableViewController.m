//
//  SummaryTableViewController.m
//  BudgetAPP
//
//  Created by Wo Jun Feng on 10/20/15.
//  Copyright © 2015 Wo Jun Feng. All rights reserved.
//

#import "SummaryTableViewController.h"
#import "BudgetListItem.h"
#import "ExpenseListItem.h"
#import "DataStore.h"

@interface SummaryTableViewController ()
@property (weak, nonatomic) IBOutlet UITableViewCell *totalAmountReceivedCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *totalAmountSpentCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *totalAmountLeftCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *totalDaysCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *totalDaysElapsedCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *totalDaysTilExhaustedCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *dailyAllowanceCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *actualDailyAmountSpentCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *allowedSpentDiffCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *allowanceWithAmountLeftCell;

@property (strong, nonatomic) NSDecimalNumber *totalAmountReceived;
@property (strong, nonatomic) NSDecimalNumber *totalAmountSpent;
@property (strong, nonatomic) NSDecimalNumber *totalAmountLeft;

@property (nonatomic) NSUInteger totalDays;
@property (nonatomic) NSUInteger totalDaysElapsed;
@property (nonatomic) NSUInteger totalDaysTilExhausted;

@property (strong, nonatomic) NSDecimalNumber *dailyAllowance;
@property (strong, nonatomic) NSDecimalNumber *actualDailyAmountSpent;
@property (strong, nonatomic) NSDecimalNumber *allowedSpentDiff;
@property (strong, nonatomic) NSDecimalNumber *allowanceWithAmountLeft;

@end

@implementation SummaryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.totalDays = 1;
    self.totalDaysElapsed = 1;
    self.totalDaysTilExhausted= 1;
       
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self loadSummary];
}

- (void)loadSummary{
    [self calculateAmountReceived];
    [self calculateAmountSpent];
    [self calculateTotalAmountLeft];
    [self calculateTotalDays];
    [self calculateTotalDaysElpased];
    [self calculateTotalDaysUntilBudgetExhausted];
    [self calculateDailyAllowance];
    [self calculateActualDailyAmountSpent];
    [self calculateAllowedVSActualDailySpending];
    [self calculateDailyAllowanceWithAmountLeft];
    
    [self displayResultToCell];
}

- (void)calculateAmountReceived{
    NSDecimalNumber* total = [[NSDecimalNumber alloc] initWithString:[NSString stringWithFormat:@"%f", 0.0]];
    
    for (BudgetListItem *item in [DataStore sharedDataStore].budgetListItems) {
        total = [total decimalNumberByAdding:item.amount];
    }
    
    self.totalAmountReceived = total;
}

- (void)calculateAmountSpent{
    NSDecimalNumber* total = [[NSDecimalNumber alloc] initWithString:[NSString stringWithFormat:@"%f", 0.0]];
    
    for (ExpenseListItem *item in [DataStore sharedDataStore].expenseListItems) {
        total = [total decimalNumberByAdding:item.amount];
    }
    
    self.totalAmountSpent = total;
}

- (void)calculateTotalAmountLeft{
    self.totalAmountLeft = [self.totalAmountReceived decimalNumberBySubtracting:self.totalAmountSpent];
}

- (void)calculateTotalDays{
    NSDate *startDate = [DataStore sharedDataStore].startDate;
    NSDate *endDate = [DataStore sharedDataStore].endDate;

    NSTimeInterval secondsBetween = [endDate timeIntervalSinceDate:startDate];
    
    int numberOfDays = secondsBetween / 86400;
    
    self.totalDays = (NSUInteger)numberOfDays;
    
}

- (void)calculateTotalDaysElpased{
    NSDate *startDate = [DataStore sharedDataStore].startDate;
    NSDate *todayDate = [NSDate date];
    
    NSTimeInterval secondsBetween = [todayDate timeIntervalSinceDate:startDate];
    
    int numberOfDays = secondsBetween / 86400;
    
    self.totalDaysElapsed = (NSUInteger)numberOfDays;
}

- (void)calculateTotalDaysUntilBudgetExhausted{
    self.totalDaysTilExhausted = self.totalDays - self.totalDaysElapsed;
}

- (void)calculateDailyAllowance{
    if (self.totalDays) {
        NSDecimalNumber* totalDays = [[NSDecimalNumber alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)self.totalDays]];
        self.dailyAllowance = [self.totalAmountReceived decimalNumberByDividingBy:totalDays];
    } else {
        self.dailyAllowance = self.totalAmountReceived;
    }
}

- (void)calculateActualDailyAmountSpent{
    if (self.totalDaysElapsed) {
        NSDecimalNumber* totalDaysElapased = [[NSDecimalNumber alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)self.totalDaysElapsed]];
        self.actualDailyAmountSpent = [self.totalAmountSpent decimalNumberByDividingBy:totalDaysElapased];
    } else {
        self.actualDailyAmountSpent = self.totalAmountSpent;
    }
}

- (void)calculateAllowedVSActualDailySpending{
    self.allowedSpentDiff = [self.dailyAllowance decimalNumberBySubtracting:self.actualDailyAmountSpent];
}

- (void)calculateDailyAllowanceWithAmountLeft{
    if (self.totalDaysTilExhausted) {
        NSDecimalNumber* totalDaysTilExhausted = [[NSDecimalNumber alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)self.totalDaysTilExhausted]];
        self.allowanceWithAmountLeft = [self.totalAmountLeft decimalNumberByDividingBy:totalDaysTilExhausted];
    } else {
        self.allowanceWithAmountLeft = self.totalAmountLeft;
    }
}

- (void)displayResultToCell{
    self.totalAmountReceivedCell.detailTextLabel.text = [self convertToDollarStringWithNSDecialmalNumber:self.totalAmountReceived];
    self.totalAmountSpentCell.detailTextLabel.text = [self convertToDollarStringWithNSDecialmalNumber:self.totalAmountSpent];
    self.totalAmountLeftCell.detailTextLabel.text = [self convertToDollarStringWithNSDecialmalNumber:self.totalAmountLeft];
    self.totalDaysCell.detailTextLabel.text = [NSString stringWithFormat:@"%lu", self.totalDays];
    self.totalDaysElapsedCell.detailTextLabel.text = [NSString stringWithFormat:@"%lu", self.totalDaysElapsed];
    self.totalDaysTilExhaustedCell.detailTextLabel.text = [NSString stringWithFormat:@"%lu", self.totalDaysTilExhausted];
    self.dailyAllowanceCell.detailTextLabel.text = [self convertToDollarStringWithNSDecialmalNumber:self.dailyAllowance];
    self.actualDailyAmountSpentCell.detailTextLabel.text = [self convertToDollarStringWithNSDecialmalNumber:self.actualDailyAmountSpent];
    self.allowedSpentDiffCell.detailTextLabel.text = [self convertToDollarStringWithNSDecialmalNumber:self.allowedSpentDiff];
    self.allowanceWithAmountLeftCell.detailTextLabel.text = [self convertToDollarStringWithNSDecialmalNumber:self.allowanceWithAmountLeft];
}

- (NSString *)convertToDollarStringWithNSDecialmalNumber:(NSDecimalNumber *)number{
    return [NSString stringWithFormat:@"$%.02f", [number floatValue]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source




@end
