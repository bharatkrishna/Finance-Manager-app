//
//  TransactionSummaryViewController.h
//  FinanceManager
//
//  Created by IIT CCT7 on 12/9/11.
//  Copyright 2011 IIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FinanceManagerAppDelegate.h"

@interface TransactionSummaryViewController : UITableViewController {
	//NSMutableArray *transactionItems;
	FinanceManagerAppDelegate *appDelegate;
	NSArray *montharray;
	NSString *yearString;
}

//@property(retain, nonatomic)NSMutableArray *transactionItems;
@property(retain, nonatomic)NSArray *montharray;
@property(retain, nonatomic)NSString *yearString;

//-(void) loadItemsFromDatabase:(NSString *)databasePath;

@end
