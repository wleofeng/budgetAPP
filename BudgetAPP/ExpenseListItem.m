//
//  ExpenseListItem.m
//  BudgetAPP
//
//  Created by Wo Jun Feng on 10/20/15.
//  Copyright © 2015 Wo Jun Feng. All rights reserved.
//

#import "ExpenseListItem.h"

@implementation ExpenseListItem

-(instancetype)initWithSource:(NSString *)source amount:(NSDecimalNumber *)amount{
    self = [super init];
    if(self) {
        _source = source;
        _amount = amount;
    }
    return self;
}

@end
