//
//  SecondViewController.m
//  BudgetAPP
//
//  Created by Wo Jun Feng on 10/14/15.
//  Copyright © 2015 Wo Jun Feng. All rights reserved.
//

#import "ExpensesViewController.h"
#import "ExpenseListItem.h"
#import "DataStore.h"

@interface ExpensesViewController ()
@property (weak, nonatomic) IBOutlet UITextView *amountTextView;
@property (weak, nonatomic) IBOutlet UIButton *number1Button;
@property (weak, nonatomic) IBOutlet UIButton *number2Button;
@property (weak, nonatomic) IBOutlet UIButton *number3Button;
@property (weak, nonatomic) IBOutlet UIButton *number4Button;
@property (weak, nonatomic) IBOutlet UIButton *number5Button;
@property (weak, nonatomic) IBOutlet UIButton *number6Button;
@property (weak, nonatomic) IBOutlet UIButton *number7Button;
@property (weak, nonatomic) IBOutlet UIButton *number8Button;
@property (weak, nonatomic) IBOutlet UIButton *number9Button;
@property (weak, nonatomic) IBOutlet UIButton *dotButton;
@property (weak, nonatomic) IBOutlet UIButton *number0Button;
@property (weak, nonatomic) IBOutlet UIButton *xButton;
@property (weak, nonatomic) IBOutlet UITextField *otherTextField;

@property (nonatomic, strong)NSString *expenseSource;
@property (nonatomic, strong)NSString *amount;

@property (nonatomic, strong) NSMutableArray *expenseList; //store expenseListItem object

@end

@implementation ExpensesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.otherTextField.hidden = YES;
    
    //inititializing string
    self.amount = @"";
    
    self.expenseList = [DataStore sharedDataStore].expenseListItems;
}

- (IBAction)number1Tapped:(id)sender {
    self.amount = [self.amount stringByAppendingString:@"1"];
    self.amountTextView.text = self.amount;
}

- (IBAction)number2Tapped:(id)sender {
    self.amount = [self.amount stringByAppendingString:@"2"];
    self.amountTextView.text = self.amount;
}

- (IBAction)number3tapped:(id)sender {
    self.amount = [self.amount stringByAppendingString:@"3"];
    self.amountTextView.text = self.amount;
}

- (IBAction)number4tapped:(id)sender {
    self.amount = [self.amount stringByAppendingString:@"4"];
    self.amountTextView.text = self.amount;
}

- (IBAction)number5tapped:(id)sender {
    self.amount = [self.amount stringByAppendingString:@"5"];
    self.amountTextView.text = self.amount;
}

- (IBAction)number6tapped:(id)sender {
    self.amount = [self.amount stringByAppendingString:@"6"];
    self.amountTextView.text = self.amount;
}

- (IBAction)number7tapped:(id)sender {
    self.amount = [self.amount stringByAppendingString:@"7"];
    self.amountTextView.text = self.amount;
}

- (IBAction)number8tapped:(id)sender {
    self.amount = [self.amount stringByAppendingString:@"8"];
    self.amountTextView.text = self.amount;
}

- (IBAction)number9tapped:(id)sender {
    self.amount = [self.amount stringByAppendingString:@"9"];
    self.amountTextView.text = self.amount;
}

- (IBAction)number0Tapped:(id)sender {
    self.amount = [self.amount stringByAppendingString:@"0"];
    self.amountTextView.text = self.amount;
}

- (IBAction)dotTapped:(id)sender {
    self.amount = [self.amount stringByAppendingString:@"."];
    self.amountTextView.text = self.amount;
}

- (IBAction)deleteButtonTapped:(id)sender {
    if ([self.amount length] > 0) {
        self.amount = [self.amount substringToIndex:[self.amount length] - 1];
    } else {
        //no characters to delete... attempting to do so will result in a crash
    }
    
    self.amountTextView.text = self.amount;
}

- (IBAction)foodButtonTapped:(id)sender {
    self.expenseSource = @"Food";
}

- (IBAction)clothesButtonTapped:(id)sender {
    self.expenseSource = @"Clothes";
}

- (IBAction)sportButtonTapped:(id)sender {
    self.expenseSource = @"Sport";
}

- (IBAction)fuelButtonTapped:(id)sender {
    self.expenseSource = @"Fuel";
}

- (IBAction)houseButtonTapped:(id)sender {
    self.expenseSource = @"House";
}

- (IBAction)otherButtonTapped:(id)sender {
    self.otherTextField.hidden = NO;
    self.otherTextField.placeholder = @"Enter other source";
    
    // Add a "textFieldDidChange" notification method to the text field control.
    [self.otherTextField addTarget:self
                            action:@selector(otherTextFieldDidChange:)
                  forControlEvents:UIControlEventEditingChanged];
}

- (void)otherTextFieldDidChange:(NSString *)text{
    self.expenseSource = self.otherTextField.text;
}

- (IBAction)enterButtonTapped:(id)sender {
    // save to the expense list object
    
    NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:self.amount];
    ExpenseListItem *newExpenseItem = [[ExpenseListItem alloc]initWithSource:self.expenseSource amount:amount];
    [self.expenseList addObject: newExpenseItem];
    
    self.amountTextView.text = @"";
    self.otherTextField.text = @"";
    self.amount = @"";
    self.otherTextField.hidden = YES;
}

@end
