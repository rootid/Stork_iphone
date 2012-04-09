//
//  Stack.h
//  Stork
//
//  Created by Snow Leopard User on 06/03/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Stack : NSObject {

	int* stack;
	int head;
}

-(int)pop;

-(int)peek;

-(void)reset;

-(void)push:(int)element;

@end
