//
//  BudgetItemViewController.h
//  FinanceManager
//
//  Created by Snow Leopard User on 04/12/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Budget.h"

@interface BudgetItemViewController : UIViewController {
	
	Budget *menuItem;
	IBOutlet UITextView	*menuItemDetails;
}

@property (nonatomic, retain) Budget *menuItem;
@property (nonatomic, retain) IBOutlet UITextView *menuItemDetails;

-(id) initWithMenuItem:(Budget *)m nibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;

@end