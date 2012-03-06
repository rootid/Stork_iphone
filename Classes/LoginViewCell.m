//
//  LoginViewCell.m
//  Stork
//
//  Created by Snow Leopard User on 06/03/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "LoginViewCell.h"


@implementation LoginViewCell

@synthesize userNameLabel,passWordLabel,protocolName,portNumber,
userNameText,passWordText,protocolText,portNumberText, submitButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
		UIView *myContentView = self.contentView;
		self.shouldIndentWhileEditing = NO;
		
		if(userNameLabel == nil)
			{
			userNameLabel =[[UILabel alloc]initWithFrame:CGRectZero];
			}
				[userNameLabel setBackgroundColor:[UIColor clearColor]];
				[userNameLabel setTextColor:[UIColor blackColor]];
				[userNameLabel setText:USER_NAME];
			
				if(userNameText == nil)
				{
				userNameText = [[UITextField alloc] initWithFrame:CGRectZero];
				}
				[userNameText setDelegate:self];
				[userNameText setTag:USER_NAME_TEXT];
				
				if(passWordLabel == nil)
				{
				passWordLabel =[[UILabel alloc]initWithFrame:CGRectZero];
				}
				[passWordLabel setBackgroundColor:[UIColor clearColor]];
				[passWordLabel setTextColor:[UIColor blackColor]];
				[passWordLabel setText:PASS_WORD];
				
				
				if(passWordText == nil)
				{
				passWordText = [[UITextField alloc] initWithFrame:CGRectZero];
				}
				[passWordText setDelegate:self];
				[passWordText setSecureTextEntry:true];
				[passWordText setTag:PASS_WORD_TEXT];
		
		
		userNameText.tag = 1;
		userNameText.textColor = [UIColor darkTextColor];
		//cellText.numberOfLines = 0;
		userNameText.font = [ UIFont fontWithName: @"Helvetica-Bold" size: 15.0 ] ; 
		userNameText.backgroundColor = [ UIColor clearColor ] ;
		userNameText.text = @"123";
		userNameText.borderStyle=UITextBorderStyleNone;
		userNameText.layer.cornerRadius=8.0f;
		userNameText.layer.masksToBounds=YES;
		
        userNameText.backgroundColor=[UIColor redColor];
		userNameText.layer.borderColor=[[UIColor blackColor]CGColor];
		userNameText.layer.borderWidth= 1.0f;
		[userNameText setUserInteractionEnabled:true];
		
		passWordText.tag = 1;
		passWordText.textColor = [UIColor darkTextColor];
		//cellText.numberOfLines = 0;
		passWordText.font = [ UIFont fontWithName: @"Helvetica-Bold" size: 12.0 ] ; 
		passWordText.backgroundColor = [ UIColor clearColor ] ;
		passWordText.text = @"123";
		//passWordText.hidden = YES;
		
		[myContentView addSubview:userNameLabel];
		[myContentView addSubview:userNameText];
		[myContentView addSubview:passWordLabel];
		[myContentView addSubview:passWordText];
		
		
    }
    return self;
}

-(void) setLabelData
{
	[userNameLabel setText:USER_NAME];
	[passWordLabel setText:PASS_WORD];
	
}
-(void) layoutSubviews
{
	[super layoutSubviews];
	CGRect frame;
	
	frame = CGRectMake(0,30,100,30);
	[userNameLabel setFrame:frame];
	
	frame = CGRectMake(120,40,200,30);
	[userNameText setFrame:frame];
	
	frame = CGRectMake(0, 65, 100, 30);
	[passWordLabel setFrame:frame];
	
	frame = CGRectMake(120,65,200,30);
	[passWordText setFrame:frame];
	
	
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc {
	
	[userNameLabel release];
	userNameLabel = nil;
	
	[userNameText release];
	userNameText = nil;
	
	[passWordLabel release];
	passWordLabel = nil;
	
	[passWordText release];
	passWordText = nil;
	
    [super dealloc];
}


#pragma mark -
#pragma mark UIText field delgate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	return YES;
}


@end
