//
//  SummaryExpenseListTableViewController.m
//  BudgetAPP
//
//  Created by Wo Jun Feng on 10/21/15.
//  Copyright © 2015 Wo Jun Feng. All rights reserved.
//

#import "SummaryExpenseListTableViewController.h"
#import "ExpenseListItem.h"
#import "DataStore.h"

@interface SummaryExpenseListTableViewController ()

@property (nonatomic, strong) NSMutableArray *expenseList;

@end

@implementation SummaryExpenseListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.expenseList = [DataStore sharedDataStore].expenseListItems;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.expenseList.count) {
        return self.expenseList.count;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"expenseItem" forIndexPath:indexPath];
    
    ExpenseListItem *item = self.expenseList[indexPath.row];
    
    cell.textLabel.text = item.source;
    cell.detailTextLabel.text = [self convertToDollarStringWithNSDecialmalNumber:item.amount];
    
    return cell;
}

- (NSString *)convertToDollarStringWithNSDecialmalNumber:(NSDecimalNumber *)number{
    return [NSString stringWithFormat:@"$%.02f", [number floatValue]];
}


@end
