//
//  ServerListView.m
//  Stork
//
//  Created by Snow Leopard User on 28/02/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ServerListViewCell.h"


@implementation ServerListViewCell
	
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // Initialization code
		UIView *myContentView = self.contentView;
		self.shouldIndentWhileEditing = NO;
		self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		if(serverNameLable == nil)
		{
			serverNameLable = [[UILabel alloc]initWithFrame:CGRectZero];
		}
		[serverNameLable setTextColor:[UIColor blackColor]];
		[serverNameLable setFont:[UIFont boldSystemFontOfSize:15.0]];
		[serverNameLable setBackgroundColor:[UIColor clearColor]];
		[serverNameLable setTextAlignment:UITextAlignmentLeft];
		
		[myContentView addSubview:serverNameLable];
    }
    return self;
	
}


-(void)setServerNameLabel :(NSString *)serverNamelbl
{
	[serverNameLable setText:serverNamelbl];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}

-(void) layoutSubviews
{
	[super layoutSubviews];
	CGRect frame;
	
	frame = CGRectMake(10, 5, 200, 30);
	
	[serverNameLable setFrame:frame];

}
- (void)dealloc {
	
	[serverNameLable release];
	serverNameLable = nil;
	
    [super dealloc];
}


@end
