	//
//  BudgetCell.h
//  FinanceManager
//
//  Created by Snow Leopard User on 04/12/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BudgetCell : UITableViewCell {
	IBOutlet UILabel *budgetMonth;
	IBOutlet UILabel *budgetYear;
	IBOutlet UIImageView *image;
}

@property (nonatomic,retain) IBOutlet UILabel *budgetMonth;
@property (nonatomic,retain) IBOutlet UILabel *budgetYear;
@property (nonatomic,retain) IBOutlet UIImageView *image;


@end
