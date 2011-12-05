//
//  Item.m
//  FinanceManager
//
//  Created by IIT CCT7 on 12/1/11.
//  Copyright 2011 IIT. All rights reserved.
//

#import "Item.h"
#import "FinanceManagerAppDelegate.h"

@implementation Item
@synthesize ident, description, amount, tag, date;

-(id) initWithId:(int)i description:(NSString *)d amount:(NSString *)a tag:(NSString * )t date:(NSString * )da
{
	self.ident = i;
	self.description = d;
	self.amount = a;
	self.tag = t;
	self.date = da;
	
	return self;
}

-(id) initWithDescription:(NSString *)d amount:(NSString *)a tag:(NSString * )t date:(NSString * )da
{
	self.description = d;
	self.amount = a;
	self.tag = t;
	self.date = da;
	
	return self;
}

-(void) addItemToDatabase {
	sqlite3 *database;
	NSString *databasePath;
	NSLog(@"getting db path");
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentDir = [documentPaths objectAtIndex:0];
	databasePath = [documentDir stringByAppendingPathComponent:@"database1.sql"];
	NSLog(@"opening database: %@", databasePath);
	if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
		NSLog(@"error msg: %s", sqlite3_errmsg(database));
		NSLog(@"%@, %@, %@,%@", self.description, self.amount, self.tag, self.date);
		NSString *insertStatement = [NSString stringWithFormat:@"INSERT INTO Expenses (description, amount, tag, date) VALUES ('%@','%@','%@','%@')", self.description, self.amount, self.tag, self.date];
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

-(void) removeItemFromDatabase {
	sqlite3 *database;
	NSString *databasePath;
	NSLog(@"getting db path");
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentDir = [documentPaths objectAtIndex:0];
	databasePath = [documentDir stringByAppendingPathComponent:@"database1.sql"];
	NSLog(@"opening database: %@", databasePath);
	if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
		NSLog(@"error msg: %s", sqlite3_errmsg(database));
		NSString *insertStatement = [NSString stringWithFormat:@"DELETE FROM Expenses WHERE description='%@'", self.description];
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
