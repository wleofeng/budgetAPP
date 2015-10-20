//
//  BudgetListItem.h
//  BudgetAPP
//
//  Created by Wo Jun Feng on 10/20/15.
//  Copyright © 2015 Wo Jun Feng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BudgetListItem : NSObject

@property (nonatomic, strong) NSString *source;
@property (nonatomic) NSDecimalNumber *amount;

-(instancetype)initWithSource:(NSString *)source amount:(NSDecimalNumber *)amount;

@end
