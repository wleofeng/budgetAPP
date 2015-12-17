//
//  SettingViewBudgetTableViewController.m
//  BudgetAPP
//
//  Created by Wo Jun Feng on 10/18/15.
//  Copyright © 2015 Wo Jun Feng. All rights reserved.
//

#import "SettingsViewBudgetTableViewController.h"
#import "BudgetListItem.h"
#import "DataStore.h"

@interface SettingsViewBudgetTableViewController ()

@property (nonatomic, strong) NSMutableArray *budgetList;

@end

@implementation SettingsViewBudgetTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.budgetList = [DataStore sharedDataStore].budgetListItems;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
    
}

- (IBAction)doneButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.budgetList.count;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"budgetDetailCell" forIndexPath:indexPath];
    
    BudgetListItem *listItem = self.budgetList[indexPath.row];
    cell.textLabel.text = listItem.source;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", listItem.amount];

    return cell;
}


@end
