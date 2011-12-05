//
//  SetBudgetViewController.h
//  FinanceManager
//
//  Created by IIT CCT7 on 11/30/11.
//  Copyright 2011 IIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Budget.h"


@interface SetBudgetViewController : UIViewController<UIActionSheetDelegate,UIPickerViewDelegate,UIPickerViewDataSource> {

	Budget *newBudget;
	UITextField *monthField;
	UITextField *yearField;
    UITextField *rentField;
	UITextField *livingField;
	UITextField *utilityField;
	UITextField *gasField;
	UITextField *foodField;
	UITextField *otherField;
	NSArray *monthArray;
	NSArray *yearArray;
	UIActionSheet *actionSheet;
}
@property (nonatomic, retain) IBOutlet UITextField *monthField;
@property (nonatomic, retain) IBOutlet UITextField *yearField;
@property (nonatomic, retain) IBOutlet UITextField *rentField;
@property (nonatomic, retain) IBOutlet UITextField *livingField;
@property (nonatomic, retain) IBOutlet UITextField *utilityField;
@property (nonatomic, retain) IBOutlet UITextField *gasField;
@property (nonatomic, retain) IBOutlet UITextField *foodField;
@property (nonatomic, retain) IBOutlet UITextField *otherField;

@property (nonatomic, retain) UIActionSheet *actionSheet;



- (void)doneEditing:(id)sender;
- (IBAction)backgroundTap:(id)sender;

-(IBAction)saveBudget;
-(IBAction)callPicker:(id)sender;
- (void) dismissActionSheet;

@end
