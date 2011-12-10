//
//  TransactionSummaryCell.m
//  FinanceManager
//
//  Created by IIT CCT7 on 12/9/11.
//  Copyright 2011 IIT. All rights reserved.
//

#import "TransactionSummaryCell.h"


@implementation TransactionSummaryCell
@synthesize monthLabel, yearLabel;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	
    [super setSelected:selected animated:animated];
	
    // Configure the view for the selected state
}


- (void)dealloc {
	[monthLabel release];
	[yearLabel release];
    [super dealloc];
}


@end
