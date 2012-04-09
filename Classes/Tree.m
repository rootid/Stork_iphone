//
//  Tree.m
//  Stork
//
//  Created by Snow Leopard User on 06/03/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Tree.h"


@implementation Tree

@synthesize root, currentNestingLevel;

-(id)init{

	if(self = [super init]){
	
		childrenIndexStack = [[Stack alloc] init];	
	}
	
	return self;
}

-(NSArray*)arrayRappresentation{

	NSMutableArray* result = [[NSMutableArray alloc] init];
	
	[self startTreeIteration];
	
	TreeNode* node = nil;
	while ((node=[self nextNode])!=nil) {
		
		//[node setNestingLevel:currentNestingLevel];
		[result addObject:node];
	}
	
	return result;
}

-(void)startTreeIteration{

	[childrenIndexStack reset];
	[childrenIndexStack push:0];
	currentIteratorNode = root;
	currentNestingLevel = 0;
	currentChildrenIndex = 0;
}

//	stack-based iteration
-(TreeNode*)nextNode{

	if(currentChildrenIndex==0){
	
		if([currentIteratorNode expanded]==NO){
		
			//jump up
			TreeNode* nodeToReturn = currentIteratorNode;
			currentIteratorNode = [currentIteratorNode root];
			
			if(currentIteratorNode==NULL){
				
				return nodeToReturn;
			}
			
			currentChildrenIndex = [childrenIndexStack pop];
			currentChildrenIndex++;
			currentNestingLevel--;
			[nodeToReturn setNestingLevel:currentNestingLevel+1];
			return nodeToReturn;
		}
		
		currentChildrenIndex++;
		[currentIteratorNode setNestingLevel:currentNestingLevel];
		return currentIteratorNode;
	}

	
	//return next children
	if([[currentIteratorNode children] count] >= currentChildrenIndex){
		
		[childrenIndexStack push:currentChildrenIndex];
		currentIteratorNode = [[currentIteratorNode children] objectAtIndex:currentChildrenIndex-1];
		currentChildrenIndex = 0;
		currentNestingLevel++;
		return [self nextNode];
		
	}else{
		
		//jump up
		currentIteratorNode = [currentIteratorNode root];
		
		if(currentIteratorNode==NULL){
			
			return nil;
		}
		
		currentChildrenIndex = [childrenIndexStack pop];
		currentChildrenIndex++;
		currentNestingLevel--;
		return [self nextNode];
	}
}

-(bool)hasMoreNode{

	return [childrenIndexStack peek]!=-1;
}

-(TreeNode*)findNode:(NSString*)label{
	
	[self startTreeIteration];
	
	TreeNode* node = nil;
	while ((node=[self nextNode])!=nil) {
		
		if([[node label] isEqualToString:label]){
		
			return node;
		}
	}
	
	return nil;
}

-(void)addChildren:(NSString*)label:(TreeNode*)childNode{
	
	TreeNode* rootNode = [self findNode:label];
	if(rootNode!=nil){
	
		[rootNode addChildren:childNode];
	}
}

@end
