//
//  untitled.m
//  Assignment3
//
//  Created by Snow Leopard User on 15/11/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BudgetItemViewController.h"
#import "Budget.h"

@implementation BudgetItemViewController

@synthesize menuItem;
@synthesize menuItemDetails;

- (id)initWithMenuItem:(Budget *)m nibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
		menuItem = m;
		NSString *title =  [NSString stringWithFormat:@"%@ %@", [menuItem month], [menuItem year]];
	
		[self setTitle: title];

    }
    return self;
}
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
 if (self) {
 // Custom initialization.
 }
 return self;
 }
 */

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
 }
 */


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[menuItemDetails setText:[NSString stringWithFormat:@"\n\n\nYear: \n%@\nMonth: \n%@\nRent: \n%@\nUtilities: \n%@\nFood: \n%@\nLiving: \n%@\nGas: \n%@\nOther: \n%@", 
							  [menuItem year], 
							  [menuItem month], 
							  [menuItem rent],
							  [menuItem utilities],
							  [menuItem food],
							  [menuItem living],
							  [menuItem gas],
							  [menuItem other]]];
	NSLog(@"item",[menuItem year]);
}


/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
	
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
