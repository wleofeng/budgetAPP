//
//  DataStore.m
//  BudgetAPP
//
//  Created by Wo Jun Feng on 10/20/15.
//  Copyright © 2015 Wo Jun Feng. All rights reserved.
//

#import "DataStore.h"

@implementation DataStore


+(DataStore *)sharedDataStore
{
    static dispatch_once_t onceToken;
    static DataStore *theSharedDataStore;
    dispatch_once(&onceToken, ^{
        // we need to make a new instance of FISDataStore (once & only once)
        theSharedDataStore = [[DataStore alloc] init];
    });
    
    // and then... return it
    return theSharedDataStore;
}

-(instancetype)init
{
    self = [super init];
    if(self) {
        _budgetListItems = [[NSMutableArray alloc] init];
        _expenseListItems = [[NSMutableArray alloc] init];
    }
    
    return self;
}


@end
