//
//  DataStore.h
//  BudgetAPP
//
//  Created by Wo Jun Feng on 10/20/15.
//  Copyright © 2015 Wo Jun Feng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataStore : NSObject

+(DataStore *)sharedDataStore;

@property (nonatomic, strong) NSMutableArray *budgetListItems;
@property (nonatomic, strong) NSMutableArray *expenseListItems;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;

@end
