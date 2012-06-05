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
-(void) initwithDataFromURI:(NSString *) response nodeInfo:(TreeNode *)node;
-(void) loadDataFromURI:(NSString *)response;
UIActivityIndicatorView *activityIndicator;
TreeNode *selectedNode;
BOOL isloaded = false;
BOOL isInitiated = false;
ServerInformation *serverInfo;
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


- (id) initWithTitle:(NSString *)title serverInformation:(ServerInformation *)aServerInfo
{
	if (self = [super initWithStyle:UITableViewCellStyleDefault]) {
        // Custom initialization
		[self.navigationItem setTitle:title];		
    }
	serverInfo = aServerInfo;
	return self;
}


-(void) loadActivity {
	activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	activityIndicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
	activityIndicator.center = self.view.center;
	[self.view addSubview: activityIndicator];
	[activityIndicator startAnimating];
}

-(void) stopActivity {
	[activityIndicator stopAnimating];
}

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	[self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
	[self initHTTPReceiver];
	//[self loadActivity];
	//dataAdapter = [[DataAdapter alloc] init];
	//[dataAdapter initializeDirList];
	folderListArray = [[NSArray alloc] initWithArray:dataAdapter.folderList];
	
	UIBarButtonItem *uploadButton = [[UIBarButtonItem alloc] initWithTitle:UPLOAD 
									style:UIBarButtonItemStylePlain 
									target:self action:@selector(uploadFiles:)];          
	self.navigationItem.rightBarButtonItem = uploadButton;
	[uploadButton release];
	
	tree = [[Tree alloc] init];
	
	NSLog(@"After receiveing the data");
	//[self initWithInitialData];
	
}


-(void)initHTTPReceiver {
	HTTPHandler *httpObj=[HTTPHandler getSharedInstantance];
	httpObj.delegate = self;
	[httpObj getPostContentForURL1:[NSString stringWithFormat:@"%@",URL_DLS] information:serverInfo];
}

-(void) loadDataFromURI:(NSString *) response nodeInfo:(TreeNode *)node {
	NSArray *fields = [response componentsSeparatedByString:@"\n"];
	TreeNode *dirNode,*fileNode,*dummyNode;
	int i = 0;
	for ( i = 0; i< [fields count]; i++) {
		NSString *file = [[fields objectAtIndex:i] retain];
		if([file rangeOfString:@"%"].location == NSNotFound) {
			NSLog(@"%@",file);
			fileNode = [[[TreeNode alloc] init] retain];
			[fileNode setLabel:file];
			[node addChildren:fileNode];
		}
		else {
			NSArray *subfields = [file componentsSeparatedByString:@"%"];
			//file
			fileNode = [[[TreeNode alloc] init] retain];
			[fileNode setLabel:[[subfields objectAtIndex:1]retain]];
			[node addChildren:fileNode];
			NSLog(@"DIR %@with file %@",[subfields objectAtIndex:1],file); 
			//dir	
			dirNode = [[[TreeNode alloc] init] retain];
			[dirNode setLabel:[[subfields objectAtIndex:1]retain]];
			dummyNode = [[[TreeNode alloc] init] retain];
			[dummyNode setLabel:@"con"];
			[dirNode addChildren:dummyNode];
			[node addChildren:dirNode];
		}
		
	}
	[node unSetRecursively];
	[node setIsVisited:true];
	if([[node children] count] > 0){
		[node setExpanded:![node expanded]];
	}
	elements = [tree arrayRappresentation];
	[self onExpandedButtonTouch:node];
	
}

-(void) initwithDataFromURI:(NSString *) response {

	NSArray *fields = [response componentsSeparatedByString:@"\n"];
	int i = 0;
	TreeNode *dirNode,*fileNode,*root,*dummyNode;
	root = [[[TreeNode alloc] init] retain];
	[root setLabel:@"root"]; //determine the start point
	[root setIsVisited:YES];
	for ( i = 0; i< [fields count]; i++) {
		
		NSString *file = [[fields objectAtIndex:i] retain];
		if([file rangeOfString:@"%"].location == NSNotFound) {
			NSLog(@"%@",file);
			fileNode = [[[TreeNode alloc] init] retain];
			//[fileNode setLabel:file];
			[fileNode setLabel:file];
			[root addChildren:fileNode];
		}
		else {
			NSArray *subfields = [file componentsSeparatedByString:@"%"];
			//file
			fileNode = [[[TreeNode alloc] init] retain];
			//[fileNode setLabel:[subfields objectAtIndex:0]];
			[fileNode setLabel:[[subfields objectAtIndex:1]retain]];
			[root addChildren:fileNode];
			NSLog(@"DIR %@with file %@",[subfields objectAtIndex:1],file); 
			//dir	
			dirNode = [[[TreeNode alloc] init] retain];
			//[dirNode setLabel:[subfields objectAtIndex:1]];
			[dirNode setLabel:[[subfields objectAtIndex:1]retain]];
			dummyNode = [[[TreeNode alloc] init] retain];
			[dummyNode setLabel:@"con"];
			[dirNode addChildren:dummyNode];
			[root addChildren:dirNode];
		}
		
	}
	[tree setRoot:root];
	[root unSetRecursively];
	
	if([[root children] count] > 0){
		[root setExpanded:![root expanded]];
	}
	elements = [tree arrayRappresentation];
	
	[self onExpandedButtonTouch:root];
	
	isInitiated = true;
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
	//NSLog(@"Data received %@",aStr);
	isloaded = true;
		
	//[dataAdapter initializeDirList];
	//folderListArray = [[NSArray alloc] initWithArray:dataAdapter.folderList];
	if(isInitiated == false) {
		[self initwithDataFromURI:aStr];
	}
	else {
		[self loadDataFromURI:aStr nodeInfo:selectedNode];
	}
	//[self initWithInitialData];
	[self stopActivity];
	//[self.tableView reloadData];
}
- (void)connection:(HTTPHandler *)connection didFailWithError:(NSError *)error
{
	NSLog(@"Data failed");
}


#pragma mark -
#pragma mark button selector methods

-(void)onExpandedButtonTouch:(TreeNode*)node{
	
	NSLog(@"selected tree : %@",[node label]);
	if([node isVisited] == NO) {
		[serverInfo setPathName:[node label]];
		[node setExpanded:NO];
		selectedNode = node;
		[self initHTTPReceiver];
		NSLog(@"node other than root selected");
		
	}
	else {
		elements = [tree arrayRappresentation];
		[self.tableView reloadData];
	}
//	TreeNode *node1 = [tree root];
//	TreeNode* child1=[[[TreeNode alloc] init] retain];
//	TreeNode* child2=[[[TreeNode alloc] init] retain];
//	[child1 setLabel:@"child12"];
//	[child2 setLabel:@"child2"];
//	[node1 addChildren:child1];
//	[node1 addChildren:child2];
		
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
	if(isloaded) {
    return [elements count];
	}
	else {
		return 1;
	}

}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    TreeNodeCell *cell = (TreeNodeCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[TreeNodeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    if (isloaded) {
		TreeNode* node = [elements objectAtIndex:indexPath.row];
		[cell setOwner:self];
		[cell setOnExpandedButtonTouch:@selector(onExpandedButtonTouch:)];
		[cell setOnCheckboxSelected:@selector(onCheckboxSelected:)];
		[cell setTreeNode:node];
		
	}
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

