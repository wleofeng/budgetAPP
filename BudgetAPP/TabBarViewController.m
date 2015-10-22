//
//  TabBarViewController.m
//  BudgetAPP
//
//  Created by Wo Jun Feng on 10/21/15.
//  Copyright © 2015 Wo Jun Feng. All rights reserved.
//

#import "TabBarViewController.h"
#import "SettingsViewController.h"
#import "ExpensesViewController.h"
#import "SummaryTableViewController.h"
#import  "ionicons.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    for (UIViewController *viewController in self.viewControllers) {
        if ([viewController isKindOfClass:(SettingsViewController.class)]) {
            UIImage *icon = [IonIcons imageWithIcon:ion_ios_gear
                                              iconColor:[UIColor colorWithRed:0.3216 green:0.749 blue:1.0 alpha:1.0]
                                               iconSize:37.0f
                                              imageSize:CGSizeMake(90.0f, 90.0f)];
            UITabBarItem *tabIcon = [[UITabBarItem alloc] initWithTitle:@"Settings" image:icon tag:0];
            viewController.tabBarItem = tabIcon;
            
        } else if ([viewController isKindOfClass:(ExpensesViewController.class)]){
            UIImage *icon = [IonIcons imageWithIcon:ion_card
                                          iconColor:[UIColor colorWithRed:0.3216 green:0.749 blue:1.0 alpha:1.0]
                                           iconSize:37.0f
                                          imageSize:CGSizeMake(90.0f, 90.0f)];
            UITabBarItem *tabIcon = [[UITabBarItem alloc] initWithTitle:@"Expenses" image:icon tag:0];
            viewController.tabBarItem = tabIcon;
        } else {
            UIImage *icon = [IonIcons imageWithIcon:ion_ios_paper
                                          iconColor:[UIColor colorWithRed:0.3216 green:0.749 blue:1.0 alpha:1.0]
                                           iconSize:37.0f
                                          imageSize:CGSizeMake(90.0f, 90.0f)];
            UITabBarItem *tabIcon = [[UITabBarItem alloc] initWithTitle:@"Summary" image:icon tag:0];
            viewController.tabBarItem = tabIcon;
        }
    }
    
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
