//
//  TreeNodeCell.h
//  Stork
//
//  Created by Snow Leopard User on 06/03/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TreeNode.h"

@interface TreeNodeCell : UITableViewCell {

	TreeNode* treeNode;
	UILabel* label;
	UIImageView* iconView;
	UIButton* expandButton;
	UIButton *checkBoxButton;
	SEL onCheckboxSelected;
	SEL onExpandedButtonTouch;
	id owner;
}

@property (assign) SEL onExpandedButtonTouch;
@property (assign) SEL onCheckboxSelected;
@property (assign) id owner;


-(void)setTreeNode:(TreeNode*)node;

@end
