//
//  AddTransactionViewController.h
//  FinanceManager
//
//  Created by IIT CCT7 on 11/30/11.
//  Copyright 2011 IIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"

@interface AddTransactionViewController : UIViewController <UIActionSheetDelegate,UIPickerViewDelegate,UIPickerViewDataSource>{

	Item *newItem;	
	UIButton *datePickButton;
	
	UITextField *descriptionField;
	UITextField *amountField;
	UITextField *tagField;
	UITextField *dateField;
	UIButton *saveButton;
	
	UIActionSheet *actionSheet;
	NSArray *tagArray;
}

@property (nonatomic, retain) IBOutlet UITextField *dateField;
@property (nonatomic, retain) IBOutlet UIButton *datePickButton;
@property (nonatomic, retain) IBOutlet UITextField *descriptionField;
@property (nonatomic, retain) IBOutlet UITextField *amountField;
@property (nonatomic, retain) IBOutlet UITextField *tagField;
@property (nonatomic, retain) IBOutlet UIButton *saveButton;

@property (nonatomic, retain) UIActionSheet *actionSheet;

- (IBAction)callDP:(id)sender; //Bring up the date picker
- (void)removeViews:(id)object; // Action sheet date picker related method
- (void)changeDate:(UIDatePicker *)sender; // Action sheet date picker related method
- (void)dismissDatePicker:(id)sender; // Action sheet date picker related method

- (void)doneEditing:(id)sender;
- (IBAction)backgroundTap:(id)sender;

-(IBAction)saveItem;

-(IBAction)callPicker:(id)sender;
- (void) dismissActionSheet;
@end
