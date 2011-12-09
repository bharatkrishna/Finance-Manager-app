//
//  RootViewController.m
//  sqlite
//
//  Created by Soren Haurberg on 11/9/10.
//  Copyright 2010 Illinois Institute of Technology. All rights reserved.
//

#import "ViewBudgetViewController.h"
#import "FinanceManagerAppDelegate.h"
#import "Budget.h"
#import "BudgetItemViewController.h"
#import "BudgetCell.h"

@implementation ViewBudgetViewController
@synthesize budgetItems;


-(void) loadItemsFromDatabase:(NSString *)databasePath {
	sqlite3 *database;
	
	budgetItems = [[NSMutableArray alloc] init];
	
	if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
		NSString *sqlStatement = @"select * from Budgets";
		sqlite3_stmt *compiledStatement;
		NSLog(@"open: %s", sqlite3_errmsg(database));
		if (sqlite3_prepare_v2(database, [sqlStatement UTF8String], -1, &compiledStatement, nil) == SQLITE_OK) {
			NSLog(@"prepare: %s", sqlite3_errmsg(database));
			while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
				//reading data
				NSLog(@"stepping through: %@", [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)]);
				NSLog(@"stepping: %s %d", sqlite3_errmsg(database), sqlite3_errcode(database));
				NSString *a = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
				NSString *b = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
				NSString *c = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];
				NSString *d = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)];
				NSString *e = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 5)];
				NSString *f = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 6)];
				NSString *g = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 7)];
				NSString *h = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 8)];
				//make menu item

				Budget *budget = [[Budget alloc] initWithMonth:a year:b rent:c utilities:d food:e living:f gas:g other:h];
				[budgetItems addObject:budget];
				[budget release];
			}
			NSLog(@"done stepping: %s %d", sqlite3_errmsg(database), sqlite3_errcode(database));
		}
		sqlite3_finalize(compiledStatement);
		NSLog(@"closing: %s", sqlite3_errmsg(database));
	}
	sqlite3_close(database);
}

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
	//self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItem)];
	//appDelegate = (FinanceManagerAppDelegate *)[[UIApplication sharedApplication] delegate];
	//budgetItems = [appDelegate menuItems];
	appDelegate = (FinanceManagerAppDelegate *)[[UIApplication sharedApplication] delegate];
	budgetItems = [appDelegate budgetitems];
NSLog(@"no of items %d", [budgetItems count]);
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[self setTitle:@"Budget Records"];
	[self.tableView reloadData];
}

/*
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 }
 */

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	
}


- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
	
}


/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */


#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [budgetItems count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    static NSString *CellIdentifier = @"BudgetCell";
    
    BudgetCell *cell =(BudgetCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
		NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"BudgetCell" owner:nil options:nil];
		for (id currentObject in topLevelObjects) {
			if ([currentObject isKindOfClass:[BudgetCell class]]) {
				cell = (BudgetCell*)currentObject;
				break;
			}
		}
    }
    
	// Configure the cell.
	Budget *menuItem = (Budget *)[budgetItems objectAtIndex:[indexPath row]];
	
	[[cell budgetYear] setText:[menuItem year]];
	[[cell budgetMonth] setText:[menuItem month]];
    return cell;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
		[[budgetItems objectAtIndex:[indexPath row]] removeBudgetFromDatabase];
		[budgetItems removeObjectAtIndex:[indexPath row]];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    /*else if (editingStyle == UITableViewCellEditingStyleInsert) {
	 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
	 }*/  
}




// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
	//get your object being moved
	Budget *item1 = [budgetItems objectAtIndex:[fromIndexPath row]];
	//Retain it because you are about to remove it from the array
	[item1 retain];
	//remove item from array
	[budgetItems removeObjectAtIndex:[fromIndexPath row]];
	//reinsert into array
	[budgetItems insertObject:item1 atIndex:[toIndexPath row]];
	[item1 release];
}



/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	Budget *budgetItem = [budgetItems objectAtIndex:[indexPath row]];
	BudgetItemViewController *mivc = [[BudgetItemViewController alloc] initWithMenuItem:budgetItem nibName:@"BudgetItemViewController" bundle:nil];
	[self.navigationController pushViewController:mivc animated:YES];
	self.navigationItem.title = @"Back";
	[mivc release];
	
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

