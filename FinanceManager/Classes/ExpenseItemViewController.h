//
//  ExpenseItemViewController.h
//  FinanceManager
//
//  Created by IIT CCT7 on 12/10/11.
//  Copyright 2011 IIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"
#import <sqlite3.h>
#import "PieClass.h"

@interface ExpenseItemViewController : UIViewController {
	Item *expenseItem;
	//NSString *month;
}

@property (nonatomic, retain) Item *expenseItem;

//-(id) getMonth:(NSString *)m;
//-(id) initWithDescription:(NSString *)d amount:(NSString *)a tag:(NSString * )t date:(NSString * )da;

@end
