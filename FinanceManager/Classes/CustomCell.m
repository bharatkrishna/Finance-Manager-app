//
//  CustomCell.m
//  FinanceManager
//
//  Created by IIT CCT7 on 12/1/11.
//  Copyright 2011 IIT. All rights reserved.
//

#import "CustomCell.h"


@implementation CustomCell

@synthesize descriptionLabel, amountLabel, tagLabel, dateLabel;


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
	[descriptionLabel release];
	[amountLabel release];
	[tagLabel release];
	[dateLabel release];
    [super dealloc];
}


@end
