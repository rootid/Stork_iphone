    //
//  DummyMainController.m
//  Stork
//
//  Created by Snow Leopard User on 06/03/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "DummyMainController.h"

//Private member declaration
@interface DummyMainController () 
NSString *serverName;
@end

@implementation DummyMainController

- (id) initWithTitle:(NSString *)title
{
	if (self = [super init]) {
        // Custom initialization
		[self.navigationItem setTitle:title];	
		serverName = title;
    }
	return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	[super viewDidLoad];
	viewArray=[[NSMutableArray alloc] init];
	tableView=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
	tableView.backgroundColor=[UIColor blackColor];
	tableView.frame=CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height);
	tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
	tableView.dataSource=self;
	tableView.delegate=self;
	tableView.scrollEnabled=NO;
	[self.view addSubview:tableView];
}

- (void)dealloc {
	[tableView release];
	tableView=nil;
	
	
	[viewArray release];
	viewArray=nil;
	
	
    [super dealloc];
	
}

#pragma mark -
#pragma mark tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	//if(indexPath.row==1)
//		return 200;
//	if(indexPath.row==3)
//		return 50;
	return 40;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
	//if it is login controller 
	return 6;
	//if it is file controller return different value
}

- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	cell.selectionStyle=UITableViewCellEditingStyleNone;
	
	//NSInteger leftMargin=125;
	UILabel *lable=nil;
	UITextField *textField=nil;
	UIButton *submitButton=nil;
	
	switch (indexPath.row) {
		case 0:
			lable = [self createLabel:USER_NAME];
			[cell.contentView addSubview:lable];
			[lable release];			
			textField = [self createTextField:indexPath.row title:nil];
			[cell addSubview:textField];
			[viewArray addObject:textField];
			[textField release];
			break;
		case 1:
			lable = [self createLabel:PASS_WORD];
			[cell.contentView addSubview:lable];
			[lable release];
			textField = [self createTextField:indexPath.row title:nil];
			[textField setSecureTextEntry:YES];
			[cell addSubview:textField];
			[viewArray addObject:textField];
			[textField release];
			break;
		case 2:
			lable = [self createLabel:PROTOCOL];
			[cell.contentView addSubview:lable];
			[lable release];
			
			textField = [self createTextField:indexPath.row title:nil];
			[cell addSubview:textField];
			//[textField setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
			[viewArray addObject:textField];
			[textField release];
			break;
			
		case 3:
			lable = [self createLabel:PORT_NUMBER];
			[cell.contentView addSubview:lable];
			[lable release];
			
			textField = [self createTextField:indexPath.row title:nil];
			[textField setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
			[cell addSubview:textField];
			[viewArray addObject:textField];
			[textField release];
			break;
		case 4:
			lable = [self createLabel:PATH_NAME];
			[cell.contentView addSubview:lable];
			[lable release];
			
			textField = [self createTextField:indexPath.row title:nil];
			[cell addSubview:textField];
			[viewArray addObject:textField];
			[textField release];
			break;

			
		case 5:
			submitButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
			submitButton.frame=CGRectMake(220, 5, 70,25);
			[submitButton setTitle:SUBMIT forState:UIControlStateNormal];
			[submitButton addTarget:self action:@selector(submitButtonAction) forControlEvents:UIControlEventTouchUpInside];
 			
			[cell.contentView addSubview:submitButton];
			
			break;
	}
	return cell;
	
}
-(void)submitButtonAction{

	 DLSController *mainViewController = [[DLSController alloc] initWithTitle:serverName];
	//	//NSLog(@" server title %@",[serverListArray objectAtIndex:indexPath.row]);
	 [self.navigationController pushViewController:mainViewController animated:YES];
	 [mainViewController release];
}

-(UILabel *) createLabel:(NSString *)_name
{
	UILabel *_label;
	_label=[[UILabel alloc] initWithFrame:CGRectMake(40, 2, 80, 30)];
	_label.backgroundColor =[UIColor grayColor];
	_label.font =[UIFont systemFontOfSize:13];
	_label.text = _name;
	_label.textAlignment = UITextAlignmentRight;
	_label.backgroundColor = [UIColor clearColor];
	_label.textColor = [UIColor whiteColor];
	return _label;

}

-(UITextField *) createTextField:(NSInteger)tag title:(NSString *)name
{
	UITextField *_textField;
	_textField = [[UITextField alloc] initWithFrame:CGRectMake(125, 2, 190, 30)];
	_textField.borderStyle = UITextBorderStyleRoundedRect;
	_textField.returnKeyType = UIReturnKeyDone;
	_textField.tag = tag;
	_textField.autocapitalizationType = UITextAutocapitalizationTypeSentences;
	_textField.delegate=self;
	return _textField;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{	
	[UITableView beginAnimations:nil context:nil];
	[UITableView setAnimationBeginsFromCurrentState:YES];
	[UITableView setAnimationDuration:0.3f];
	NSInteger tblHeight=tableView.frame.size.height;
	if(textField.tag == 3 || textField.tag == 4 || 
	   textField.tag == 5)
	{
		tableView.frame=CGRectMake(0,-70,320,tblHeight);
	}else {
		tableView.frame=CGRectMake(0,0,320,tblHeight);
	}
	[UITableView commitAnimations];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
	switch (textField.tag) {
		case 0:
			//[addDealViewCntr.dealObject setDealTags:textField.text];
			break;
			
		case 2:
			//[addDealViewCntr.dealObject setOther:textField.text];
			break;
		case 4:
			//[addDealViewCntr.dealObject setOther:textField.text];
			break;
	}
	[viewArray addObject:textField];
	
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField              
{
	[textField resignFirstResponder];
	if(textField.tag == 2 || textField.tag == 3 || textField.tag == 4)
	{
		[UITableView beginAnimations:nil context:nil];
		[UITableView setAnimationBeginsFromCurrentState:YES];
		[UITableView setAnimationDuration:0.3f];
		tableView.frame=CGRectMake(0,0,320,tableView.frame.size.height);
		[UITableView commitAnimations];
	}
	return YES;
}

-(void)clearAllFields
{
	for (NSObject *field in viewArray ) {
		if([field isKindOfClass:[UITextField class]]){
			((UITextField*)field).text=EMPTY_STRING;
		}
	}
}


@end
