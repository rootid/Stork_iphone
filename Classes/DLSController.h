//
//  DLSController.h
//  Stork
//
//  Created by Snow Leopard User on 14/03/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataAdapter.h"
#import "Tree.h"
#import "TreeNodeCell.h"
#import "Constant.h"
#import "HTTPHandler.h"

@interface DLSController : UITableViewController<HTTPHandlerDelegate> {
	
	Tree* tree;
	NSArray* elements;

}

@end
