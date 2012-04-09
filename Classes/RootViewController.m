//
//  RootViewController.m
//  TreeTableDemo
//
//  Created by simone on 9/25/09.
//  Copyright Simone Ardissone 2009. All rights reserved.
//

#import "RootViewController.h"

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

	tree = [[Tree alloc] init];
	
	//populate with initial data [root,apache,bin,Test,test]
	//if it is directory add dummy data
	TreeNode* root = [[[TreeNode alloc] init] retain];
	TreeNode* apache = [[[TreeNode alloc] init] retain];
	TreeNode* bin = [[[TreeNode alloc] init] retain];
	TreeNode* dummyApache = [[[TreeNode alloc] init] retain];
	TreeNode* dummyBin = [[[TreeNode alloc] init] retain];
	TreeNode* test = [[[TreeNode alloc] init] retain];
	TreeNode* child121 = [[[TreeNode alloc] init] retain];
	[root setLabel:@"root"];
	[apache setLabel:@"apache"];
	[bin setLabel:@"bin"];
	[dummyBin setLabel:@"con"];
	[dummyApache setLabel:@"con"];

	//[child11 setLabel:@"child11"];
//	[child12 setLabel:@"child12"];
//	[child12 addChildren:child121];
//	
//	[child121 setLabel:@"child121"];
//	
//	[child1 setLabel:@"child1"];
//	[child1 addChildren:child11];
//	[child1 addChildren:child12];
//	
//	[child2 setLabel:@"child2"];
//	
	[root addChildren:apache];
	[apache addChildren:dummyApache];
	[root addChildren:bin];
	[bin addChildren:dummyBin];
	[tree setRoot:root];
	[root unSetRecursively];
	
	if([[root children] count] > 0){
		[root setExpanded:![root expanded]];
	}
	elements = [tree arrayRappresentation];
	
	[self onExpandedButtonTouch:root];
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

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release anything that can be recreated in viewDidLoad or on demand.
	// e.g. self.myOutlet = nil;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [elements count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    TreeNodeCell *cell = (TreeNodeCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[TreeNodeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	TreeNode* node = [elements objectAtIndex:indexPath.row];
	[cell setOwner:self];
	[cell setOnExpandedButtonTouch:@selector(onExpandedButtonTouch:)];
	[cell setOnCheckboxSelected:@selector(onCheckboxSelected:)];
	[cell setTreeNode:node];
	
    return cell;
}

-(void)onExpandedButtonTouch:(TreeNode*)node{

	NSLog(@"selected tree : %@",[node label]);
	//TreeNode *node1 = [tree root];
//	TreeNode* child1=[[[TreeNode alloc] init] retain];
//	TreeNode* child2=[[[TreeNode alloc] init] retain];
//	[child1 setLabel:@"child12"];
//	[child2 setLabel:@"child2"];
//	[node1 addChildren:child1];
//	[node1 addChildren:child2];
	elements = [tree arrayRappresentation];
	[self.tableView reloadData];	
}

-(void)onCheckboxSelected :(TreeNode *)node {

	if ([node isSelected] == NO) {
		[node setSelectedRecursively];
	}
	else {
		[node unSetRecursively];
	}
	[self.tableView reloadData];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

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


- (void)dealloc {
    [super dealloc];
}


@end

