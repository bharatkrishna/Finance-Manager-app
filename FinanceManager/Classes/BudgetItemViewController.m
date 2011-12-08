//
//  untitled.m
//  Assignment3
//
//  Created by Snow Leopard User on 15/11/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BudgetItemViewController.h"
#import "Budget.h"
#import "PieClass.h"

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
	self.view.backgroundColor=[UIColor whiteColor];
	[menuItemDetails setText:[NSString stringWithFormat:@"\n\nYear: %@ Month: %@\nRent(purple): \$%@ Utilities(red): \$%@ Food(orange): \$%@ Living(yellow): \$%@ Gas(green): \$%@ Other(blue): \$%@", 
							  [menuItem year], 
							  [menuItem month], 
							  [menuItem rent],
							  [menuItem utilities],
							 [menuItem food],
							  [menuItem living],
							  [menuItem gas],
							  [menuItem other]]];
	


    
    PieClass *myPieClass=[[PieClass alloc]initWithFrame:CGRectMake(0, 210, 320, 230)];
    myPieClass.itemArray=[[NSArray alloc]initWithObjects:[menuItem rent],[menuItem utilities],[menuItem food],
						  [menuItem living],[menuItem gas], [menuItem other], nil];
    myPieClass.myColorArray=[[NSArray alloc]initWithObjects:
							 [UIColor purpleColor],
							 [UIColor redColor],
							 [UIColor orangeColor],
							 [UIColor yellowColor],
							 [UIColor greenColor], 
							 [UIColor blueColor], nil];
    myPieClass.radius=100;
    [self.view addSubview:myPieClass];
	//self.view.subviews.backgroundColor=[UIColor whiteColor];
    
    
  
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
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
