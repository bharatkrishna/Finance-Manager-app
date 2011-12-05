//
//  CustomCell.h
//  FinanceManager
//
//  Created by IIT CCT7 on 12/1/11.
//  Copyright 2011 IIT. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CustomCell : UITableViewCell {
	
	IBOutlet UILabel *descriptionLabel;
	UILabel *amountLabel;
	UILabel *tagLabel;
	UILabel *dateLabel;
	
}

@property (nonatomic,retain) IBOutlet UILabel *descriptionLabel;
@property (nonatomic,retain) IBOutlet UILabel *amountLabel;
@property (nonatomic,retain) IBOutlet UILabel *tagLabel;
@property (nonatomic,retain) IBOutlet UILabel *dateLabel;

@end