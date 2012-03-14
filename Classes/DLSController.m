//
//  DLSController.m
//  Stork
//
//  Created by Snow Leopard User on 14/03/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "DLSController.h"

@interface DLSController(Private)

DataAdapter *dataAdapter;
NSArray *folderListArray;

@end

@implementation DLSController


#pragma mark -
#pragma mark Initialization


- (id) initWithTitle:(NSString *)title
{
	if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        // Custom initialization
		[self.navigationItem setTitle:title];		
    }
	return self;
}




#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	[self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    dataAdapter = [[DataAdapter alloc] init];
	[dataAdapter initializeDirList];
	folderListArray = [[NSArray alloc] initWithArray:dataAdapter.folderList];
	
	UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:UPLOAD style:UIBarButtonItemStylePlain target:self action:@selector(uploadFiles:)];          
	self.navigationItem.rightBarButtonItem = anotherButton;
	[anotherButton release];
	
	
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
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
    return [folderListArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
	DLSCellView *cell = (DLSCellView *)[tableView dequeueReusableCellWithIdentifier:
													  CellIdentifier];
    if (cell == nil) {
        cell = [[[DLSCellView alloc] initWithStyle:UITableViewCellStyleDefault 
										  reuseIdentifier:CellIdentifier] autorelease];
    }
    
	[cell setlblForFolder:[folderListArray objectAtIndex:indexPath.row]];
	
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


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
    
	DLSCellView *newCell = (DLSCellView *)[tableView cellForRowAtIndexPath:indexPath];
	
    if (newCell.accessoryType == UITableViewCellAccessoryNone) {
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else {
        newCell.accessoryType = UITableViewCellAccessoryNone;
    }
	
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

