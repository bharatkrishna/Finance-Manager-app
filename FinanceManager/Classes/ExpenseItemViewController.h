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
	NSMutableArray *expenseItem;
	NSString *monthString;
	NSString *yearString;
	UILabel *yearLabel;
	UILabel *monthLabel;
	UILabel *rentLabel;
	UILabel *foodLabel;
	UILabel *livingLabel;
	UILabel *utilitiesLabel;
	UILabel *gasLabel;
	UILabel *otherLabel;
}


@property (nonatomic, retain) IBOutlet UILabel *yearLabel;
@property (nonatomic, retain) IBOutlet UILabel *monthLabel;
@property (nonatomic, retain) IBOutlet UILabel *rentLabel;
@property (nonatomic, retain) IBOutlet UILabel *foodLabel;
@property (nonatomic, retain) IBOutlet UILabel *livingLabel;
@property (nonatomic, retain) IBOutlet UILabel *utilitiesLabel;
@property (nonatomic, retain) IBOutlet UILabel *gasLabel;
@property (nonatomic, retain) IBOutlet UILabel *otherLabel;

@property (nonatomic, retain) NSMutableArray *expenseItem;
@property (nonatomic, retain) NSString *monthString;
@property (nonatomic, retain) NSString *yearString;
//-(id) getMonth:(NSString *)m;'
- (id) initWithMonth:(NSString *)month year:(NSString *)year  nibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;
- (void) loadItemsFromDatabase:(NSString *)databasePath;
@end
