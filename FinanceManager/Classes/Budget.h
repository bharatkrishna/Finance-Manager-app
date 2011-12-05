//
//  Budget.h
//  FinanceManager
//
//  Created by Snow Leopard User on 03/12/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface Budget : NSObject {
	int bid;
	NSString *month;
	NSString *year;
	NSString *rent;
	NSString *utilities;
	NSString *food;
	NSString *living;
	NSString *gas;
	NSString *other;
}

@property (nonatomic) int bid;
@property (nonatomic, retain) NSString *month;
@property (nonatomic, retain) NSString *year;
@property (nonatomic, retain) NSString *rent;
@property (nonatomic, retain) NSString *utilities;
@property (nonatomic, retain) NSString *food;
@property (nonatomic, retain) NSString *living;
@property (nonatomic, retain) NSString *gas;
@property (nonatomic, retain) NSString *other;

-(id) initWithId:(int)i month:(NSString *)m year:(NSString *)y rent:(NSString * )r utilities:(NSString * )u
	   food:(NSString * )f living:(NSString * )l gas:(NSString * )g other:(NSString * )o ;
-(id) initWithMonth:(NSString *)m year:(NSString *)y rent:(NSString * )r utilities:(NSString * )u 
			   food:(NSString * )f living:(NSString * )l gas:(NSString * )g other:(NSString * )o ;
-(void) addBudgetToDatabase;
-(void) removeBudgetFromDatabase;
@end
