//
//  FinanceManagerAppDelegate.h
//  FinanceManager
//
//  Created by IIT CCT7 on 11/30/11.
//  Copyright 2011 IIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "Item.h"
#import "Budget.h"
@class SwitchViewController1;
@interface FinanceManagerAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UITabBarController *rootController;
	
	NSString *databaseName;
	NSString *databasePath;
	
	NSMutableArray *items;
	NSMutableArray *budgetitems;
	UIImageView *splashView;
	UINavigationController *nv1;
	UINavigationController *nv2;
	UINavigationController *nv3;
	SwitchViewController1 *sv1;

}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *rootController;
@property (nonatomic, retain) IBOutlet UINavigationController *nv1;
@property (nonatomic, retain) IBOutlet UINavigationController *nv2;
@property (nonatomic, retain) IBOutlet UINavigationController *nv3;
@property (nonatomic, retain) IBOutlet SwitchViewController1 *sv1;
@property (nonatomic, retain) NSMutableArray *items;
@property (nonatomic, retain) NSMutableArray *budgetitems;
-(void) addItem:(Item *)expense;
-(void) addBudget:(Budget *)budget;
-(NSString*)getPath; 
-(void) checkAndCreateDatabase;
-(void) readItemsFromDatabase;
-(void) readBudgetsFromDatabase;
@end
