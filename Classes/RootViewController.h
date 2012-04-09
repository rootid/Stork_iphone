//
//  RootViewController.h
//  TreeTableDemo
//
//  Created by simone on 9/25/09.
//  Copyright Simone Ardissone 2009. All rights reserved.
//
#import "Tree.h"
#import "TreeNodeCell.h"

@interface RootViewController : UITableViewController {

	Tree* tree;
	NSArray* elements;
}

@end
