//
//  Item.h
//  FinanceManager
//
//  Created by IIT CCT7 on 12/1/11.
//  Copyright 2011 IIT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
//#import "StudentRecordsAppDelegate.h"

@interface Item : NSObject {
	
	int ident;
	NSString *description;
	NSString *amount;
	NSString *tag;
	NSString *date;
}

@property (nonatomic) int ident;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSString *amount;
@property (nonatomic, retain) NSString *tag;
@property (nonatomic, retain) NSString *date;

-(id) initWithId:(int)i description:(NSString *)d amount:(NSString *)a tag:(NSString * )t date:(NSString * )da;
-(id) initWithDescription:(NSString *)d amount:(NSString *)a tag:(NSString * )t date:(NSString * )da;
-(void) addItemToDatabase;
-(void) removeItemFromDatabase;

@end
