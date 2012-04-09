//
//  Stack.m
//  Stork
//
//  Created by Snow Leopard User on 06/03/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Stack.h"

#define STACK_SIZE 128

@implementation Stack

-(id)init{

	if(self = [super init]){
	
		head = -1;
		stack = calloc(sizeof(int), STACK_SIZE);
	}
	
	return self;
}

-(void)reset{

	head = -1;
}

-(int)pop{

	if(head==-1){
	
		return -1;
	}
	
	head--;
	return stack[head+1];
}

-(int)peek{
	
	if(head==-1){
		
		return -1;
	}
	
	return stack[head];
}

-(void)push:(int)element{

	if(head+1>=STACK_SIZE){

		NSLog(@"Stack overflow error");
		return;
	}
	head++;
	stack[head]=element;
}

@end
