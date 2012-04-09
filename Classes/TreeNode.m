//
//  TreeNode.m
//  Stork
//
//  Created by Snow Leopard User on 06/03/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "TreeNode.h"


@implementation TreeNode

@synthesize root,children,data,label,nestingLevel,expanded,isVisited,isSelected;;

-(id)init{
	
	if(self=[super init]){
		root = nil;
		children = nil;
		expanded = NO;
		isVisited = NO;
		isSelected = NO;
	}
	
	return self;
}

-(void)addChildren:(TreeNode*)child{
	
	if(children==nil){
		
		children = [[NSMutableArray alloc] init];
	}
	
	[child setRoot:self];
	[children addObject:child];
}

-(int)childrenCount{
	
	return [children count];
}

-(void)setSelectedRecursively {
	int index = 0;
	[self setIsSelected:YES];
	if(children != nil) {
		for(index = 0;index < [children count]; index ++) {
			TreeNode *tempNode = (TreeNode *)[children objectAtIndex:index];
			if([tempNode children] != nil) {
				NSMutableArray *dummyChildren = [tempNode children];
				if([dummyChildren count] > 0) {
					for(int inindex = 0;inindex < [dummyChildren count]; inindex ++) {
						TreeNode *tempNode1 = (TreeNode *)[dummyChildren objectAtIndex:inindex];
						[tempNode1 setIsSelected:YES];
					}
				}
			}
			[tempNode setIsSelected:YES];
		}
	}
}


-(void)unSetRecursively {
	int index = 0;
	[self setIsSelected:NO];
	if(children != nil) {
		for(index = 0;index < [children count]; index ++) {
			TreeNode *tempNode = (TreeNode *)[children objectAtIndex:index];
			[tempNode setIsSelected:NO];
			if([tempNode children] != nil) {
				NSMutableArray *dummyChildren = [tempNode children];
				if([dummyChildren count] > 0) {
					for(int inindex = 0;inindex < [dummyChildren count]; inindex ++) {
						TreeNode *tempNode1 = (TreeNode *)[dummyChildren objectAtIndex:inindex];
						[tempNode1 setIsSelected:NO];
					}
				}
			}			
		}
	}
}

@end
