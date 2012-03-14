//
//  DLSCellView.m
//  Stork
//
//  Created by Snow Leopard User on 14/03/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "DLSCellView.h"




@implementation DLSCellView

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		// Initialization code
		UIView *myContentView = self.contentView;
		self.shouldIndentWhileEditing = NO;
		self.accessoryType = UITableViewCellAccessoryNone;
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		
		if(folderLable == nil)
		{
			folderLable = [[UILabel alloc]initWithFrame:CGRectZero];
		}
		[folderLable setTextColor:[UIColor blackColor]];
		[folderLable setFont:[UIFont boldSystemFontOfSize:15.0]];
		[folderLable setBackgroundColor:[UIColor clearColor]];
		[folderLable setTextAlignment:UITextAlignmentLeft];
		
		[myContentView addSubview:folderLable];
		
		if(tapBoximgView == nil)
		{
			tapBoximgView = [[UIImageView alloc]initWithFrame:CGRectZero];
		}
		
		[myContentView addSubview:tapBoximgView];
    }
    return self;
}


-(void)setlblForFolder :(NSString *)txtForFolder
{
	
	[folderLable setText:txtForFolder];
}

-(void)setTapImgView :(UIImage *)img
{
	
	[tapBoximgView setImage:img];
	
	
}

-(void) layoutSubviews
{
	[super layoutSubviews];
	CGRect frame;
	
	frame = CGRectMake(10, 5, 30, 30);
	
	[tapBoximgView setFrame:frame];
	
	frame = CGRectMake(65, 15, 200, 20);
	
	[folderLable setFrame:frame];
	
	
}

- (void)dealloc {
	
	[tapBoximgView release];
	tapBoximgView=nil;
	
	[folderLable release];
	folderLable=nil;
	
    [super dealloc];
}


@end
