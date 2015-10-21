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

@property (strong, nonatomic) NSDecimalNumber *totalDays;
@property (strong, nonatomic) NSDecimalNumber *totalDaysElapsed;
@property (strong, nonatomic) NSDecimalNumber *totalDaysTilExhausted;

@property (strong, nonatomic) NSDecimalNumber *dailyAllowance;
@property (strong, nonatomic) NSDecimalNumber *actualDailyAmountSpent;
@property (strong, nonatomic) NSDecimalNumber *allowedSpentDiff;
@property (strong, nonatomic) NSDecimalNumber *allowanceWithAmountLeft;

@end

@implementation SummaryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
//    self.totalDays = [DataStore sharedDataStore].startDate;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterLongStyle];
    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    
//    NSDate *date = [DataStore sharedDataStore].startDate;
    NSString *date = [formatter stringFromDate:[DataStore sharedDataStore].startDate];
//    - [DataStore sharedDataStore].endDate;
}

- (void)displayResultToCell{
    self.totalAmountReceivedCell.detailTextLabel.text = [self convertToDollarStringWithNSDecialmalNumber:self.totalAmountReceived];
    self.totalAmountSpentCell.detailTextLabel.text = [self convertToDollarStringWithNSDecialmalNumber:self.totalAmountSpent];
    self.totalAmountLeftCell.detailTextLabel.text = [self convertToDollarStringWithNSDecialmalNumber:self.totalAmountLeft];
    self.totalDaysCell.detailTextLabel.text = [self convertToDollarStringWithNSDecialmalNumber:self.totalDays];
    self.totalDaysElapsedCell.detailTextLabel.text = [self convertToDollarStringWithNSDecialmalNumber:self.totalDaysElapsed];
    self.totalDaysTilExhaustedCell.detailTextLabel.text = [self convertToDollarStringWithNSDecialmalNumber:self.totalDaysTilExhausted];
    self.dailyAllowanceCell.detailTextLabel.text = [self convertToDollarStringWithNSDecialmalNumber:self.dailyAllowance];
    self.actualDailyAmountSpentCell.detailTextLabel.text = [self convertToDollarStringWithNSDecialmalNumber:self.actualDailyAmountSpent];
    self.allowedSpentDiffCell.detailTextLabel.text = [self convertToDollarStringWithNSDecialmalNumber:self.allowedSpentDiff];
    self.allowanceWithAmountLeftCell.detailTextLabel.text = [self convertToDollarStringWithNSDecialmalNumber:self.allowanceWithAmountLeft];
}

- (NSString *)convertToDollarStringWithNSDecialmalNumber:(NSDecimalNumber *)number{
    return [NSString stringWithFormat:@"$%@", [number stringValue]];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 1;
//}
//
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TotalAmountReceived" forIndexPath:indexPath];
//    
//    cell.detailTextLabel.text = @"100";
//    
//    return cell;
//}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
