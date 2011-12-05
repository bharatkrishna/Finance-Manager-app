//
//  AddTransactionViewController.m
//  FinanceManager
//
//  Created by IIT CCT7 on 11/30/11.
//  Copyright 2011 IIT. All rights reserved.
//

#import "AddTransactionViewController.h"
#import "FinanceManagerAppDelegate.h"

@implementation AddTransactionViewController
@synthesize descriptionField, amountField, tagField, dateField;
@synthesize saveButton, datePickButton, actionSheet;

// To close the keyboard on pressing done
-(void)doneEditing:(id)sender {
	[sender resignFirstResponder];
}

// To close the keyboard on tapping background
-(IBAction)backgroundTap:(id)sender{
	[descriptionField resignFirstResponder];
	[amountField resignFirstResponder];
	[tagField resignFirstResponder];
	[dateField resignFirstResponder];
	
}
// To save the contents of the textbox to the database
-(IBAction)saveItem {
	newItem = [[Item alloc] initWithDescription:[descriptionField text] amount:[amountField text] tag:[tagField text] date:[dateField text]];
	FinanceManagerAppDelegate *delegate = (FinanceManagerAppDelegate *)[[UIApplication sharedApplication] delegate];
	[delegate addItem:newItem];
	[newItem addItemToDatabase];
	//[self.navigationController popViewControllerAnimated:YES];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" 
													message:@"Transaction Added"
												   delegate:nil 
										  cancelButtonTitle:@"OK" 
										  otherButtonTitles: nil];
	[alert show];
	[alert release];
}

// Following are actionsheet date picker related functions. Do not modify.

- (void)changeDate:(UIDatePicker *)sender {
	NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"MM-dd-yyyy"];
	NSString *dateString = [dateFormatter stringFromDate:sender.date];
	[dateFormatter release];
	[dateField setText:dateString];
	NSLog(@"Date: %@",dateString); 
	
}

- (void)removeViews:(id)object {
	[[self.view viewWithTag:9] removeFromSuperview];
	[[self.view viewWithTag:10] removeFromSuperview];
	[[self.view viewWithTag:11] removeFromSuperview];
}

- (void)dismissDatePicker:(id)sender {
	CGRect toolbarTargetFrame = CGRectMake(0, self.view.bounds.size.height, 320, 44);
	CGRect datePickerTargetFrame = CGRectMake(0, self.view.bounds.size.height+44, 320, 216);
	[UIView beginAnimations:@"MoveOut" context:nil];
	[self.view viewWithTag:9].alpha = 0;
	[self.view viewWithTag:10].frame = datePickerTargetFrame;
	[self.view viewWithTag:11].frame = toolbarTargetFrame;
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(removeViews:)];
	[UIView commitAnimations];
}

- (IBAction)callDP:(id)sender {
	if ([self.view viewWithTag:9]) {
		return;
	}
	CGRect toolbarTargetFrame = CGRectMake(0, self.view.bounds.size.height-216-44, 320, 44);
	CGRect datePickerTargetFrame = CGRectMake(0, self.view.bounds.size.height-216, 320, 216);
	
	UIView *darkView = [[[UIView alloc] initWithFrame:self.view.bounds] autorelease];
	darkView.alpha = 0;
	darkView.backgroundColor = [UIColor blackColor];
	darkView.tag = 9;
	UITapGestureRecognizer *tapGesture = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissDatePicker:)] autorelease];
	[darkView addGestureRecognizer:tapGesture];
	[self.view addSubview:darkView];
	
	UIDatePicker *datePicker = [[[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height+44, 320, 216)] autorelease];
	datePicker.datePickerMode=UIDatePickerModeDate;
	datePicker.tag = 10;
	[datePicker addTarget:self action:@selector(changeDate:) forControlEvents:UIControlEventValueChanged];
	[self.view addSubview:datePicker];
	
	UIToolbar *toolBar = [[[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, 320, 44)] autorelease];
	toolBar.tag = 11;
	toolBar.barStyle = UIBarStyleBlackTranslucent;
	UIBarButtonItem *spacer = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease];
	UIBarButtonItem *doneButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissDatePicker:)] autorelease];
	[toolBar setItems:[NSArray arrayWithObjects:spacer, doneButton, nil]];
	[self.view addSubview:toolBar];
	
	[UIView beginAnimations:@"MoveIn" context:nil];
	toolBar.frame = toolbarTargetFrame;
	datePicker.frame = datePickerTargetFrame;
	darkView.alpha = 0.5;
	[UIView commitAnimations];
	
}

//month Action sheet date picker functions end.

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
	[amountField resignFirstResponder];
	[tagField resignFirstResponder];
		
}

- (void) dismissActionSheet{
    [self.actionSheet dismissWithClickedButtonIndex:0 animated:YES];
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"%@",[tagArray objectAtIndex:row]);
	[tagField setText:[tagArray objectAtIndex:row]];
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [tagArray count];
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title;
	title= [tagArray objectAtIndex:row];
	
    return title;
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
	int sectionWidth = 300;
	
	return sectionWidth;
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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	tagArray = [[NSArray alloc] initWithObjects:@"Food",@"Rent",@"Utilities",@"Living",@"Gas",@"Others",nil];
	tagField.inputView = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
	amountField.keyboardType = UIKeyboardTypeDecimalPad;
	self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"background.png"]]; 

    [super viewDidLoad];
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
	[dateField release];
	[amountField release];
	[tagField release];
	[dateField release];
	[saveButton release];
    [super dealloc];
}


@end
