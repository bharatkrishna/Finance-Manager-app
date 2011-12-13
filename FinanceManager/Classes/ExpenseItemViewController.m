//
//  ExpenseItemViewController.m
//  FinanceManager
//
//  Created by IIT CCT7 on 12/10/11.
//  Copyright 2011 IIT. All rights reserved.
//

#import "ExpenseItemViewController.h"
#import "PieClass.h"
#import "Item.h"

@implementation ExpenseItemViewController
@synthesize expenseItem, monthString, yearString;//, month;
@synthesize yearLabel, monthLabel, rentLabel, foodLabel, livingLabel, utilitiesLabel, gasLabel, otherLabel;
/*-(id) getMonth:(NSString *)m{
	if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
		self.month =month;
		NSString *title =  [NSString stringWithFormat:@"%@", month];
		
		[self setTitle: title];
		
    }
    return self;
}*/
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

-(id) initWithMonth:(NSString *)month year:(NSString *)year  nibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;

{
	if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
		yearString=year;
		monthString=month;
		NSString *title =  [NSString stringWithFormat:@"%@ %@", monthString, yearString];
		
		[self setTitle: title];
		
    }
    return self;
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/
- (void)viewDidLoad {
	NSLog(@"here1");
	NSString *databaseName;
	NSString *databasePath;
	databaseName = @"database4.sql";
	//put together db path
	NSLog(@"here2");
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentDir = [documentPaths objectAtIndex:0];
	databasePath = [documentDir stringByAppendingPathComponent:databaseName];
	NSLog(@"here3");
	[self loadItemsFromDatabase:databasePath];
    [super viewDidLoad];
	self.view.backgroundColor=[UIColor whiteColor];
	
	[yearLabel setText:yearString];
	[monthLabel setText:monthString];
	[utilitiesLabel setText:[NSString stringWithFormat:@"$ %@", [expenseItem objectAtIndex:0]]];
	[rentLabel setText:[NSString stringWithFormat:@"$ %@", [expenseItem objectAtIndex:2]]];
	[foodLabel setText:[NSString stringWithFormat:@"$ %@", [expenseItem objectAtIndex:1]]];
	[livingLabel setText:[NSString stringWithFormat:@"$ %@", [expenseItem objectAtIndex:3]]];
	[gasLabel setText:[NSString stringWithFormat:@"$ %@", [expenseItem objectAtIndex:4]]];
	[otherLabel setText:[NSString stringWithFormat:@"$ %@", [expenseItem objectAtIndex:5]]];
	

	
    // Draw a Pie Chart
    PieClass *myPieClass=[[PieClass alloc]initWithFrame:CGRectMake(55, 190, 320, 230)];
    myPieClass.itemArray=[[NSArray alloc]initWithObjects:[expenseItem objectAtIndex:1],[expenseItem objectAtIndex:2],[expenseItem objectAtIndex:0],
						  [expenseItem objectAtIndex:3],[expenseItem objectAtIndex:4], [expenseItem objectAtIndex:5], nil];
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
	
	//NSLog(@"item",[menuItem year]);
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
- (void) loadItemsFromDatabase:(NSString *)databasePath {
	sqlite3 *database;
	NSLog(@"here4");
	expenseItem = [[NSMutableArray alloc] init];
	
	if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
		NSString *sqlStatement =[NSString stringWithFormat: @"SELECT SUM(amount) AS TOTAL FROM Expenses WHERE tag='Food' and month=\'%@\' and year=\'%@\' ",monthString,yearString];
		sqlite3_stmt *compiledStatement;
		NSLog(@"open: %s", sqlite3_errmsg(database));
		if (sqlite3_prepare_v2(database, [sqlStatement UTF8String], -1, &compiledStatement, nil) == SQLITE_OK) {
			NSLog(@"prepare: %s", sqlite3_errmsg(database));
			
			while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
				//reading data
				NSLog(@"stepping through: %@", [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)]);
				NSLog(@"stepping: %s %d", sqlite3_errmsg(database), sqlite3_errcode(database));
		
				NSString *aValue = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
				[expenseItem addObject:aValue];

			}
			NSLog(@"done stepping: %s %d", sqlite3_errmsg(database), sqlite3_errcode(database));
			
		}
		
		sqlite3_finalize(compiledStatement);
		sqlStatement =[NSString stringWithFormat: @"SELECT SUM(amount) AS TOTAL FROM Expenses WHERE tag='Rent' and month=\'%@\' and year=\'%@\'",monthString,yearString];
		//sqlite3_stmt *compiledStatement;
		NSLog(@"openrent: %s,%@", sqlite3_errmsg(database),sqlStatement);
		if (sqlite3_prepare_v2(database, [sqlStatement UTF8String], -1, &compiledStatement, nil) == SQLITE_OK) {
			NSLog(@"prepare: %s", sqlite3_errmsg(database));
			
				while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
					//reading data
					NSLog(@"stepping through: %@", [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)]);
					NSLog(@"stepping: %s %d", sqlite3_errmsg(database), sqlite3_errcode(database));
					
					NSString *aValue = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
					[expenseItem addObject:aValue];
					
				}
				NSLog(@"done stepping: %s %d", sqlite3_errmsg(database), sqlite3_errcode(database));
			
		}
		sqlite3_finalize(compiledStatement);

		sqlStatement =[NSString stringWithFormat: @"SELECT SUM(amount) AS TOTAL FROM Expenses WHERE tag='Utilities' and month=\'%@\' and year=\'%@\'",monthString,yearString];
		//sqlite3_stmt *compiledStatement;
		NSLog(@"openUTILITY: %s,%@", sqlite3_errmsg(database),sqlStatement);
		if (sqlite3_prepare_v2(database, [sqlStatement UTF8String], -1, &compiledStatement, nil) == SQLITE_OK) {
			NSLog(@"openUTILITY: %s,%@", sqlite3_errmsg(database),sqlStatement);
			
				while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
					//reading data
					NSLog(@"stepping through: %@", [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)]);
					NSLog(@"stepping: %s %d", sqlite3_errmsg(database), sqlite3_errcode(database));
					
					NSString *aValue = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
					[expenseItem addObject:aValue];
					
				}
				NSLog(@"done stepping: %s %d", sqlite3_errmsg(database), sqlite3_errcode(database));
			
		}
		sqlite3_finalize(compiledStatement);

		sqlStatement =[NSString stringWithFormat: @"SELECT SUM(amount) AS TOTAL FROM Expenses WHERE tag='Living' and month=\'%@\' and year=\'%@\'",monthString,yearString];
		//sqlite3_stmt *compiledStatement;
		NSLog(@"open: %s", sqlite3_errmsg(database));
		if (sqlite3_prepare_v2(database, [sqlStatement UTF8String], -1, &compiledStatement, nil) == SQLITE_OK) {
			NSLog(@"prepare: %s", sqlite3_errmsg(database));
			
				while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
					//reading data
					NSLog(@"stepping through: %@", [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)]);
					NSLog(@"stepping: %s %d", sqlite3_errmsg(database), sqlite3_errcode(database));
					
					NSString *aValue = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
					[expenseItem addObject:aValue];
					
				}
				NSLog(@"done stepping: %s %d", sqlite3_errmsg(database), sqlite3_errcode(database));
		
		}
		sqlite3_finalize(compiledStatement);

		sqlStatement =[NSString stringWithFormat: @"SELECT SUM(amount) AS TOTAL FROM Expenses WHERE tag='Gas' and month=\'%@\' and year=\'%@\'",monthString,yearString];
		//sqlite3_stmt *compiledStatement;
		NSLog(@"open: %s", sqlite3_errmsg(database));
		if (sqlite3_prepare_v2(database, [sqlStatement UTF8String], -1, &compiledStatement, nil) == SQLITE_OK) {
			NSLog(@"prepare: %s", sqlite3_errmsg(database));
							while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
					//reading data
					NSLog(@"stepping through: %@", [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)]);
					NSLog(@"stepping: %s %d", sqlite3_errmsg(database), sqlite3_errcode(database));
					
					NSString *aValue = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
					[expenseItem addObject:aValue];
					
				}
				NSLog(@"done stepping: %s %d", sqlite3_errmsg(database), sqlite3_errcode(database));
			
		}
		sqlite3_finalize(compiledStatement);

		sqlStatement =[NSString stringWithFormat: @"SELECT SUM(amount) AS TOTAL FROM Expenses WHERE tag='Other' and month=\'%@\' and year=\'%@\'",monthString,yearString];
		//sqlite3_stmt *compiledStatement;
		NSLog(@"open: %s", sqlite3_errmsg(database));
		if (sqlite3_prepare_v2(database, [sqlStatement UTF8String], -1, &compiledStatement, nil) == SQLITE_OK) {
			NSLog(@"prepare: %s", sqlite3_errmsg(database));
		
				while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
					//reading data
					NSLog(@"stepping through: %@", [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)]);
					NSLog(@"stepping: %s %d", sqlite3_errmsg(database), sqlite3_errcode(database));
					
					NSString *aValue = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
					[expenseItem addObject:aValue];
					
				}
				NSLog(@"done stepping: %s %d", sqlite3_errmsg(database), sqlite3_errcode(database));
	
		}
		sqlite3_finalize(compiledStatement);
		
		NSLog(@"closing: %s", sqlite3_errmsg(database));
	}
	sqlite3_close(database);
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
