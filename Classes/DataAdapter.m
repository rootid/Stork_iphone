//
//  DataAdapter.m
//  Stork
//
//  Created by Snow Leopard User on 29/02/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "DataAdapter.h"
#import "Constant.h"


@implementation DataAdapter

@synthesize serverList;

- (id)init
{
	self = [super init];
	if (self != nil) {
		//TODO handle the nil condition
	}
	return self;
	
}

- (void) initializeServerList
{
	//Parse the server names
	NSString *list = SERVER_LIST;
	serverList = [list componentsSeparatedByString:@","];
	NSLog(@" thser list ");
	//arrayForFindList = [[NSArray alloc]initWithObjects:,nil];
	
}

@end
