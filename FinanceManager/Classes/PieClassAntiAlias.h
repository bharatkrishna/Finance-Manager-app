//
//  PieClassAntiAlias.h
//  FinanceManager
//
//  Created by Snow Leopard User on 06/12/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PieClassAntiAlias : UIView {
    
    NSArray* itemArray;
    NSArray* myColorArray; 
    int radius;
    
}
@property(nonatomic,retain)NSArray* itemArray;
@property(nonatomic,retain)NSArray* myColorArray;
@property(nonatomic,assign) int radius;



@end

