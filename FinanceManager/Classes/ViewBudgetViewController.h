//
//  ViewBudgetViewController.h
//  FinanceManager
//
//  Created by Snow Leopard User on 04/12/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "FinanceManagerAppDelegate.h"


@interface ViewBudgetViewController : UITableViewController {
	NSMutableArray *budgetItems;
	FinanceManagerAppDelegate *appDelegate;
}

@property(retain, nonatomic)NSMutableArray *budgetItems;

-(void) loadItemsFromDatabase:(NSString *)databasePath;

@end