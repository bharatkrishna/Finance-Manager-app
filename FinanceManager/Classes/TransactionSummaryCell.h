//
//  TransactionSummaryCell.h
//  FinanceManager
//
//  Created by IIT CCT7 on 12/9/11.
//  Copyright 2011 IIT. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TransactionSummaryCell : UITableViewCell {
	
	UILabel *monthLabel;
	UILabel *yearLabel;
	
}

@property (nonatomic,retain) IBOutlet UILabel *monthLabel;
@property (nonatomic,retain) IBOutlet UILabel *yearLabel;


@end