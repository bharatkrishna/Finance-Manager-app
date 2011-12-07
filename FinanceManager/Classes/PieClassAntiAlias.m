//
//  PieClassAntiAlias.m
//  FinanceManager
//
//  Created by Snow Leopard User on 06/12/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PieClassAntiAlias.h"


@implementation PieClassAntiAlias
@synthesize itemArray,myColorArray,radius;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    int c=[itemArray count];
    
    CGFloat angleArray[c];
    CGFloat offset;
    int sum=0;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
	
    
    
    
    
    
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetShouldAntialias(context, true);
    
    
    for(int i=0;i<[itemArray count];i++)
    {
        
        sum+=[[itemArray objectAtIndex:i] intValue];
    }
    
    for(int i=0;i<[itemArray count];i++)
    {
        
        angleArray[i]=(float)(([[itemArray objectAtIndex:i] intValue])/(float)sum)*(2*3.14); // in radians
        
        
        CGContextMoveToPoint(context, radius, radius);
        if(i==0)
            CGContextAddArc(context, radius, radius, radius, 0,angleArray[i], 0);
        else
            CGContextAddArc(context, radius, radius, radius,offset,offset+angleArray[i], 0);
        offset+=angleArray[i];
        
        
        CGContextSetFillColorWithColor(context, ((UIColor *)[myColorArray objectAtIndex:i]).CGColor);
        CGContextClosePath(context); 
        CGContextFillPath(context);
        
        
    }
	
    
    
}

- (void)dealloc
{
    [super dealloc];
}

@end
