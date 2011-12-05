//
//  ViewTransactionViewController.m
//  FinanceManager
//
//  Created by IIT CCT7 on 12/1/11.
//  Copyright 2011 IIT. All rights reserved.
//

#import "ViewTransactionViewController.h"
#import "FinanceManagerAppDelegate.h"
#import "CustomCell.h"

@implementation ViewTransactionViewController
@synthesize items;

- (void) loadItemsFromDatabase:(NSString *)databasePath {
	sqlite3 *database;
	
	items = [[NSMutableArray alloc] init];
	
	if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
		NSString *sqlStatement = @"select * from Expenses";
		sqlite3_stmt *compiledStatement;
		NSLog(@"open: %s", sqlite3_errmsg(database));
		if (sqlite3_prepare_v2(database, [sqlStatement UTF8String], -1, &compiledStatement, nil) == SQLITE_OK) {
			NSLog(@"prepare: %s", sqlite3_errmsg(database));
			while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
				//reading data
				NSLog(@"stepping through: %@", [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)]);
				NSLog(@"stepping: %s %d", sqlite3_errmsg(database), sqlite3_errcode(database));
				int aIdent = sqlite3_column_int(compiledStatement, 0);
				NSString *aDescription = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
				NSString *aAmount = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
				NSString *aTag = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];
				NSString *aDate = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)];
				//make menu item
				Item *item = [[Item alloc] initWithId:aIdent description:aDescription amount:aAmount tag:aTag date:aDate];
				[items addObject:item];
				[item release];
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
	appDelegate = (FinanceManagerAppDelegate *)[[UIApplication sharedApplication] delegate];
	items = [appDelegate items];
	self.navigationItem.leftBarButtonItem = self.editButtonItem;
	[self.view setNeedsDisplay];
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[self.tableView reloadData];
	self.navigationItem.title = @"Transactions";

}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [items count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CustomCell";
	
    CustomCell *cell = (CustomCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		
		NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:self options:nil];
		
		for (id currentObject in topLevelObjects){
			if ([currentObject isKindOfClass:[UITableViewCell class]]){
				cell =  (CustomCell *) currentObject;
				break;
			}
		}
	}
    
    // Configure the cell...
    
	Item  *expItem = (Item *)[items objectAtIndex:[indexPath row]];
	//[[cell textLabel] setText:[expItem description]];
	[[cell descriptionLabel] setText:[expItem description]];
	[[cell amountLabel] setText:[expItem amount]];
	[[cell tagLabel] setText:[expItem tag]];
	[[cell dateLabel] setText:[expItem date]];
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
		[[items objectAtIndex:[indexPath row]] removeItemFromDatabase];
		[items removeObjectAtIndex:[indexPath row]];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
}



/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


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
    // Navigation logic may go here. Create and push another view controller.
    /*
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    */
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

