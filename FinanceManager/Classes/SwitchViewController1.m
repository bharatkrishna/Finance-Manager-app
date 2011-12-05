//
//  SwitchViewController.m
//  TabBarApp
//
//  Created by Bharat on 21/10/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SwitchViewController1.h"
#import "AddTransactionViewController.h"
#import "SetBudgetViewController.h"


@implementation SwitchViewController1
@synthesize atvc;
@synthesize sbvc, bar;

- (void)viewDidLoad
{
    AddTransactionViewController *axisController = [[AddTransactionViewController alloc]
									   initWithNibName:@"AddTransactionViewController" bundle:nil];
    self.atvc = axisController;
    [self.view insertSubview:axisController.view atIndex:0];
	
    [axisController release];
    [super viewDidLoad];
}
//To switch to other view
- (IBAction)switchViews:(id)sender
{
	
	[UIView beginAnimations:@"View Flip" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	
    if (self.sbvc.view.superview == nil) //check to see if it's not in view 2 & switch to view 2
    {
        if (self.sbvc == nil)
        {
            SetBudgetViewController *alliesController =
            [[SetBudgetViewController alloc] initWithNibName:@"SetBudgetViewController"
											  bundle:nil];
            self.sbvc = alliesController;
            [alliesController release];
        }
		[UIView setAnimationTransition:
         UIViewAnimationTransitionFlipFromRight
                               forView:self.view cache:YES];
		
        [atvc viewWillAppear:YES];
        [sbvc viewWillDisappear:YES];
		
        [atvc.view removeFromSuperview];
        [self.view insertSubview:sbvc.view atIndex:0];
		[bar setTitle:@"Add Transaction"];
        [sbvc viewDidDisappear:YES];
        [atvc viewDidAppear:YES];
		
    }
    else
    {
		if (self.atvc == nil)
		{
			AddTransactionViewController *axisController =
			[[AddTransactionViewController alloc] initWithNibName:@"AddTransactionViewController"
											  bundle:nil];
			self.atvc = axisController;
			[axisController release];
		}
        [UIView setAnimationTransition:
         UIViewAnimationTransitionFlipFromLeft
							   forView:self.view cache:YES];
		
        [sbvc viewWillAppear:YES];
        [atvc viewWillDisappear:YES];
		
        [sbvc.view removeFromSuperview];
        [self.view insertSubview:atvc.view atIndex:0];
		[bar setTitle:@"Add Budget"];
        [atvc viewDidDisappear:YES];
        [sbvc viewDidAppear:YES];
    }
    [UIView commitAnimations];
	
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
	if (self.atvc.view.superview == nil)
        self.atvc = nil;
    else
		self.sbvc = nil;	
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
	[sbvc release];
    [atvc release];
	
    [super dealloc];
}


@end
