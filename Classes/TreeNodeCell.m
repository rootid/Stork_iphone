//
//  TreeNodeCell.m
//  Stork
//
//  Created by Snow Leopard User on 06/03/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "TreeNodeCell.h"


@implementation TreeNodeCell

@synthesize onExpandedButtonTouch,owner,onCheckboxSelected;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		
    }
    return self;
}



-(void)onCheckboxSelected:(id)sender{
	
	if(owner!=nil && onCheckboxSelected!=nil){
		
		[owner performSelector:onCheckboxSelected withObject:treeNode];
	}
}
-(void)onExpandButtonTouch:(id)sender{

	if([[treeNode children] count] > 0){
		[treeNode setExpanded:![treeNode expanded]];
		
		if([treeNode expanded]==YES){
			[expandButton setImage:[UIImage imageNamed:@"minus.png"] forState:UIControlStateNormal];
		}else{
		
			[expandButton setImage:[UIImage imageNamed:@"plus.png"] forState:UIControlStateNormal];
		}
		
		if(owner!=nil && onExpandedButtonTouch!=nil){
			
			[owner performSelector:onExpandedButtonTouch withObject:treeNode];
		}
	}
}

-(void)setTreeNode:(TreeNode*)node{

	treeNode = node;

	if(label==nil){
		iconView = [[UIImageView alloc] initWithFrame:CGRectMake(50.f+(15.f*[treeNode nestingLevel]), 6.f, 32.f, 32.f)];
		label = [[UILabel alloc] initWithFrame:CGRectMake(80.f+(15.f*[treeNode nestingLevel]), 0.f, 200.f, 36.f)];
		expandButton = [[UIButton alloc] initWithFrame:CGRectMake(0.f, 5.f, 32.f, 32.f)];
		[expandButton addTarget:self action:@selector(onExpandButtonTouch:) 
			   forControlEvents:UIControlEventTouchUpInside];
		checkBoxButton = [[UIButton alloc] initWithFrame:CGRectMake(30.f, 11.f, 32.f, 32.f)];
		[checkBoxButton addTarget:self action:@selector(onCheckboxSelected:)
				 forControlEvents:UIControlEventTouchUpInside];
		[iconView setImage:[UIImage imageNamed:@"folder_small.png"]];
		
		[self addSubview:label];
		[self addSubview:iconView];
		[self addSubview:expandButton];
		[self addSubview:checkBoxButton];
	}else{
		[checkBoxButton setFrame:CGRectMake(30.f, 11.f, 32.f, 32.f)];
		[label setFrame:CGRectMake(80.f+(15.f*[treeNode nestingLevel]), 0.f, 200.f, 36.f)];
		[iconView setFrame:CGRectMake(50.f+(15.f*[treeNode nestingLevel]), 6.f, 32.f, 32.f)];
	}
	
	if([[treeNode children] count] > 0){
		if([treeNode expanded]==YES){			
			[expandButton setImage:[UIImage imageNamed:@"minus.png"] forState:UIControlStateNormal];
		}else{
			[expandButton setImage:[UIImage imageNamed:@"plus.png"] forState:UIControlStateNormal];
		}
	}else{		
		[expandButton setImage:nil forState:UIControlStateNormal];
	}

	if([treeNode isSelected] == YES){
		[checkBoxButton setImage:[UIImage imageNamed:@"checkbox-checked.png"] forState:UIControlStateNormal];
	}else{
		[checkBoxButton setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
	}
	NSLog(@"label ::: %@",[node label]);
	[label setText:[node label]];
}

-(void)drawRect:(CGRect)rect	{
	
	[super drawRect:rect];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
    [super dealloc];
}


@end
