//
//  FinanceManagerAppDelegate.m
//  FinanceManager
//
//  Created by IIT CCT7 on 11/30/11.
//  Copyright 2011 IIT. All rights reserved.
//

#import "FinanceManagerAppDelegate.h"
#import "Item.h"
#import "Budget.h"
#import "SwitchViewController1.h"
@implementation FinanceManagerAppDelegate

@synthesize window;
@synthesize rootController;
@synthesize items, budgetitems, nv1, nv2, nv3, sv1;

#pragma mark -
#pragma mark Application lifecycle

- (void)startupAnimationDone:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
	[splashView removeFromSuperview];
	[splashView release];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
    
	//set db name
	databaseName = @"database2.sql";
	//put together db path
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentDir = [documentPaths objectAtIndex:0];
	databasePath = [documentDir stringByAppendingPathComponent:databaseName];
	
	[self checkAndCreateDatabase];
	
	[self readItemsFromDatabase];
	[self readBudgetsFromDatabase];
	NSArray* controllers = [NSArray arrayWithObjects:sv1, nv1, nv2, nv3, nil];
	rootController.viewControllers = controllers;
    [self.window addSubview:rootController.view];
	[self.window makeKeyAndVisible];
	
	//Splashscreen animation
	splashView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 320, 480)];
	splashView.image = [UIImage imageNamed:@"Default.png"];
	[window addSubview:splashView];
	[window bringSubviewToFront:splashView];
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:2.5];
	[UIView setAnimationTransition:UIViewAnimationTransitionNone forView:window cache:YES];
	[UIView setAnimationDelegate:self]; 
	[UIView setAnimationDidStopSelector:@selector(startupAnimationDone:finished:context:)];
	splashView.alpha = 0.0;
	splashView.frame = CGRectMake(-60, -85, 440, 635);
	[UIView commitAnimations];
    
    return YES;
}

-(void) checkAndCreateDatabase {
	
	BOOL success;
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	success = [fileManager fileExistsAtPath:databasePath];
	
	if (success) {
		NSLog(@"path: %d", success);
		return;
	}
	else {
		NSString *databasePathFromApp = [[NSBundle mainBundle] pathForResource:@"database2" ofType:@"sql"];
		NSLog(@"path: %@", databasePathFromApp);
		NSLog(@"to: %@", databasePath);
		[fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
		[fileManager release];
	}
}

-(void) readItemsFromDatabase {
	
	sqlite3 *database;
	
	items = [[NSMutableArray alloc] init];
	
	if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
		NSString *sqlStatement = @"select * from Expenses";
		sqlite3_stmt *compiledStatement;
		NSLog(@"open: %s", sqlite3_errmsg(database));
		if (sqlite3_prepare_v2(database, [sqlStatement UTF8String], -1, &compiledStatement, nil) == SQLITE_OK) {
			NSLog(@"prepare: %s", sqlite3_errmsg(database));
			while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
				//reading data
				NSLog(@"stepping through: %@", [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)]);
				NSLog(@"stepping through month: %@", [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 5)]);
				NSLog(@"stepping through year: %@", [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 6)]);
				NSLog(@"stepping: %s %d", sqlite3_errmsg(database), sqlite3_errcode(database));
				int aIdent = sqlite3_column_int(compiledStatement, 0);
				NSString *aDescription = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
				NSString *aAmount = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
				NSString *aTag = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];
				NSString *aDate = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)];
				//make menu item
				Item *item = [[Item alloc] initWithId:aIdent description:aDescription amount:aAmount tag:aTag date:aDate];
				[items addObject:item];
				[item release];
			}
			NSLog(@"done stepping: %s %d", sqlite3_errmsg(database), sqlite3_errcode(database));
		}
		sqlite3_finalize(compiledStatement);
		NSLog(@"closing: %s", sqlite3_errmsg(database));
	}
	sqlite3_close(database);
	
}
-(void) readBudgetsFromDatabase {
	
	sqlite3 *database;
	
	budgetitems = [[NSMutableArray alloc] init];
	
	if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
		NSString *sqlStatement = @"select * from Budgets";
		sqlite3_stmt *compiledStatement;
		NSLog(@"open: %s", sqlite3_errmsg(database));
		if (sqlite3_prepare_v2(database, [sqlStatement UTF8String], -1, &compiledStatement, nil) == SQLITE_OK) {
			NSLog(@"prepare: %s", sqlite3_errmsg(database));
			while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
				//reading data
				NSLog(@"stepping through: %@", [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)]);
				NSLog(@"stepping: %s %d", sqlite3_errmsg(database), sqlite3_errcode(database));
				//int aIdent = sqlite3_column_int(compiledStatement, 0);
				NSString *aMonth = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
				NSString *aYear = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
				NSString *aRent= [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];
				NSString *aUtilities = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)];
				NSString *aFood = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 5)];
				NSString *aLiving = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 6)];
				NSString *aGas = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 7)];
				NSString *aOther = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 8)];
				NSLog(@"stepping123: %@", aMonth);
				
				//make menu item
				Budget *item = [[Budget alloc] initWithMonth:aMonth year:aYear rent:aRent utilities:aUtilities food:aFood living:aLiving gas:aGas other:aOther];
				[budgetitems addObject:item];
				[item release];
			}
			NSLog(@"done stepping: %s %d", sqlite3_errmsg(database), sqlite3_errcode(database));
		}
		sqlite3_finalize(compiledStatement);
		NSLog(@"closing: %s", sqlite3_errmsg(database));
	}
	sqlite3_close(database);
	
}


-(NSString*) getPath {
	return databasePath;
}

-(void) addItem:(Item *)expenses {
	[items addObject:expenses]; 
}

-(void) addBudget:(Budget *)budget {
	[budgetitems addObject:budget]; 
}
- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
	[rootController release];
    [window release];
    [super dealloc];
}


@end
