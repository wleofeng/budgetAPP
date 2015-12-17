//
//  SummaryBudgetListTableViewController.m
//  BudgetAPP
//
//  Created by Wo Jun Feng on 10/21/15.
//  Copyright © 2015 Wo Jun Feng. All rights reserved.
//

#import "SummaryBudgetListTableViewController.h"
#import "BudgetListItem.h"
#import "DataStore.h"

@interface SummaryBudgetListTableViewController ()

@property (nonatomic, strong) NSMutableArray *budgetList;

@end

@implementation SummaryBudgetListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.budgetList = [DataStore sharedDataStore].budgetListItems;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.budgetList.count) {
        return self.budgetList.count;
    } else {
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"budgetItem" forIndexPath:indexPath];
    
    BudgetListItem *item = self.budgetList[indexPath.row];
    
    cell.textLabel.text = item.source;
    cell.detailTextLabel.text = [self convertToDollarStringWithNSDecialmalNumber:item.amount];
    
    return cell;
}

- (NSString *)convertToDollarStringWithNSDecialmalNumber:(NSDecimalNumber *)number{
    return [NSString stringWithFormat:@"$%.02f", [number floatValue]];
}


@end
