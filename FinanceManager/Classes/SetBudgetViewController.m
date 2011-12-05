//
//  SetBudgetViewController.m
//  FinanceManager
//
//  Created by IIT CCT7 on 11/30/11.
//  Copyright 2011 IIT. All rights reserved.
//

#import "SetBudgetViewController.h"
#import "FinanceManagerAppDelegate.h"

@implementation SetBudgetViewController
@synthesize monthField, yearField, rentField, livingField, utilityField, gasField, foodField, otherField, actionSheet;
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
// To close the keyboard on pressing done
-(void)doneEditing:(id)sender {
	[sender resignFirstResponder];
}

// To close the keyboard on tapping background
-(IBAction)backgroundTap:(id)sender{
	[monthField resignFirstResponder];
	[yearField resignFirstResponder];
    [rentField resignFirstResponder];
	[livingField resignFirstResponder];
	[utilityField resignFirstResponder];
	[gasField resignFirstResponder];
	[foodField resignFirstResponder];
	[otherField resignFirstResponder];
}
	



// To save the contents of the textbox to the database
-(IBAction)saveBudget {
	newBudget = [[Budget alloc] initWithMonth:[monthField text] year:[yearField text] rent:[rentField text] utilities:[utilityField text]
										 food:[foodField text] living:[livingField text] gas:[gasField text] other:[otherField text]];
	FinanceManagerAppDelegate *delegate = (FinanceManagerAppDelegate *)[[UIApplication sharedApplication] delegate];
	[delegate addBudget:newBudget];
	[newBudget addBudgetToDatabase];
	//[self.navigationController popViewControllerAnimated:YES];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" 
													message:@"Budget Added"
												   delegate:nil 
										  cancelButtonTitle:@"OK" 
										  otherButtonTitles: nil];
	[alert show];
	[alert release];
}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


//Action sheet date picker functions end.

-(IBAction)callPicker:(id)sender{
	self.actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil]; 
    
    [actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    
    CGRect pickerFrame = CGRectMake(0, 40, 0, 0);
	
    UIPickerView* pickView = [[UIPickerView alloc] initWithFrame: pickerFrame];
    pickView.showsSelectionIndicator = YES;
    pickView.dataSource = self;
    pickView.delegate = self;
    [actionSheet addSubview: pickView];
    
    UISegmentedControl* closeButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Done", nil]];
    closeButton.momentary = YES;
    closeButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
    closeButton.tag = 120;
    closeButton.segmentedControlStyle = UISegmentedControlStyleBar;
    closeButton.tintColor = [UIColor blueColor];
    [closeButton addTarget:self action:@selector(dismissActionSheet) forControlEvents:UIControlEventValueChanged];
    [closeButton addTarget:self action:@selector(dismissActionSheet) forControlEvents:UIControlEventValueChanged];
    [(UIButton*)[closeButton.subviews objectAtIndex: 0] setEnabled: YES];
    [(UIButton*)[closeButton.subviews objectAtIndex: 0] setAlpha: 0.9f];
    
    [actionSheet addSubview:closeButton];
    [closeButton release];
    
    [actionSheet showInView: self.view.window];
    
    [actionSheet setBounds:CGRectMake(0, 0, 320, 485)];
	[monthField resignFirstResponder];
	
}

- (void) dismissActionSheet{
    [self.actionSheet dismissWithClickedButtonIndex:0 animated:YES];
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"%@",[monthArray objectAtIndex:row]);
	[monthField setText:[monthArray objectAtIndex:row]];
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [monthArray count];
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title;
	title= [monthArray objectAtIndex:row];
	
    return title;
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
	int sectionWidth = 300;
	
	return sectionWidth;
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	yearField.keyboardType = UIKeyboardTypeNumberPad;
	utilityField.keyboardType = UIKeyboardTypeDecimalPad;
	rentField.keyboardType = UIKeyboardTypeDecimalPad;
	livingField.keyboardType = UIKeyboardTypeDecimalPad;
	gasField.keyboardType = UIKeyboardTypeDecimalPad;
	foodField.keyboardType = UIKeyboardTypeDecimalPad;
	otherField.keyboardType = UIKeyboardTypeDecimalPad;
	monthArray = [[NSArray alloc] initWithObjects:@"Jan",@"Feb",@"March",@"Apr",@"May",@"Jun",@"July",@"Aug",@"Sep",@"Oct",@"Nov",@"Dec",nil];
	monthField.inputView = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];

	self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"background.png"]]; 
	
    [super viewDidLoad];
}


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
