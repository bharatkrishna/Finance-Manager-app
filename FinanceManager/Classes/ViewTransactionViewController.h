//
//  ViewTransactionViewController.h
//  FinanceManager
//
//  Created by IIT CCT7 on 12/1/11.
//  Copyright 2011 IIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FinanceManagerAppDelegate.h"

@interface ViewTransactionViewController : UITableViewController {
	NSMutableArray *items;
	FinanceManagerAppDelegate *appDelegate;
}

@property(retain, nonatomic) NSMutableArray *items;

-(void) loadItemsFromDatabase:(NSString *)databasePath;

@end