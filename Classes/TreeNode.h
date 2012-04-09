//
//  TreeNode.h
//  Stork
//
//  Created by Snow Leopard User on 06/03/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TreeNode : NSObject {

	TreeNode* root;
	id data;
	NSString* label;
	int nestingLevel;
	NSMutableArray* children;
	BOOL expanded;
	BOOL isVisited;
	BOOL isSelected;
}

@property (assign) TreeNode* root;
@property (assign) id data;
@property (assign) NSString* label;
@property (assign) int nestingLevel;
@property (assign) NSMutableArray* children;
@property (assign) BOOL expanded;
@property (assign) BOOL isVisited;
@property (assign) BOOL isSelected;

-(void)addChildren:(TreeNode*)child;

-(int)childrenCount;

-(void)setSelectedRecursively;
-(void)unSetRecursively;
@end
