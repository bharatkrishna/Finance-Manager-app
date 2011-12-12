//
//  SwitchViewController1.h
//  FinanceManager
//
//  Created by IIT CCT7 on 11/30/11.
//  Copyright 2011 IIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddTransactionViewController;
@class SetBudgetViewController;

@interface SwitchViewController1 : UIViewController {
	AddTransactionViewController *atvc;
	SetBudgetViewController *sbvc;	
	UIBarButtonItem *bar;
}
	
@property (retain, nonatomic) AddTransactionViewController *atvc;
@property (retain, nonatomic) SetBudgetViewController *sbvc;	
@property (nonatomic, retain) IBOutlet 	UIBarButtonItem *bar;
	
- (IBAction)switchViews:(id)sender;

@end
