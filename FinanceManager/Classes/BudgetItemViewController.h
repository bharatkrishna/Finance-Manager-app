//
//  BudgetItemViewController.h
//  FinanceManager
//
//  Created by Snow Leopard User on 04/12/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PieClassAntiAlias.h"
#import "Budget.h"

@interface BudgetItemViewController : UIViewController {
	
	Budget *menuItem;
	UILabel *yearLabel;
	UILabel *monthLabel;
	UILabel *rentLabel;
	UILabel *foodLabel;
	UILabel *livingLabel;
	UILabel *utilitiesLabel;
	UILabel *gasLabel;
	UILabel *otherLabel;
}

@property (nonatomic, retain) Budget *menuItem;
@property (nonatomic, retain) IBOutlet UILabel *yearLabel;
@property (nonatomic, retain) IBOutlet UILabel *monthLabel;
@property (nonatomic, retain) IBOutlet UILabel *rentLabel;
@property (nonatomic, retain) IBOutlet UILabel *foodLabel;
@property (nonatomic, retain) IBOutlet UILabel *livingLabel;
@property (nonatomic, retain) IBOutlet UILabel *utilitiesLabel;
@property (nonatomic, retain) IBOutlet UILabel *gasLabel;
@property (nonatomic, retain) IBOutlet UILabel *otherLabel;

-(id) initWithMenuItem:(Budget *)m nibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;

@end