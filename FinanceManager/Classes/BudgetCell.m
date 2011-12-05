//
//  CustomCell.m
//  Assignment3
//
//  Created by Snow Leopard User on 17/11/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BudgetCell.h"


@implementation BudgetCell

@synthesize budgetMonth;
@synthesize budgetYear;
@synthesize image;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc {
	[budgetYear release];
	[budgetMonth release];
	[image release];
    [super dealloc];
}


@end
