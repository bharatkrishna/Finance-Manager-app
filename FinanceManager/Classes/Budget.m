//
//  Budget.m
//  FinanceManager
//
//  Created by Snow Leopard User on 03/12/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Budget.h"
#import "FinanceManagerAppDelegate.h"

@implementation Budget
@synthesize bid, month, year, rent, utilities, food, living, gas, other;
-(id) initWithId:(int)i month:(NSString *)m year:(NSString *)y rent:(NSString * )r utilities:(NSString * )u 
			food:(NSString * )f living:(NSString * )l gas:(NSString * )g other:(NSString * )o
{
	self.bid=i;
	self.month=m;
	self.year=y;
	self.rent=r;
	self.utilities=u;
	self.food=f;
	self.living=l;
	self.gas=g;
	self.other=o;
	return self;
}
-(id) initWithMonth:(NSString *)m year:(NSString *)y rent:(NSString * )r utilities:(NSString * )u 
			   food:(NSString * )f living:(NSString * )l gas:(NSString * )g other:(NSString * )o
{
	self.month=m;
	self.year=y;
	self.rent=r;
	self.utilities=u;
	self.food=f;
	self.living=l;
	self.gas=g;
	self.other=o;
	return self;
}
-(void) addBudgetToDatabase
{
	sqlite3 *database;
	NSString *databasePath;
	NSLog(@"getting db path");
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentDir = [documentPaths objectAtIndex:0];
	databasePath = [documentDir stringByAppendingPathComponent:@"database1.sql"];
	NSLog(@"opening database: %@", databasePath);
	if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
		NSLog(@"error msg11111: %s", sqlite3_errmsg(database));

		NSString *insertStatement = [NSString stringWithFormat:@"INSERT INTO Budgets (month, year, rent, utilities, food, living, gas, other) VALUES ('%@','%@','%@','%@','%@','%@','%@','%@')", 
									 self.month, self.year, self.rent, self.utilities, self.food, self.living, self.gas, self.other];
		sqlite3_stmt *compiledStatement;
		if (sqlite3_prepare_v2(database, [insertStatement UTF8String], -1, &compiledStatement, nil) == SQLITE_OK) {
			
			int result = sqlite3_step(compiledStatement);
			NSLog(@"result code11111: %d", result);
		}
		NSLog(@"error_msg: %s", sqlite3_errmsg(database));
		sqlite3_finalize(compiledStatement);
	} else {
		NSLog(@"error: %s", sqlite3_errmsg(database));
	}
	NSLog(@"closing database");
	sqlite3_close(database);
}
-(void) removeBudgetFromDatabase {
	sqlite3 *database;
	NSString *databasePath;
	NSLog(@"getting db path");
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentDir = [documentPaths objectAtIndex:0];
	databasePath = [documentDir stringByAppendingPathComponent:@"database1.sql"];
	NSLog(@"opening database: %@", databasePath);
	if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
		NSLog(@"error msg: %s", sqlite3_errmsg(database));
		NSString *insertStatement = [NSString stringWithFormat:@"DELETE FROM Budgets WHERE month='%@' AND year ='%@'", self.month, self.year];
		sqlite3_stmt *compiledStatement;
		if (sqlite3_prepare_v2(database, [insertStatement UTF8String], -1, &compiledStatement, nil) == SQLITE_OK) {
			int result = sqlite3_step(compiledStatement);
			NSLog(@"result code: %d", result);
		}
		NSLog(@"error_msg: %s", sqlite3_errmsg(database));
		sqlite3_finalize(compiledStatement);
	} else {
		NSLog(@"error: %s", sqlite3_errmsg(database));
	}
	NSLog(@"closing database");
	sqlite3_close(database);
}
@end
