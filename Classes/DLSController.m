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
//TODO put tree element here
-(void)initWithInitialData;
-(void)onExpandedButtonTouch :(TreeNode *) node;
-(void) initHTTPReceiver;
@end

@implementation DLSController


#pragma mark -
#pragma mark Initialization


- (id) initWithTitle:(NSString *)title
{
	if (self = [super initWithStyle:UITableViewCellStyleDefault]) {
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
	
	UIBarButtonItem *uploadButton = [[UIBarButtonItem alloc] initWithTitle:UPLOAD 
									style:UIBarButtonItemStylePlain 
									target:self action:@selector(uploadFiles:)];          
	self.navigationItem.rightBarButtonItem = uploadButton;
	[uploadButton release];
	
	tree = [[Tree alloc] init];
	[self initHTTPReceiver];
	[self initWithInitialData];
	
}

-(void)initHTTPReceiver {
	HTTPHandler *httpObj=[HTTPHandler getSharedInstantance];
	httpObj.delegate = self;
	[httpObj getContentForURL:[NSString stringWithFormat:@"%@",URL_TEST]];
}

-(void)initWithInitialData {
	
	//populate with initial data [root,apache,bin,Test,test]
	//if it is directory add dummy data
	TreeNode* root = [[[TreeNode alloc] init] retain];
	TreeNode* apache = [[[TreeNode alloc] init] retain];
	TreeNode* bin = [[[TreeNode alloc] init] retain];
	TreeNode* dummyApache = [[[TreeNode alloc] init] retain];
	TreeNode* dummyBin = [[[TreeNode alloc] init] retain];

	[root setLabel:@"root"];
	[apache setLabel:@"apache"];
	[bin setLabel:@"bin"];
	[dummyBin setLabel:@"con"];
	[dummyApache setLabel:@"con"];
	
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


#pragma mark -
#pragma mark HTTP delegate
- (void)connection:(HTTPHandler*)connection didReceiveData:(NSData *)data
{
	
	NSString* aStr;
	aStr = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
	NSLog(@"Data received %@",aStr);
}
- (void)connection:(HTTPHandler *)connection didFailWithError:(NSError *)error
{
	NSLog(@"Data failed");
}


#pragma mark -
#pragma mark button selector methods

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

